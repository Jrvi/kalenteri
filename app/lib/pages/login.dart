import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vapaat/widgets/button_widget.dart';

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
          return ('Enter an email address');
        }

        // Checking the email. Feel free to change if oyu know a better way :D
        // This version checks the string for 'weird' characters
        if (!RegExp('^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]').hasMatch(value)) {
          return ('Enter a valid email address');
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
          hintText: 'Email',
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
        RegExp regex = RegExp(
            r'^.{8,}$'); // Making sure the password is at least 8 characters long. TODO:
        if (value!.isEmpty) {
          return ('Insert password');
        }
        if (!regex.hasMatch((value))) {
          return ('Password must at least 8 characters long');
        }
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
          hintText: 'Password',
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
          'No account? ',
          style: TextStyle(fontSize: 15),
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed('/register', arguments: 'register');
          },
          child: Text(
            'Register',
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
                  // SizedBox(
                  //   height: 200,
                  //   child: Image.asset('polku/kuvan/sijaintiin.png',
                  //   fit: BoxFit.contain,),
                  // ),
                  //SizedBox(height: 15),
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
          // e.message is something like:
          // "There is no user record corresponding to this identifier. The user may have been deleted."
          // So the try...catch might be uselee -> TODO: Check if try...catch is necessary
          // print(e.message);
        }
        final error = SnackBar(content: Text(errorMessage!));
        ScaffoldMessenger.of(context).showSnackBar(error);
      }
    }
  }
}
