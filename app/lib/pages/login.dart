import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vapaat/widgets/button_widget.dart';
import 'package:vapaat/properties.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Firebase
  final _auth = FirebaseAuth.instance;

  // Error message
  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    // Email field
    final emailField = TextFormField(
      autofocus: false,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return (login_email_hint);
        }

        // Checking the email. Feel free to change if you know a better way :D
        // This version checks the string for 'weird' characters
        if (!RegExp('^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]').hasMatch(value)) {
          return (login_email_error);
        }
        return null;
      },
      onSaved: (value) {
        emailController.text = value!;
      },
      // What happens when you press the bottom right button (OK/Next/Enter)
      textInputAction: TextInputAction.next,

      // Decoration
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.email),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: login_email,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
    );

    // Password field
    final passwordField = TextFormField(
      autofocus: false,
      controller: passwordController,
      obscureText: true, // Hiding the password
      validator: (value) {
        // Why would we check for password length? Only message should be about the password being empty or invalid.
        // RegExp regex = RegExp(r'^.{8,}$');
        if (value!.isEmpty) {
          return (login_password_hint);
        }
        // if (!regex.hasMatch((value))) {
        //   return (login_password_hint2);
        // }
      },
      onSaved: (value) {
        passwordController.text = value!;
      },
      // What happens when you press the bottom right button (OK/Next/Enter)
      textInputAction: TextInputAction.done,

      // Decoration
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.password),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: login_password,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
    );

    // Login button using our very own button widget :)
    final loginButton = ButtonWidget(
        text: 'Sign in',
        onClicked: () {
          signIn(emailController.text, passwordController.text);
        });

    // Register account text
    final register = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          login_no_account,
          style: TextStyle(fontSize: 15),
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed('/register', arguments: 'register');
          },
          child: Text(
            login_register,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
        )
      ],
    );

    return Scaffold(
      // backgroundColor: Colors.white,
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
                  SizedBox(
                    height: 200,
                    child: Image.asset(
                      'assets/logo1.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(height: 15),
                  emailField,
                  SizedBox(height: 15),
                  passwordField,
                  SizedBox(height: 15),
                  loginButton,
                  SizedBox(height: 15),
                  register,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Signing in
  void signIn(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth
            .signInWithEmailAndPassword(email: email, password: password)
            .then((uid) => {
                  Navigator.of(context).pushNamed('/main', arguments: 'main'),
                });
      } on FirebaseAuthException catch (e) {
        switch (e.code) {
          // Mabe we shouldn't give the person loggin in too much information on whether the password or email is wrong.
          // Could the first two messages be shown underneath the text fields, kind of like in the validator?
          case "wrong-password":
            errorMessage = "Wrong email or password.";
            break;
          case "user-not-found":
            errorMessage = "Wrong email or password.";
            break;
          case "network-request-failed":
            errorMessage = "Unable to connect to the internet.";
            break;
          case "too-many-requests":
            errorMessage = "Too many login attempts. Try again later.";
            break;
          default:
            errorMessage = "An undefined Error happened.";
          // print('Error message: ${e.message}');
          // print('Error code: ${e.code}');
        }
        final error = SnackBar(content: Text(errorMessage!));
        ScaffoldMessenger.of(context).showSnackBar(error);
      }
    }
  }
}
