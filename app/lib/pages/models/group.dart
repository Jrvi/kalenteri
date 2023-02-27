//importtauksena firebase?
//Tänne ominaisuudet, joita ryhmään liittyy
class Group {
  final String id;
  final String name;
  final String leader;
  List<String> members;

  Group({
    required this.id,
    required this.name,
    required this.leader,
    required this.members,
  });
}
