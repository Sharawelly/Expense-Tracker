import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:num_27_expense_tracker_responsive_and_adaptive_app/models/expense.dart';
import 'package:num_27_expense_tracker_responsive_and_adaptive_app/widgets/expenses_list/expense_item.dart';

// this class to output list of expenses
class ExpensesList extends StatelessWidget {
  const ExpensesList(
      {super.key, required this.expenses, required this.onRemoveExpense});

  final void Function(Expense expense) onRemoveExpense;

  final List<Expense> expenses;

  @override
  Widget build(BuildContext context) {
    // we used ListView() instead of Column() why?
    // If you have lists of unclear length that could potentially get quite long, as is the case here for this ExpensesList,
    // users could add 100 or 1,000 expenses when the app is up and running.
    // So when you have a list of unknown length that will potentially get very long,
    // Column is not ideal because, with Column, all the widgets that you add to it will be created behind the scenes by Flutter whenever this widget that outputs this column becomes active.

    // That means if you have a list with 1,000 items, all these items will be created behind the scenes by Flutter at the moment this list widget is displayed on the screen.
    // The problem with that is that only a small number of those expenses are actually needed because only a few expense list items will be visible on the screen.
    // We will have a scrollable list, and most of those items won’t be visible initially.

    // Hence, creating all these invisible items behind the scenes at the beginning is redundant and costs a lot of performance.
    // That’s why you should not use Column for lists where you don’t know the length but might have a lot of items in the end.
    // Instead, Flutter provides a different widget for such situations, and that’s the ListView widget.
    // if you use ListView(), you will get a scrollable list which still creates all items immediately when this list is displayed on the screen.
    // So the only thing we gain here is that this is automatically scrollable but it's still not ideal for this scenario here where we might have many items that won't be visible initially.
    // Instead here, we should not use list view like this but use a special constructor that's offered by it the builder construct function.
    // This is a special constructor function for this list view widget, which in the end tells Flutter that it should create a scrollable list.
    // ListViews are always scrollable lists by default but that it should build, create those list items only when they are visible or about to become visible not if they're not visible.
    // For that, builder takes an item builder parameter which is of type function.
    // So which wants a function as a value.
    // And it wants a function that will get two input values itself.
    // Those will be provided automatically by Flutter and it should then return a widget.
    // So this function, which we pass as a value to item builder should return a widget,
    // the list item that should be created when needed.

    return ListView.builder(
      // to tell list view which items we want to print it "how many list items will be displayed?"
      itemCount: expenses.length,
      // Dismissible to makes our items swapped away, it's a widget which we can wrap around list items
      // that should be swipeable or should be removable
      itemBuilder: (context, index) => Dismissible(
        // key exists to make widget uniquely identifiable
        // so to swipe a widget away, and remove the data that associated with a widget we need a key
        // a key is needed to allow flutter to uniquely identify a widget and the data that's associated with it
        //the key in needed to make sure that the correct data will be deleted
        key: ValueKey(expenses[index]), // ValueKey to create a key
        // onDismissed --> when we swiped a widget away we need to ensure that the data and widget is removed
        // so onDismissed allows you to trigger a function whenever one widget has been swiped away "whenever we remove one   Expense"
        onDismissed: (direction) {
          // using direction we can handle direction or swipe from left to right or right to left to do different thing
          // according to direction of swipe
          onRemoveExpense(expenses[index]);
        },
        // background --> background effect when we swipe
        background: Container(
          color: Theme.of(context).colorScheme.error.withAlpha(120),
          margin: EdgeInsets.symmetric(
            horizontal: Theme.of(context).cardTheme.margin!.horizontal,
          ),
        ),
        child: ExpenseItem(expense: expenses[index]),
      ),
    );
  }
}
