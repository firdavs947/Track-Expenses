import 'dart:math';

import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {
  final double balance = Random().nextInt(99001) + 1000; // от 1000 до 100000

}
