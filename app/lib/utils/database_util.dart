import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:vapaat/pages/models/event.dart';
import 'package:vapaat/pages/models/localuser.dart';

class DatabaseUtil {
  static FirebaseDatabase database = FirebaseDatabase.instance;
  static final user = FirebaseAuth.instance.currentUser!;

  /// Adds Event to database
  /// example for path "events/uid/14-3_19-20" first two numbers are day and month second two are start hour and end hour
  static Future<void> addEvent(Event event) async {
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
    DatabaseReference ref = database.ref("/users/${user.uid}");
    await ref.set({
      "email": user.email.toString(),
      "username": "testi",
      "profile_picture": "imageUrl"
    });
  }

  static void updateUser(LocalUser user) {}
}
