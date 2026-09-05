import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:track_expenses/consts/colors/app_colors.dart';
import 'package:track_expenses/providers/home_provider.dart';
import 'package:track_expenses/utils/size_extension.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext _) {
    return Builder(
      builder: (context) {
        return Container(
          color: AppColors.white,
          width: context.width * 0.5,
          height: context.height,
          child: SafeArea(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    showCupertinoDialog(
                      context: context,
                      builder: (context) => CupertinoAlertDialog(
                        title: Text('Confirm to clear the cache'),
                        actions: [
                          CupertinoActionSheetAction(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('Cancel'),
                          ),
                          CupertinoActionSheetAction(
                            onPressed: () {
                              context.read<HomeProvider>().clearDb(
                                onSuccess: () {
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                },
                              );
                            },
                            child: Text(
                              'Confirm',
                              style: TextStyle(fontSize: 20, color: Colors.red),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  child: ListTile(
                    title: Text('Clear cache'),
                    trailing: Icon(Icons.delete),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
