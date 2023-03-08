import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  // Kontrollerit
  final TextEditingController sahkoPostiController = TextEditingController();
  final TextEditingController salasanaController = TextEditingController();

  // Firebase
  final _auth = FirebaseAuth.instance;

  // Error viesti
  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    // Sähköpostikenttä
    final sahkoPostiKentta = TextFormField(
      autofocus: false,
      controller: sahkoPostiController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return ('Anna sähköpostiosoite');
        }

        // Tarkastetaan sähköpostiosoite. Saa muuttaa, jos tietään paremman tavan :D
        // Tässä versiossa tarkastetaan osoite outojen merkkien varalta
        if (!RegExp('^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]').hasMatch(value)) {
          return ('Anna oikeanlainen sähköpostiosoite');
        }
        return null;
      },
      onSaved: (value) {
        sahkoPostiController.text = value!;
      },
      // Mitä tapahtuu kun painaa näppäimistön oikeasta alakulmasta (se OK/Next/Enter -näppäin)
      textInputAction: TextInputAction.next,

      // Muotoilua
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.email),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: 'Sähköposti',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
    );

    // Salasanakenttä
    final salasanaKentta = TextFormField(
      autofocus: false,
      controller: salasanaController,
      obscureText: true, // Piilotetaan salasana
      validator: (value) {
        RegExp regex = new RegExp(r'^.{8,}$');
        if (value!.isEmpty) {
          return ('Anna salasana');
        }
        if (!regex.hasMatch((value))) {
          return ('Salsanassa oltava vähintään 8 merkkiä');
        }
      },
      onSaved: (value) {
        salasanaController.text = value!;
      },
      // Mitä tapahtuu kun painaa näppäimistön oikeasta alakulmasta (se OK/Next/Enter -näppäin)
      textInputAction: TextInputAction.done,

      // Muotoilua
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.password),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: 'Salasana',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
    );

    // Login -nappi
    final loginButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.blue,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          // Navigator.of(context).pushNamed('/main', arguments: 'main');
          signIn(sahkoPostiController.text, salasanaController.text);
        },
        child: Text(
          'Kirjaudu',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );

    // Rekisteröidy -teksti
    final rekisterointi = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'Ei tiliä? ',
          style: TextStyle(fontSize: 15),
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context)
                .pushNamed('/rekisterointi', arguments: 'rekisterointi');
          },
          child: Text(
            'Rekisteröidy',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 15, color: Colors.blue),
          ),
        )
      ],
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    // TODO: Logo =)
                    // SizedBox(
                    //   height: 200,
                    //   child: Image.asset('polku/kuvan/sijaintiin.png',
                    //   fit: BoxFit.contain,),
                    // ),
                    //SizedBox(height: 15),
                    sahkoPostiKentta,
                    SizedBox(height: 15),
                    salasanaKentta,
                    SizedBox(height: 15),
                    loginButton,
                    SizedBox(height: 15),
                    rekisterointi,
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Kirjautuminen
  void signIn(String sahkoposti, String salasana) async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth
            .signInWithEmailAndPassword(email: sahkoposti, password: salasana)
            .then((uid) => {
                  Navigator.of(context).pushNamed('/main', arguments: 'main'),
                });
      } on FirebaseAuthException catch (e) {
        switch (e.message) {
          case "invalid-email":
            errorMessage = "Your email address appears to be malformed.";
            break;
          case "wrong-password":
            errorMessage = "Your password is wrong.";
            break;
          case "user-not-found":
            errorMessage = "User with this email doesn't exist.";
            break;
          case "user-disabled":
            errorMessage = "User with this email has been disabled.";
            break;
          case "too-many-requests":
            errorMessage = "Too many requests";
            break;
          case "operation-not-allowed":
            errorMessage = "Signing in with Email and Password is not enabled.";
            break;
          default:
            errorMessage = "An undefined Error happened.";
          // e.message voi olla mallia:
          // "There is no user record corresponding to this identifier. The user may have been deleted."
          // Eli ylempi try...catch lause voi olla turha -> TODO: Tarkista onko välttämätön
          // print(e.message);
        }
        final error = SnackBar(content: Text(errorMessage!));
        ScaffoldMessenger.of(context).showSnackBar(error);
      }
    }
  }
}
