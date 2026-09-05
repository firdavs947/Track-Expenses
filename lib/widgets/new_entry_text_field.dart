import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:track_expenses/consts/colors/app_colors.dart';
import 'package:track_expenses/gen/assets.gen.dart';

class NewEntryTextField extends StatelessWidget {
  const NewEntryTextField({super.key, required this.controller});
  final TextEditingController   controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      style: TextStyle(
        fontSize: 56,
        fontWeight: FontWeight.w600,
        fontFamily: 'Jet',
      ),
      cursorColor: AppColors.black,
      cursorHeight: 65,
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: const EdgeInsets.all(15),
          child: SvgPicture.asset(Assets.icons.text),
        ),
        hintText: '0.00',
        hintStyle: TextStyle(
          fontSize: 56,
          fontWeight: FontWeight.w600,
          fontFamily: 'Jet',
        ),
        enabledBorder: UnderlineInputBorder(borderSide: BorderSide.none),
        border: UnderlineInputBorder(borderSide: BorderSide.none),
        disabledBorder: UnderlineInputBorder(borderSide: BorderSide.none),
      ),
    );
  }
}
