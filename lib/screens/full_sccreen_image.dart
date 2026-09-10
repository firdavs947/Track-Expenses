import 'dart:io';

import 'package:flutter/material.dart';
import 'package:track_expenses/consts/colors/app_colors.dart';

class FullSccreenImage extends StatelessWidget {
  const FullSccreenImage({super.key, required this.rasm});
  final File rasm;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: AppColors.white,),
        ),
        backgroundColor: AppColors.black,
      ),
      body: Center(child: Hero(
        tag: 'rasm1',
        child: Image.file(rasm, fit: BoxFit.cover))),
    );
  }
}
