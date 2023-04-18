import 'package:firebase_auth/firebase_auth.dart';

import 'package:vapaat/pages/models/localUser.dart';

class UserPreferences {
  static LocalUser getUser() {
    final user = FirebaseAuth.instance.currentUser!;
    var newUser = LocalUser(
        name: user.displayName.toString(), email: user.email.toString());
    return newUser;
  }
}
