import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:open_file/open_file.dart';
import 'package:path/path.dart' as path;
import 'package:track_expenses/consts/colors/app_colors.dart';
import 'package:track_expenses/models/expense_model.dart';
import 'package:track_expenses/screens/full_sccreen_image.dart';
import 'package:track_expenses/utils/type_extension.dart';

class CustomTransactions extends StatefulWidget {
  const CustomTransactions({super.key, required this.expenseModel});
  final ExpenseModel expenseModel;

  @override
  State<CustomTransactions> createState() => _CustomTransactionsState();
}

class _CustomTransactionsState extends State<CustomTransactions> {
  @override
  Widget build(BuildContext context) {
    final isIncome = widget.expenseModel.income;
    final absValue = widget.expenseModel.value.abs();

    return Column(
      children: [
        FadeIn(
          // delay: Duration(milliseconds: 200),
          // duration: Duration(milliseconds: 800),
          child: ZoomInDown(
            // delay: Duration(milliseconds: 200),
            // duration: Duration(milliseconds: 800),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
              ),
              height: 297,
              width: double.infinity,
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundColor: AppColors.white,
                        child: SvgPicture.asset(
                          widget.expenseModel.type.name.checkType,
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
                        builder: (context, double value, Widget? child) => Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Text(
                            '${isIncome ? '+' : '-'}\$${value.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Jet',
                              color: isIncome
                                  ? AppColors.green
                                  : AppColors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  SizedBox(height: 20),
                  Builder(
                    builder: (context) {
                      final imagePath = widget.expenseModel.image;

                      if (imagePath == null || imagePath.isEmpty) {
                        return const SizedBox();
                      }

                      final file = File(imagePath);
                      final ext = path.extension(imagePath).toLowerCase();
                      final isImage = [
                        '.png',
                        '.jpg',
                        '.jpeg',
                        '.gif',
                        '.bmp',
                        '.webp',
                        '.heic',
                      ].contains(ext);

                      if (isImage) {
                        return SizedBox(
                          height: 200,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        FullSccreenImage(rasm: file),
                                  ),
                                );
                              },
                              child: Hero(
                                tag: 'rasm1',
                                child: Image.file(
                                  file,
                                  height: 200,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        );
                      } else {
                        return InkWell(
                          onTap: () => OpenFile.open(file.path),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              child: ListTile(
                                leading: const Icon(Icons.insert_drive_file),
                                title: Text(path.basename(file.path)),
                              ),
                            ),
                          ),
                        );
                      }
                    },
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
