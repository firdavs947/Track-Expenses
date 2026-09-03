// import 'package:animate_do/animate_do.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:track_expenses/consts/colors/app_colors.dart';
// import 'package:track_expenses/gen/assets.gen.dart';
// import 'package:track_expenses/models/expense_model.dart';

// class CustomTransactions extends StatefulWidget {
//   const CustomTransactions({super.key, required this.expenseModel});
//   final ExpenseModel expenseModel;

//   @override
//   State<CustomTransactions> createState() => _CustomTransactionsState();
// }

// class _CustomTransactionsState extends State<CustomTransactions> {

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         FadeIn(
//           delay: Duration(milliseconds: 1200),
//           duration: Duration(milliseconds: 800),

//           child: ZoomInDown(
//             delay: Duration(milliseconds: 1200),
//             duration: Duration(milliseconds: 800),

//             child: SizedBox(
//               height: 76,
//               width: double.infinity,
//               child: Row(
//                 children: [
//                   CircleAvatar(
//                     radius: 25,
//                     backgroundColor: AppColors.white,
//                     child: SvgPicture.asset(Assets.icons.foodsMarket),
//                   ),
//                   SizedBox(width: 16),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,

//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         widget.expenseModel.note?? '',
//                         style: TextStyle(
//                           fontSize: 17,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                       Text(
//                        ' ${widget.expenseModel.type}',
//                         style: TextStyle(
//                           fontSize: 15,
//                           fontWeight: FontWeight.w500,
//                           color: AppColors.grey,
//                         ),
//                       ),
//                     ],
//                   ),
//                   Spacer(),
//                   TweenAnimationBuilder(
//                     tween: Tween<double>(begin: 0.0, end: widget.expenseModel.value),
//                     duration: const Duration(milliseconds: 4000),
//                     curve: Curves.easeOutQuint,
//                     builder: (context, double value, Widget? child) => Text(
//                       '-\$${value.toStringAsFixed(2)}',
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w500,
//                         fontFamily: 'Jet',
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:track_expenses/consts/colors/app_colors.dart';
import 'package:track_expenses/gen/assets.gen.dart';
import 'package:track_expenses/models/expense_model.dart';

class CustomTransactions extends StatefulWidget {
  const CustomTransactions({super.key, required this.expenseModel});
  final ExpenseModel expenseModel;

  @override
  State<CustomTransactions> createState() => _CustomTransactionsState();
}

class _CustomTransactionsState extends State<CustomTransactions> {
  String _iconForCategory(ExpenseCategory category) {
    switch (category) {
      case ExpenseCategory.home:
        return Assets.icons.home;
      case ExpenseCategory.food:
        return Assets.icons.food;
      case ExpenseCategory.transit:
        return Assets.icons.transit;
      case ExpenseCategory.shop:
        return Assets.icons.foodsMarket;
      case ExpenseCategory.bills:
        return Assets.icons.biils;
      case ExpenseCategory.more:
        return Assets.icons.more;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isIncome = widget.expenseModel.income;
    final absValue = widget.expenseModel.value.abs();

    return Column(
      children: [
        FadeIn(
          delay: Duration(milliseconds: 1200),
          duration: Duration(milliseconds: 800),
          child: ZoomInDown(
            delay: Duration(milliseconds: 1200),
            duration: Duration(milliseconds: 800),
            child: SizedBox(
              height: 76,
              width: double.infinity,
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: AppColors.white,
                    child: SvgPicture.asset(
                      _iconForCategory(widget.expenseModel.type),
                      colorFilter: ColorFilter.mode(
                        AppColors.black,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.expenseModel.note ?? '',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        ' ${widget.expenseModel.type.name}',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: AppColors.grey,
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  TweenAnimationBuilder(
                    tween: Tween<double>(begin: 0.0, end: absValue),
                    duration: const Duration(milliseconds: 4000),
                    curve: Curves.easeOutQuint,
                    builder: (context, double value, Widget? child) => Text(
                      '${isIncome ? '+' : '-'}\$${value.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Jet',
                        color: isIncome ? AppColors.green : AppColors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
