//Tänne ominaisuudet, joita käyttäjän profiiliin liittyy
class LocalUser {
  final String imagePath;
  final String name;
  final String email;

  const LocalUser({
    required this.imagePath,
    required this.name,
    required this.email,
  });
}
