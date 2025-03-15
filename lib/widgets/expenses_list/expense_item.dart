import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:num_27_expense_tracker_responsive_and_adaptive_app/models/expense.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem({super.key, required this.expense});

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    // Card() will give us a nice card look, it will put the content that we passed to card
    // into container that's a bit elevated, that has slight shadow behind itself,
    // to make it stand out a bit more.
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        child: Column(
          // crossAxisAlignment in column is horizontal axis
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              expense.title,
              // here in this text we used the theme that we made in the MaterialApp
              // you can also change those theme values in the places where you're using them by using ".copyWith()",
              // to use our general .titleLarge theme settings and override them with specific settings that we want to use specifically here in this widget.
              // So which won't be changed in general theme, but which will be adjusted in this widget
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(
              height: 4,
            ),
            Row(
              children: [
                // this function will ensure that only two numbers after comma will be displayed
                // ex: 12.3433  -----> 12.34
                // ex: 10.471   -----> 10.47
                Text('\$${expense.amount.toStringAsFixed(2)}'),
                // Spacer() is a widget that can be used in any Column or Row,
                // to tell flutter it should create a widget that takes up all space it can get between the other widget between which it is placed.
                // ex: so here the Text above Spacer will get all space it needs to output the text, and the Row under Spacer will get all the space it needs to output it's children items,
                // and the spacer then will always take all the remaining space, "hence pushing Text to the left and Row to the right"
                const Spacer(),
                Row(
                  children: [
                    Icon(
                      categoryIcons[expense.category],
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      expense.formattedDate,
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
