//Ominaisuudet, jotka ryhmästä pitää tallentaa
class Group {
  final String id;
  String name;
  final List<String> members; //Joku muu tunniste kavereista, kuin nimi, esim id

  Group({required this.id, required this.name, required this.members});
}
