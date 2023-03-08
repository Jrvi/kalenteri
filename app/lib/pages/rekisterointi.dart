import 'package:flutter/material.dart';

class Rekisterointi extends StatefulWidget {
  const Rekisterointi({super.key});

  @override
  State<Rekisterointi> createState() => _RekisterointiState();
}

class _RekisterointiState extends State<Rekisterointi> {
  final _formKey = GlobalKey<FormState>();

  // Kontrollerit
  final nimiController = new TextEditingController();
  final sahkopostiController = new TextEditingController();
  final salasanaController = new TextEditingController();
  final vahvistusController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Käyttäjänimikenttä
    final nimiKentta = TextFormField(
      autofocus: false,
      controller: nimiController,
      keyboardType: TextInputType.name,
      onSaved: (value) {
        nimiController.text = value!;
      },
      // Mitä tapahtuu kun painaa näppäimistön oikeasta alakulmasta (se OK/Next/Enter -näppäin)
      textInputAction: TextInputAction.next,

      // Muotoilua
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.account_circle),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: 'Käyttäjänimi',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
    );

    // Sähköpostikenttä
    final sahkoPostiKentta = TextFormField(
      autofocus: false,
      controller: sahkopostiController,
      keyboardType: TextInputType.emailAddress,
      onSaved: (value) {
        sahkopostiController.text = value!;
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
      obscureText: true,
      onSaved: (value) {
        salasanaController.text = value!;
      },
      // Mitä tapahtuu kun painaa näppäimistön oikeasta alakulmasta (se OK/Next/Enter -näppäin)
      textInputAction: TextInputAction.next,

      // Muotoilua
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.password),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: 'Salasana',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
    );

    // Salasananvahvistuskenttä
    final vahvistusKentta = TextFormField(
      autofocus: false,
      controller: vahvistusController,
      obscureText: true,
      onSaved: (value) {
        vahvistusController.text = value!;
      },
      // Mitä tapahtuu kun painaa näppäimistön oikeasta alakulmasta (se OK/Next/Enter -näppäin)
      textInputAction: TextInputAction.next,

      // Muotoilua
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.password),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: 'Vahvista salasana',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
    );

    // Rekisteröidy -nappi
    final signUpButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.blue,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {},
        child: Text(
          'Rekisteröidy',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
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
                    nimiKentta,
                    SizedBox(height: 15),
                    sahkoPostiKentta,
                    SizedBox(height: 15),
                    salasanaKentta,
                    SizedBox(height: 15),
                    vahvistusKentta,
                    SizedBox(height: 15),
                    signUpButton,
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
