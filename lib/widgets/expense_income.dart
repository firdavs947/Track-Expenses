import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:track_expenses/consts/colors/app_colors.dart';
import 'package:track_expenses/providers/new_entry.dart';

class ExpenseIncome extends StatefulWidget {
  const ExpenseIncome({super.key});

  @override
  State<ExpenseIncome> createState() => _ExpenseIncomeState();
}

class _ExpenseIncomeState extends State<ExpenseIncome> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      width: 256,
      decoration: BoxDecoration(
        color: AppColors.lgrey,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                context.read<NewEntry>().selected2(0);
              },
              child: AnimatedContainer(
                duration: Duration(milliseconds: 200),
                height: 40,
                width: 124,
                decoration: BoxDecoration(
                  color: context.watch<NewEntry>().selectedindex2 == 0
                      ? AppColors.black
                      : AppColors.lgrey,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Center(
                  child: Text(
                    'EXPENSE',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: context.watch<NewEntry>().selectedindex2 == 0
                          ? AppColors.white
                          : AppColors.grey,
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                context.read<NewEntry>().selected2(1);
              },
              child: AnimatedContainer(
                duration: Duration(milliseconds: 200),
                height: 40,
                width: 124,
                decoration: BoxDecoration(
                  color: context.watch<NewEntry>().selectedindex2 == 1
                      ? AppColors.black
                      : AppColors.lgrey,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Center(
                  child: Text(
                    'INCOME',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: context.watch<NewEntry>().selectedindex2 == 1
                          ? AppColors.white
                          : AppColors.grey,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
