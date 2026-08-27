import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:track_expenses/consts/colors/app_colors.dart';
import 'package:track_expenses/gen/assets.gen.dart';
import 'package:track_expenses/providers/new_entry.dart';

class NewEntryScreen extends StatefulWidget {
  const NewEntryScreen({super.key});

  @override
  State<NewEntryScreen> createState() => _NewEntryScreenState();
}

class _NewEntryScreenState extends State<NewEntryScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          title: Padding(
            padding: const EdgeInsets.only(left: 5, right: 15),
            child: FadeInDown(
              delay: Duration(milliseconds: 00),
              duration: Duration(milliseconds: 800),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: SvgPicture.asset(Assets.icons.close),
                  ),
                  Text(
                    'New Entry',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
                  ),
                  Text(
                    'SAVE',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: ChangeNotifierProvider(
          create: (context) => NewEntry(),
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
                      Padding(
                        padding: const EdgeInsets.only(left: 100),
                        child: FadeIn(
                          delay: Duration(milliseconds: 400),
                          duration: Duration(milliseconds: 800),

                          child: ZoomIn(
                            delay: Duration(milliseconds: 400),
                            duration: Duration(milliseconds: 800),

                            child: TextField(
                              keyboardType: TextInputType.number,
                              style: TextStyle(
                                fontSize: 56,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Jet',
                              ),
                              cursorColor: AppColors.black,
                              cursorHeight: 65,
                              decoration: InputDecoration(
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: SvgPicture.asset(Assets.icons.text),
                                ),

                                hintText: '0.00',
                                hintStyle: TextStyle(
                                  fontSize: 56,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Jet',
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                disabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 48),
                      FadeIn(
                        delay: Duration(milliseconds: 600),
                        duration: Duration(milliseconds: 800),

                        child: ZoomIn(
                          delay: Duration(milliseconds: 600),
                          duration: Duration(milliseconds: 800),

                          child: Container(
                            height: 48,
                            width: 256,
                            decoration: BoxDecoration(
                              color: AppColors.lgrey,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 4,
                              ),
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      context.read<NewEntry>().selected2(0);
                                    },
                                    child: Container(
                                      height: 40,
                                      width: 124,
                                      decoration: BoxDecoration(
                                        color:
                                            context
                                                    .watch<NewEntry>()
                                                    .selectedindex2 ==
                                                0
                                            ? AppColors.black
                                            : AppColors.lgrey,
                                        borderRadius: BorderRadius.circular(
                                          100,
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          'EXPENSE',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color:
                                                context
                                                        .read<NewEntry>()
                                                        .selectedindex2 ==
                                                    0
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
                                    child: Container(
                                      height: 40,
                                      width: 124,
                                      decoration: BoxDecoration(
                                        color:
                                            context
                                                    .read<NewEntry>()
                                                    .selectedindex2 ==
                                                1
                                            ? AppColors.black
                                            : AppColors.lgrey,
                                        borderRadius: BorderRadius.circular(
                                          100,
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          'INCOME',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color:
                                                context
                                                        .read<NewEntry>()
                                                        .selectedindex2 ==
                                                    1
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
                          ),
                        ),
                      ),
                      SizedBox(height: 48),
                      Row(
                        children: [
                          FadeIn(
                            delay: Duration(milliseconds: 600),
                            duration: Duration(milliseconds: 800),

                            child: Text(
                              'CATEGORY',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: AppColors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                      FadeIn(
                        delay: Duration(milliseconds: 600),
                        duration: Duration(milliseconds: 800),

                        child: Divider(color: AppColors.lgrey),
                      ),
                      SizedBox(height: 16),
                      Wrap(
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
                                          context
                                                  .read<NewEntry>()
                                                  .selectedindex ==
                                              i
                                          ? AppColors.black
                                          : AppColors.lgrey,
                                      radius: 30,
                                      child: SvgPicture.asset(
                                        context.watch<NewEntry>().category[i],
                                        colorFilter: ColorFilter.mode(
                                          context
                                                      .watch<NewEntry>()
                                                      .selectedindex ==
                                                  i
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
                                      color:
                                          context
                                                  .watch<NewEntry>()
                                                  .selectedindex ==
                                              i
                                          ? AppColors.black
                                          : AppColors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 52),
                      FadeIn(
  delay: Duration(milliseconds: 1300),
                        duration: Duration(milliseconds: 800),
                      
                        child: ZoomInDown(
                          delay: Duration(milliseconds: 1500),
                          duration: Duration(milliseconds: 800),
                          child: TextField(
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                            decoration: InputDecoration(
                              hintText: 'ADD NOTE...',
                              hintStyle: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: AppColors.grey,
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                      ),
                      FadeIn(
                          delay: Duration(milliseconds: 1500),
                        duration: Duration(milliseconds: 800),
                      
                        child: Divider(color: AppColors.lgrey)),
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
