import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:track_expenses/consts/colors/app_colors.dart';
import 'package:track_expenses/gen/assets.gen.dart';
import 'package:track_expenses/providers/home_provider.dart';
import 'package:track_expenses/screens/new_entry_screen.dart';
import 'package:track_expenses/service/permission_service.dart';
import 'package:track_expenses/widgets/List_view_builder.dart';
import 'package:track_expenses/widgets/addFunds.dart';
import 'package:track_expenses/widgets/custom_drawer.dart';
import 'package:track_expenses/widgets/income_outcome.dart';
import 'package:track_expenses/widgets/recent_transactions.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  Future<void> _requestPermissions() async {
    await PermissionService.requestCameraPermission();
    await PermissionService.requestGalleryPermission();
  }

  @override
  void initState() {
    _requestPermissions();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: CustomDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
          icon: SvgPicture.asset(Assets.icons.menu),
        ),
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: FadeInDown(
            duration: Duration(milliseconds: 500),

            child: Text(
              'Overview',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
            ),
          ),
        ),
        actions: [SvgPicture.asset(Assets.icons.profile)],
        actionsPadding: EdgeInsets.only(right: 15),
      ),
      body: SingleChildScrollView(
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

                    Addfunds(),

                    SizedBox(height: 20),
                    FadeIn(
                      delay: Duration(milliseconds: 800),
                      duration: Duration(milliseconds: 800),

                      child: IconButton(
                        onPressed: () async {
                          await Navigator.push(
                            context,
                            PageRouteBuilder(
                              transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(opacity: animation, child: child,),
                              pageBuilder: (context, animation, secondaryAnimation) =>NewEntryScreen() ,
                              transitionDuration: Duration(milliseconds: 600),
                            reverseTransitionDuration: Duration(milliseconds: 600),
                            ),
                          );
                          if (!context.mounted) return;
                          context.read<HomeProvider>().getExpensesFromDb();
                        },
                        icon: Hero(
                          tag: 'plus1',
                          child: Icon(Icons.add)),
                      ),
                    ),
                    SizedBox(height: 20),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: IncomeOutcome(),
                    ),
                    SizedBox(height: 48),
                    FadeIn(
                      delay: Duration(milliseconds: 1100),
                      duration: Duration(milliseconds: 800),

                      child: ZoomInDown(
                        delay: Duration(milliseconds: 1100),
                        duration: Duration(milliseconds: 800),

                        child: RecentTransactions(),
                      ),
                    ),
                    SizedBox(height: 24),

                    context.watch<HomeProvider>().expenses.isEmpty
                        ? FadeIn(
                            delay: Duration(milliseconds: 1200),
                            duration: Duration(milliseconds: 800),

                            child: ZoomIn(
                              delay: Duration(milliseconds: 1200),
                              duration: Duration(milliseconds: 800),
                              child: Lottie.asset(
                                Assets.lotties.empty,
                                height: 350,
                                width: 350,
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                        : ListViewBuilder(),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
