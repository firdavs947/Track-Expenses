import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:track_expenses/consts/colors/app_colors.dart';
import 'package:track_expenses/providers/onboarding_provider.dart';
import 'package:track_expenses/screens/main_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider(
        create: (_) => OnboardingProvider(),
        child: Builder(
          builder: (context) {
            return Column(
              children: [
                Expanded(
                  flex: 7,
                  child: PageView.builder(
                    itemCount: context.watch<OnboardingProvider>().info.length,
                    onPageChanged: context
                        .read<OnboardingProvider>()
                        .onPageChanged,
                    controller: _pageController,
                    itemBuilder: (context, i) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FadeIn(
                            delay: Duration(milliseconds: 200),
                            duration: Duration(milliseconds: 500),
                            child: ZoomInDown(
                              delay: Duration(milliseconds: 200),
                              duration: Duration(milliseconds: 500),

                              child: CircleAvatar(
                                radius: 34,
                                backgroundColor: AppColors.white,
                                child: SizedBox(
                                  height: 25,
                                  width: 25,
                                  child: SvgPicture.asset(
                                    context.read<OnboardingProvider>().icon[i],
                                    colorFilter: ColorFilter.mode(
                                      AppColors.black,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 48),
                          FadeIn(
                            delay: Duration(milliseconds: 400),
                            duration: Duration(milliseconds: 500),
                            child: ZoomInDown(
                              delay: Duration(milliseconds: 400),
                              duration: Duration(milliseconds: 500),

                              child: Text(
                                context
                                    .read<OnboardingProvider>()
                                    .info[i]['title'],
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 24),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 41),
                            child: FadeIn(
                              delay: Duration(milliseconds: 600),
                              duration: Duration(milliseconds: 500),

                              child: ZoomInDown(
                                delay: Duration(milliseconds: 600),
                                duration: Duration(milliseconds: 500),

                                child: Text(
                                  context
                                      .read<OnboardingProvider>()
                                      .info[i]['description'],

                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.grey,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          spacing: 6,
                          children: List.generate(
                            context.read<OnboardingProvider>().info.length,
                            (i) => FadeIn(
                              delay: i == 0
                                  ? Duration(milliseconds: 800)
                                  : i == 1
                                  ? Duration(milliseconds: 1000)
                                  : Duration(milliseconds: 1200),
                              duration: Duration(milliseconds: 800),

                              child: CircleAvatar(
                                radius: 6,
                                backgroundColor:
                                    context
                                            .watch<OnboardingProvider>()
                                            .currentPage ==
                                        i
                                    ? AppColors.black
                                    : AppColors.grey,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 24),
                        FadeIn(
                           delay: Duration(milliseconds: 1100),
                            duration: Duration(milliseconds: 500),
                           
                          child: ZoomInDown(
                               delay: Duration(milliseconds: 1100),
                            duration: Duration(milliseconds: 500),
                           
                            child: ElevatedButton(
                              onPressed: () {
                                context.read<OnboardingProvider>().info.length -
                                            1 ==
                                        context
                                            .read<OnboardingProvider>()
                                            .currentPage
                                    ? Navigator.pushReplacement(
                                        context,
                                        CupertinoPageRoute(
                                          builder: (context) => MainScreen(),
                                        ),
                                      )
                                    : _pageController.nextPage(
                                        duration: Duration(milliseconds: 500),
                                        curve: Curves.easeInOut,
                                      );
                              },
                              child: Text(
                                context.watch<OnboardingProvider>().currentPage ==
                                        context
                                                .watch<OnboardingProvider>()
                                                .info
                                                .length -
                                            1
                                    ? 'GET STARTED'
                                    : 'NEXT',
                            
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
