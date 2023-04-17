import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vapaat/pages/models/localUser.dart';
import 'package:vapaat/utils/database_utils.dart';
import 'package:vapaat/widgets/button_widget.dart';

import '../properties.dart';

class Rekisterointi extends StatefulWidget {
  const Rekisterointi({super.key});

  @override
  State<Rekisterointi> createState() => _RekisterointiState();
}

class _RekisterointiState extends State<Rekisterointi> {
  final _authKey = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // User name field
    final nameField = TextFormField(
      autofocus: false,
      controller: nameController,
      keyboardType: TextInputType.name,
      validator: (value) {
        RegExp regex = RegExp(r'^.{2,}$');
        if (value!.isEmpty) {
          return ('Username can not be empty');
        }
        if (!regex.hasMatch((value))) {
          return ('Name must be 2 letters or longer');
        }
      },
      onSaved: (value) {
        nameController.text = value!;
      },
      // What happens when you press the bottom right button (OK/Next/Enter)
      textInputAction: TextInputAction.next,

      // Muotoilua
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.account_circle),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: 'User name',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
    );

    // Email field
    final emailField = TextFormField(
      autofocus: false,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return ('Enter an email address');
        }

        // Checking the email. Feel free to change if you know a better way :D
        // This version checks the string for 'weird' characters
        if (!RegExp('^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]').hasMatch(value)) {
          return ('Enter a valid email address');
        }
        return null;
      },
      onSaved: (value) {
        emailController.text = value!;
      },
      //  What happens when you press the bottom right button (OK/Next/Enter)
      textInputAction: TextInputAction.next,

      // Decoration
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.email),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: 'Email',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
    );

    // Password field
    final passwordField = TextFormField(
      autofocus: false,
      controller: passwordController,
      obscureText: true,
      validator: (value) {
        if (value!.isEmpty) {
          return (login_password_hint);
        }
        if (value.length < password_length) {
          return (login_password_hint2);
        }
      },
      onSaved: (value) {
        passwordController.text = value!;
      },
      //  What happens when you press the bottom right button (OK/Next/Enter)
      textInputAction: TextInputAction.next,

      // Decoration
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.password),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: 'Password',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
    );

    // Confirm password field
    final confirmPassword = TextFormField(
      autofocus: false,
      controller: confirmController,
      obscureText: true,
      validator: (value) {
        if (confirmController.text != passwordController.text) {
          return 'Passwords do not match';
        }
        return null;
      },
      onSaved: (value) {
        confirmController.text = value!;
      },
      //  What happens when you press the bottom right button (OK/Next/Enter)
      textInputAction: TextInputAction.next,

      // Decoration
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.password),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: 'Confirm Password',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
    );

    // Register button
    final signUpButton = ButtonWidget(
        text: 'Register',
        onClicked: () {
          addUser(emailController.text, passwordController.text,
              nameController.text);
        });

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
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
                  nameField,
                  SizedBox(height: 15),
                  emailField,
                  SizedBox(height: 15),
                  passwordField,
                  SizedBox(height: 15),
                  confirmPassword,
                  SizedBox(height: 15),
                  signUpButton,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Adding user to authenticated users
  // TODO: Handle errors
  void addUser(String email, String password, String name) async {
    if (_formKey.currentState!.validate()) {
      await _authKey
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {
                _authKey.currentUser?.updateDisplayName(nameController.text),
                _authKey.currentUser
                    ?.updatePhotoURL("https://picsum.photos/200"),
                Navigator.of(context).pushNamed('/main', arguments: 'main')
              })
          .catchError((e) {
        // switch (e.code) {
        // case "wrong-password":
        //   errorMessage = "Wrong email or password.";
        //   break;
        // default:
        //   errorMessage = "An undefined Error happened.";
        print('Error message: $e');
        // print('Error code: ${e.code}');
        final error = SnackBar(content: Text(e!));
        ScaffoldMessenger.of(context).showSnackBar(error);
      });
      addUserToDB(name, email);
    }
  }

  // Adding new user to database
  addUserToDB(String name, String email) {
    LocalUser user = LocalUser(
        imagePath: 'https://picsum.photos/200?random=${email.hashCode}',
        name: name,
        email: email);
    DatabaseUtil.addUserToDB(user);
  }
}
