class Friend {
  final String name;
  var imagePath;
  Friend({required this.name, this.imagePath});
}

List<Friend> getFriends() {
  return [
    Friend(name: 'kamu', imagePath: 'https://picsum.photos/200'),
    Friend(name: 'Kaveri'),
    Friend(name: 'friend'),
    Friend(name: 'ystävä'),
    Friend(name: 'kamu'),
    Friend(name: 'kamu'),
    Friend(name: 'kamu'),
    Friend(name: 'kamu'),
  ];
}
