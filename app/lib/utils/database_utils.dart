import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
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
  /// [friend] is Friend object that will be added user's friend list
  /// [user] is the user who is adding the friend
  static Future<void> addFriend(Friend friend) async {
    final user = FirebaseAuth.instance.currentUser!;
    DatabaseReference ref = database.ref('users/${user.uid}/friends');

    final data = {
      'name': friend.name,
      'email': friend.email,
      'imagePath': friend.imagePath,
    };

    await ref.push().set(
        data); //push() creates a new child node; without it this only saves one friend at the time
  }

  /**
   * // Retrieve the current user's ID from Firebase Authentication
final currentUserUid = FirebaseAuth.instance.currentUser.uid;

// Retrieve the entered email address from a form or text input field
final email = 'example@example.com';

// Check if a user with the entered email address exists in the "users" node
final snapshot = await FirebaseDatabase.instance.reference().child('users').orderByChild('email').equalTo(email).once();
if (snapshot.value != null) {
  // Retrieve the user ID of the user with the entered email address
  final friendUid = snapshot.value.keys.first;

  // Add the friend's user ID to the current user's "friends" node
  await FirebaseDatabase.instance.reference().child('users').child(currentUserUid).child('friends').child(friendUid).set(true);

  // Add the current user's user ID to the friend's "friends" node
  await FirebaseDatabase.instance.reference().child('users').child(friendUid).child('friends').child(currentUserUid).set(true);
}
   */

  ///Get list of friends from database
  /// [user] is the user who is getting the friends
  /// Returns list of Friend objects
  /// TODO: This should be changed to return Future<List<Friend>>
  static Future<List<Friend>> getFriends(friendDataList) async {
    return []; //TODO return the real list of friends or empty list, now just fake data
  }

  ///Delete friend from user's friend list
  static void delFriend(Friend friend) {}
}
