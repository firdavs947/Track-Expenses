import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:track_expenses/consts/colors/app_colors.dart';
import 'package:track_expenses/screens/full_video_screen.dart';
import 'package:track_expenses/widgets/no_interner.dart';

class Addfunds extends StatelessWidget {
  const Addfunds({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 16,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FadeIn(
          delay: Duration(milliseconds: 600),
          duration: Duration(milliseconds: 800),

          child: ZoomIn(
            delay: Duration(milliseconds: 600),
            duration: Duration(milliseconds: 800),
            child: InkWell(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>FullVideoScreen())),
              child: Container(
                // height: 35,
                // width: 123,
                decoration: BoxDecoration(
                  color: AppColors.black,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 9,
                    horizontal: 24,
                  ),
                  child: Text(
                    'ADD FUNDS',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        FadeIn(
          delay: Duration(milliseconds: 600),
          duration: Duration(milliseconds: 800),

          child: ZoomIn(
            delay: Duration(milliseconds: 600),
            duration: Duration(milliseconds: 800),

            child: GestureDetector(
              onTap: () => NoInterner.widgetnikorsatish(),
              child: Container(
                // height: 35,
                // width: 123,
                decoration: BoxDecoration(
                  color: AppColors.lgrey,
                  border: Border.all(color: AppColors.grey),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 9,
                    horizontal: 24,
                  ),
                  child: Text(
                    'SEND',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
