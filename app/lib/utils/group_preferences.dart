import 'package:app/pages/models/group.dart';
import 'package:flutter/material.dart';

class GroupPreferences {
  static var modelgroup = Group(
      //malliryhmän tiedot
      id: 'r000000',
      name: 'Malliryhmä',
      members: [
        'Ukko Tikku',
        'Mallikaveri',
        'Mallikaveri2',
        'Mallikaveri3',
        'mallikaveri4',
        'malli5'
      ]);
  static var modelgroup2 = Group(
      //malliryhmän tiedot
      id: 'r000001',
      name: 'Meikäläiset',
      members: ['Joku', 'Matti Meikäläinen', 'Maija Meikäläinen']);

  static var modelgroup3 = Group(
      //malliryhmän tiedot
      id: 'r000002',
      name: 'Pronominit',
      members: ['Sinä', 'Minä', 'hän']);
}
