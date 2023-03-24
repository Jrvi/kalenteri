import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vapaat/pages/models/event.dart';
import 'package:vapaat/pages/models/friend.dart';
import 'package:vapaat/pages/models/localuser.dart';

class DatabaseUtil {
  static FirebaseDatabase database = FirebaseDatabase.instance;
  static LocalUser? localUser;
  //static final user = FirebaseAuth.instance.currentUser!;

  /// Adds Event to database
  /// example for path "events/uid/14-3_19-20" first two numbers are day and month second two are start hour and end hour
  static Future<void> addEvent(Event event) async {
    final user = FirebaseAuth.instance.currentUser!;
    DatabaseReference ref = database.ref(
        "/events/${user.uid}/${event.start.day}-${event.start.month}_${event.start.hour}-${event.end.hour}");
    await ref.set({
      "userid": user.uid.toString(),
      "start": event.start.toString(),
      "end": "${event.end}",
    });
  }

  /// Deletes Event from database
  static void delEvent(Event event) {}

  /// Gets list of Events from data place and return it
  /*List<Event> getEvents (LocalUser localuser) {
    return
  }*/

  /// Adds new user to database
  static Future<void> addUserToDB(LocalUser localuser) async {
    final user = FirebaseAuth.instance.currentUser!;
    DatabaseReference ref = database.ref("/users/${user.uid}");
    await ref.set({
      "email": user.email.toString(),
      "username": localuser.name,
      "profile_picture": localuser.imagePath
    });
  }

  // Täs pitäis ottaa myös huomioon FirebaseAuthin user, että voi olla järkevämpää, että vaihdetaan siihen.
  static void updateUser(LocalUser user) {}

  static void getLocalUser() {
    final user = FirebaseAuth.instance.currentUser!;
    DatabaseReference ref = database.ref();
    final data = ref.child("/users/${user.uid}").get();
    data.then((value) => localUser = LocalUser(
        imagePath: value.child("profile_picture/").value.toString(),
        name: value.child("username/").value.toString(),
        email: value.child("email/").value.toString()));
  }

  ///Add new friend to user's friend list
  /// [email] is email of a friend that will be added user's friend
  Future<void> addFriend(String email) async {
    final user = FirebaseAuth.instance.currentUser!;
    try {
      // Query the users collection for the friend's email
      final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: email)
          .get();
      if (querySnapshot.docs.isEmpty) {
        // Friend with the provided email not found
        throw Exception('No user found with email $email');
      } else {
        final friendDoc = querySnapshot.docs[0];
        final friendUid = friendDoc.id;

        // Add friendUid to the user's friend list
        final userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();
        final currentFriends = List.from(userDoc.data()!['friends']);
        if (currentFriends.contains(friendUid)) {
          throw Exception('$email is already a friend');
        } else {
          currentFriends.add(friendUid);
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .update({'friends': currentFriends});

          // Add the user's uid to friendUid's friend list
          final Map<String, dynamic>? friendData =
              friendDoc.data() as Map<String, dynamic>?;
          final friendFriends = friendData != null
              ? List.from(friendData['friends'] as List<dynamic>)
              : [];
          friendFriends.add(user.uid);
          await FirebaseFirestore.instance
              .collection('users')
              .doc(friendUid)
              .update({'friends': friendFriends});
        }
      }
    } catch (e) {
      throw Exception('Failed to add friend: $e');
    }
  }

  static Future<List<Friend>> getFriends() async {
    List<Friend> friends = [];
    final user = FirebaseAuth.instance.currentUser!;
    DatabaseReference ref = database.ref('users/${user.uid}/friends/');
    final snapshot = await ref.get();
    for (var friend in snapshot.children) {
      var data = friend.value.toString().split(",");
      var imagePath = data[0].split(" ");
      var name = data[1].split(" ");
      var email = data[2].split(" ");
      String emailString = email[2].substring(0, email[2].length - 1);
      var friendObject =
          Friend(name: name[2], email: emailString, imagePath: imagePath[1]);
      friends.add(friendObject);
    }
    return friends;
  }
}
