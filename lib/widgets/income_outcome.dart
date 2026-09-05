import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:track_expenses/consts/colors/app_colors.dart';
import 'package:track_expenses/providers/home_provider.dart';

class IncomeOutcome extends StatelessWidget {
  const IncomeOutcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        FadeInLeft(
          delay: Duration(milliseconds: 1000),
          duration: Duration(milliseconds: 800),

          child: Row(
            children: [
              Container(height: 40, width: 4, color: Colors.green),
              SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.arrow_downward_rounded,
                        size: 20,
                        color: AppColors.grey,
                      ),
                      SizedBox(width: 4),
                      Text(
                        'INCOME',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.grey,
                        ),
                      ),
                    ],
                  ),
                  TweenAnimationBuilder(
                    tween: Tween<double>(
                      begin: 0.0,
                      end: context.watch<HomeProvider>().totalIncome,
                    ),
                    duration: const Duration(milliseconds: 3000),
                    curve: Curves.easeOutQuint,
                    builder: (context, double value, Widget? child) => Text(
                      '+\$${value.toStringAsFixed(1)}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Jet',
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        FadeInRight(
          delay: Duration(milliseconds: 1000),
          duration: Duration(milliseconds: 800),

          child: Row(
            children: [
              Container(height: 40, width: 4, color: Colors.red),
              SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.arrow_upward_rounded,
                        size: 20,
                        color: AppColors.grey,
                      ),
                      SizedBox(width: 4),
                      Text(
                        'OUTCOME',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.grey,
                        ),
                      ),
                    ],
                  ),
                  TweenAnimationBuilder(
                    tween: Tween<double>(
                      begin: 0.0,
                      end: context.watch<HomeProvider>().totalOutcome,
                    ),
                    duration: const Duration(milliseconds: 3000),
                    curve: Curves.easeOutQuint,
                    builder: (context, double value, Widget? child) => Text(
                      '-\$${value.toStringAsFixed(1)}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Jet',
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
