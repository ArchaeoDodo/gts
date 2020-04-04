import 'dart:math';

import 'package:guess_the_song/GUI/lobby.dart';

Random _random = new Random();
int min = 0;
int max = 1000000;

int random() {
  id = min + _random.nextInt(max - min);
  return id;
}
