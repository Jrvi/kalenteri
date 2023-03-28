import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:vapaat/pages/models/event.dart';
import 'package:vapaat/pages/models/friend.dart';
import 'package:vapaat/pages/models/localuser.dart';
import 'package:vapaat/pages/models/group.dart';

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

  static void getLocalUser() async {
    final user = FirebaseAuth.instance.currentUser!;
    DatabaseReference ref = database.ref();
    final DataSnapshot data = await ref.child("/users/${user.uid}").get();
    final value = data.value as Map<dynamic, dynamic>;
    localUser = LocalUser(
        imagePath: value["profile_picture"].toString(),
        name: value["username"].toString(),
        email: value["email"].toString());
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

  ///Get list of friends from database
  /// [user] is the user who is getting the friends
  /// Returns list of Friend objects
  // ignore: todo
  /// TODO: This should be changed to return Future<List<Friend>>
  static Future<List<Friend>> getFriends() async {
    List<Friend> friends = [];
    final user = FirebaseAuth.instance.currentUser!;
    DatabaseReference ref = database.ref('users/${user.uid}/friends/');
    final snapshot = await ref.get();
    if (snapshot.value != null) {
      final Map<dynamic, dynamic> friendList =
          snapshot.value as Map<dynamic, dynamic>;
      friendList.forEach((key, value) {
        Friend friend = Friend(
          name: value['name'],
          imagePath: value['imagePath'] ?? 'https://picsum.photos/200',
          email: value['email'] ?? '',
        );
        friends.add(friend);
      });
    }
    return friends;
  }

  ///Delete friend from user's friend list
  static void delFriend(Friend friend) {}

  /// Retrieves a list of groups belonging to the currently logged in user from the Firebase Realtime Database.
  /// Returns a Future containing a list of [Group] objects.
  static Future<List<Group>> getGroups() async {
    List<Group> groups = [];
    final user = FirebaseAuth.instance.currentUser!;
    DatabaseReference ref = database.ref('groups/${user.uid}/');
    final snapshot = await ref.get();
    if (snapshot.value != null) {
      final Map<dynamic, dynamic> groupList =
          snapshot.value as Map<dynamic, dynamic>;
      groupList.forEach((key, value) {
        Group group = Group(
          id: key,
          name: value['name'],
          members: List<String>.from(value['members']),
        );
        groups.add(group);
      });
    }
    return groups;
  }
}
