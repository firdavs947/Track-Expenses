import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:track_expenses/consts/colors/app_colors.dart';

class RecentTransactions extends StatelessWidget {
  const RecentTransactions({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Recent Transactions',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
        ),
        TextButton(
          onPressed: () {},
          child: Text(
            'VIEW ALL',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.grey,
            ),
          ),
        ),
      ],
    );
  }
}
