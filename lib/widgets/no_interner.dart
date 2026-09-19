import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:track_expenses/consts/colors/app_colors.dart';
import 'package:track_expenses/main.dart';

class NoInterner extends StatelessWidget {
  const NoInterner({super.key});
  static widgetnikorsatish() {
    
    showModalBottomSheet(context: navigatorkey.currentState!.context,
    enableDrag: false,
    isDismissible: false,
    isScrollControlled: false,
     builder: (context) => NoInterner());
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
            canPop: false,

      child: Container(
        width: double.infinity,
        height: 1500,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Connection Lost try again!'),
              IconButton(
                onPressed: () {
                  openAppSettings();
                },
                icon: Icon(Icons.connect_without_contact),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
