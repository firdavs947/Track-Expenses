import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:track_expenses/consts/colors/app_colors.dart';
import 'package:track_expenses/providers/new_entry.dart';

class Category extends StatefulWidget {
  const Category({super.key});

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: 16,
      spacing: 16,
      children: List.generate(
        context.watch<NewEntry>().category.length,
        (i) => FadeIn(
          delay: i == 0
              ? Duration(milliseconds: 800)
              : i == 1
              ? Duration(milliseconds: 900)
              : i == 2
              ? Duration(milliseconds: 1000)
              : i == 3
              ? Duration(milliseconds: 1100)
              : i == 4
              ? Duration(milliseconds: 1200)
              : Duration(milliseconds: 1300),
          duration: Duration(milliseconds: 800),
          child: ZoomInDown(
            delay: i == 0
                ? Duration(milliseconds: 800)
                : i == 1
                ? Duration(milliseconds: 900)
                : i == 2
                ? Duration(milliseconds: 1000)
                : i == 3
                ? Duration(milliseconds: 1100)
                : i == 4
                ? Duration(milliseconds: 1200)
                : Duration(milliseconds: 1300),
            duration: Duration(milliseconds: 800),
            child: Column(
              spacing: 8,
              children: [
                GestureDetector(
                  onTap: () {
                    context.read<NewEntry>().selected(i);
                  },
                  child: CircleAvatar(
                    backgroundColor:
                        context.watch<NewEntry>().selectedindex == i
                        ? AppColors.black
                        : AppColors.lgrey,
                    radius: 30,
                    child: SvgPicture.asset(
                      context.watch<NewEntry>().category[i],
                      colorFilter: ColorFilter.mode(
                        context.watch<NewEntry>().selectedindex == i
                            ? AppColors.white
                            : AppColors.grey,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
                Text(
                  context.watch<NewEntry>().categorytext[i],
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: context.watch<NewEntry>().selectedindex == i
                        ? AppColors.black
                        : AppColors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
