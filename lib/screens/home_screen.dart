import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:track_expenses/consts/colors/app_colors.dart';
import 'package:track_expenses/gen/assets.gen.dart';
import 'package:track_expenses/providers/home_provider.dart';
import 'package:track_expenses/screens/new_entry_screen.dart';
import 'package:track_expenses/widgets/custom_transactions.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,

        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: FadeInDown(
            duration: Duration(milliseconds: 500),

            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset(Assets.icons.menu),
                Text(
                  'Overview',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
                ),
                SvgPicture.asset(Assets.icons.profile),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: ChangeNotifierProvider(
          create: (_) => HomeProvider()..getExpensesFromDb(),

          child: Builder(
            builder: (context) {
              return SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      SizedBox(height: 48),
                      FadeIn(
                        delay: Duration(milliseconds: 200),
                        duration: Duration(milliseconds: 800),

                        child: Text(
                          'TOTAL BALANCE',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.grey,
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      TweenAnimationBuilder(
                        tween: Tween<double>(
                          begin: 0.0,
                          end: context.read<HomeProvider>().balance,
                        ),
                        duration: const Duration(milliseconds: 1500),
                        curve: Curves.easeOutQuint,
                        builder: (context, double value, Widget? child) => Text(
                          '\$${value.toStringAsFixed(1)}',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      SizedBox(height: 24),
                      Row(
                        spacing: 16,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FadeIn(
                            delay: Duration(milliseconds: 600),
                            duration: Duration(milliseconds: 800),

                            child: ZoomIn(
                              delay: Duration(milliseconds: 600),
                              duration: Duration(milliseconds: 800),
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
                          FadeIn(
                            delay: Duration(milliseconds: 600),
                            duration: Duration(milliseconds: 800),

                            child: ZoomIn(
                              delay: Duration(milliseconds: 600),
                              duration: Duration(milliseconds: 800),

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
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 20),
                      FadeIn(
                        delay: Duration(milliseconds: 800),
                        duration: Duration(milliseconds: 800),

                        child: IconButton(
                          onPressed: () async {
                            await Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => NewEntryScreen(),
                              ),
                            );
                            if (!context.mounted) return;
                            context.read<HomeProvider>().getExpensesFromDb();
                          },
                          icon: Icon(Icons.add),
                        ),
                      ),
                      SizedBox(height: 20),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            FadeInLeft(
                              delay: Duration(milliseconds: 1000),
                              duration: Duration(milliseconds: 800),

                              child: Row(
                                children: [
                                  Container(
                                    height: 40,
                                    width: 4,
                                    color: Colors.green,
                                  ),
                                  SizedBox(width: 16),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                          end: context
                                              .watch<HomeProvider>()
                                              .totalIncome,
                                        ),
                                        duration: const Duration(
                                          milliseconds: 3000,
                                        ),
                                        curve: Curves.easeOutQuint,
                                        builder:
                                            (
                                              context,
                                              double value,
                                              Widget? child,
                                            ) => Text(
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
                                  Container(
                                    height: 40,
                                    width: 4,
                                    color: Colors.red,
                                  ),
                                  SizedBox(width: 16),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                          end: context
                                              .watch<HomeProvider>()
                                              .totalOutcome,
                                        ),
                                        duration: const Duration(
                                          milliseconds: 3000,
                                        ),
                                        curve: Curves.easeOutQuint,
                                        builder:
                                            (
                                              context,
                                              double value,
                                              Widget? child,
                                            ) => Text(
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
                        ),
                      ),
                      SizedBox(height: 48),
                      FadeIn(
                        delay: Duration(milliseconds: 1100),
                        duration: Duration(milliseconds: 800),

                        child: ZoomInDown(
                          delay: Duration(milliseconds: 1100),
                          duration: Duration(milliseconds: 800),

                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Recent Transactions',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600,
                                ),
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
                          ),
                        ),
                      ),
                      SizedBox(height: 24),

                      ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: context
                            .watch<HomeProvider>()
                            .expenses
                            .length,
                        itemBuilder: (context, index) => CustomTransactions(
                          expenseModel: context
                              .watch<HomeProvider>()
                              .expenses[index],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
