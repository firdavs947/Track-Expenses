import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:track_expenses/consts/colors/app_colors.dart';
import 'package:track_expenses/providers/home_provider.dart';
import 'package:track_expenses/widgets/custom_transactions.dart';

class ListViewBuilder extends StatefulWidget {
  const ListViewBuilder({super.key});

  @override
  State<ListViewBuilder> createState() => _ListViewBuilderState();
}

class _ListViewBuilderState extends State<ListViewBuilder> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: context.watch<HomeProvider>().expenses.length,
      itemBuilder: (context, index) {
        final expense = context.watch<HomeProvider>().expenses[index];
        return Dismissible(
          direction: DismissDirection.endToStart,
          key: UniqueKey(),
          background: Container(
            decoration: BoxDecoration(
              color: Colors.red,

              borderRadius: BorderRadius.circular(20),
            ),
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(right: 20),
            child: Icon(Icons.delete, color: Colors.white),
          ),
          onDismissed: (direction) async {
            context.read<HomeProvider>().deleteItem(expense.id);
          },
          child: Column(
            children: [
              CustomTransactions(expenseModel: expense),
          Divider(color: AppColors.lgrey,),
           SizedBox(height: 20,)
            ],
          ),
        );
      },
    );
  }
}
