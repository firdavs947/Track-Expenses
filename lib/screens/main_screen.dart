import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:track_expenses/consts/colors/app_colors.dart';
import 'package:track_expenses/gen/assets.gen.dart';
import 'package:track_expenses/screens/check_screen.dart';
import 'package:track_expenses/screens/home_screen.dart';
import 'package:track_expenses/screens/settings_screen.dart';
import 'package:track_expenses/screens/wallet_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedINdex = 0;
List pages =[HomeScreen(), WalletScreen(), CheckScreen(), SettingsScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBody: true,
      body: pages[selectedINdex],

      bottomNavigationBar: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          elevation: 0,
          selectedItemColor: AppColors.black,
          unselectedItemColor: AppColors.grey,

          backgroundColor: Colors.transparent,
          selectedLabelStyle: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelStyle: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),

          currentIndex: selectedINdex,
          // unselectedItemColor: iconcolor,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: selectedINdex == 0
                  ? SvgPicture.asset(Assets.icons.home2 ,colorFilter: ColorFilter.mode(AppColors.black, BlendMode.srcIn),)
                  : SvgPicture.asset(
                      Assets.icons.home2,
                      colorFilter: ColorFilter.mode(
                        AppColors.grey,
                        BlendMode.srcIn,
                      ),
                    ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: selectedINdex == 1
                ? SvgPicture.asset(Assets.icons.wallet ,colorFilter: ColorFilter.mode(AppColors.black, BlendMode.srcIn),)
                  : SvgPicture.asset(
                      Assets.icons.wallet,
                      colorFilter: ColorFilter.mode(
                        AppColors.grey,
                        BlendMode.srcIn,
                      ),
                    ),

              label: 'Wallet',
            ),
            BottomNavigationBarItem(
              icon: selectedINdex == 2
                  ? SvgPicture.asset(Assets.icons.check ,colorFilter: ColorFilter.mode(AppColors.black, BlendMode.srcIn),)
                  : SvgPicture.asset(
                      Assets.icons.check,
                      colorFilter: ColorFilter.mode(
                        AppColors.grey,
                        BlendMode.srcIn,
                      ),
                    ),
              label: 'Check',
            ),
                BottomNavigationBarItem(
              icon: selectedINdex == 3
                  ? SvgPicture.asset(Assets.icons.settings ,colorFilter: ColorFilter.mode(AppColors.black, BlendMode.srcIn),)
                  : SvgPicture.asset(
                      Assets.icons.settings,
                      colorFilter: ColorFilter.mode(
                        AppColors.grey,
                        BlendMode.srcIn,
                      ),
                    ),
              label: 'Settings',
            ),
          ],
          onTap: (i) {
            selectedINdex = i;
            setState(() {});
          },
        ),
      ),
    );
  }
}
