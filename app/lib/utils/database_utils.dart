import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:vapaat/pages/models/event.dart';
import 'package:vapaat/pages/models/friend.dart';
import 'package:vapaat/pages/models/localUser.dart';

class DatabaseUtil {
  static FirebaseDatabase database = FirebaseDatabase.instance;
  static LocalUser? localUser;
  static List<Event> ownEvents = [];
  static List<Event> friendsEvents = [];
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

  static void clearEvents() {
    ownEvents.clear();
    friendsEvents.clear();
  }

  /// Deletes Event from database
  static void delEvent(Event event) {}

  /// Gets list of Events from data place and return it
  static List<Event> getOwnEvents() {
    final user = FirebaseAuth.instance.currentUser!;
    DatabaseReference ref = database.ref();
    final data = ref.child("/events/${user.uid}/").get();
    data.then((value) => {
          for (var event in value.children)
            {
              ownEvents.add(Event(
                  start: DateTime.parse(event.child("start").value.toString()),
                  end: DateTime.parse(event.child("end").value.toString()))),
            }
        });
    return ownEvents;
  }

  static List<Event> getFriendsEvents() {
    final friends = DatabaseUtil.getFriends();
    var data;
    DatabaseReference ref = database.ref();
    friends.then((friends) => {
          for (var friend in friends)
            {
              data = ref.child("events/${friend.uid}/").get(),
              data.then((events) => {
                    for (var event in events.children)
                      {
                        friendsEvents.add(
                          Event(
                              start: DateTime.parse(
                                  event.child("start").value.toString()),
                              end: DateTime.parse(
                                  event.child("end").value.toString())),
                        )
                      }
                  })
            }
        });
    return friendsEvents;
  }

  /// Adds new user to database
  static Future<void> addUserToDB(LocalUser localuser) async {
    final user = FirebaseAuth.instance.currentUser!;
    DatabaseReference ref = database.ref("/users/${user.uid}");
    await ref.set({"email": user.email.toString(), "username": localuser.name});
  }

  // Täs pitäis ottaa myös huomioon FirebaseAuthin user, että voi olla järkevämpää, että vaihdetaan siihen.
  static void updateUser(LocalUser user) {}

  static void getLocalUser() {
    final user = FirebaseAuth.instance.currentUser!;
    DatabaseReference ref = database.ref();
    final data = ref.child("/users/${user.uid}").get();
    data.then((value) => localUser = LocalUser(
        name: value.child("username/").value.toString(),
        email: value.child("email/").value.toString()));
  }

  // Queries for the user using an email address
  // Returns a Future<Friend> (use "await" to get "Friend" :] )
  static Future<Friend> getUserByEmail(String email) async {
    DatabaseReference db = database.ref().child('users/');
    DataSnapshot snapshot = await db.orderByChild('email').equalTo(email).get();
    Friend friend = Friend(
        name: snapshot.children.first.child('username').value.toString(),
        email: email,
        uid: snapshot.children.first.key);
    return friend;
  }

  ///Add new friend to user's friend list
  /// [friend] is Friend object that will be added user's friend list
  /// [user] is the user who is adding the friend
  static Future<void> addFriend(Friend friend) async {
    final user = FirebaseAuth.instance.currentUser!;
    DatabaseReference ref = database.ref('users/${user.uid}/friends/');

    final data = {
      'name': friend.name,
      'email': friend.email,
      'uid': friend.uid,
    };

    await ref.child('${friend.uid}').set(data);
  }

  ///Get list of friends from database
  /// [user] is the user who is getting the friends
  /// Returns list of Friend objects
  /// TODO: This should be changed to return Future<List<Friend>>
  static Future<List<Friend>> getFriends() async {
    List<Friend> friends = [];
    final user = FirebaseAuth.instance.currentUser!;
    DatabaseReference ref = database.ref('users/${user.uid}/friends/');
    final snapshot = await ref.get();
    for (var friend in snapshot.children) {
      var data = friend.value.toString().split(",");
      var uid = data[0].split(" ");
      var name = data[1].split(" ");
      var email = data[2].split(" ");
      String emailString = email[2].substring(0, email[2].length - 1);
      var friendObject = Friend(uid: uid[1], name: name[2], email: emailString);
      friends.add(friendObject);
    }
    return friends;
  }

  ///Delete friend from user's friend list
  static void deleteFriend(String? friendUID) {
    final user = FirebaseAuth.instance.currentUser!;
    DatabaseReference ref = database.ref('users/${user.uid}/friends/');
    ref.child('$friendUID').remove();
  }

  ///Delete friend from user's friend list
  static void deleteEvent(String? day, String? month) {
    final user = FirebaseAuth.instance.currentUser!;
    DatabaseReference ref = database.ref('events/${user.uid}/');
    String joo = '$day-$month';
    ref.orderByKey().startAt(joo).endAt("$joo\uf8ff").get().then((snapshot) {
      for (var element in snapshot.children) {
        ref.child('${element.key}').remove();
      }
    });
  }
}
