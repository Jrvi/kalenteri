# kalenteri
Mobiiledevauskurssin repo

## viikkopalaverit
viikottain torstaina klo. 16.15

## kotitehtävä1
Tavoitteet: Saada appi kauppaan
Käyttäjät: Opiskelijat
Alusta: Mobiili (android, ios) ehkä työpöytä sovellus
Aikaikkuna: 3kk (kurssi)

## Feature list
-kirjautuminen
-kalenteri synkkaus
-ryhmät
-kaverit

## Git ohjeet
Luokaa jokaiselle uudelle ominaisuudelle oma haara.
git branch -> antaa listan  sun aikaisemmista haaroista
git checkout/branch "haaran nimi" -> vaihtaa tai luo uuden.

git add --all
git commit -m "yritä kuvailla parhaan mukaa"
git status -> näkee mitkä on lisätty
git push

git merge -> vasta  testauksen jälkeen.

## Github
Pushin jälkeen luokaa pull request, johon laitetta muut tarkastamaan koodinne ennen merge toimintoa

## Flutter
Esimerkki page, joka sisältää nappulan
```
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kalenteri'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('nappula :D'),
        ),
      ),
    );
    throw UnimplementedError();
  }
}
```

