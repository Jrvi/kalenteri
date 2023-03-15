import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:vapaat/pages/models/localuser.dart';

class UserPreferences {
  static const myUser = LocalUser(
      //Kuvaksi tulevaisuudessa sovelluksen logo?
      imagePath: 'https://picsum.photos/200',
      //Nimiksi tulevaisuudessa sovelluksen käyttäjän nimi
      name: 'Ukko Tikku',
      email: 'ukkotikku@email.com');

  static LocalUser getUser() {
    final _user = FirebaseAuth.instance.currentUser!;
    var newUser = LocalUser(
        imagePath: "https://picsum.photos/200",
        name: myUser.name,
        email: _user.email.toString());
    return newUser;
  }
}
