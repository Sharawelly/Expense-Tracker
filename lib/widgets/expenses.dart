// this file we will create our main user interface
import 'package:flutter/material.dart';
import 'package:num_27_expense_tracker_responsive_and_adaptive_app/models/expense.dart';
import 'package:num_27_expense_tracker_responsive_and_adaptive_app/widgets/chart/chart.dart';
import 'package:num_27_expense_tracker_responsive_and_adaptive_app/widgets/expenses_list/expenses_list.dart';
import 'package:num_27_expense_tracker_responsive_and_adaptive_app/widgets/new_expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  // this variable is private because of '_' before it's name
  final List<Expense> _registeredExpenses = [
    Expense(
      title: 'Flutter Course',
      amount: 19.19,
      date: DateTime.now(),
      category: Category.work,
    ),
    Expense(
      title: 'Cinema',
      amount: 15.69,
      date: DateTime.now(),
      category: Category.leisure,
    ),
  ];

  void _openAddExpenseOverlay() {
    // this built in function will dynamically add a new UI element such a model overlay when it's being executed
    showModalBottomSheet(
      // using safeArea --> make sure that our app will stay away from the device feature like camera that might be affecting our UI.
      // making sure that things like camera don't overlap your UI.
      useSafeArea: true,
      // isScrollControlled --> to make sure the virtual keyboard that opens up doesn't overlap our input fields
      isScrollControlled: true,
      context: context,
      // ctx is context of ModalBottomSheet that will be created "holds the information object related to that Modal"
      builder: (ctx) => NewExpense(onAddExpense: _addExpense),
    );
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    // get the index of an expense
    final expanseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    // let's work in the message that should be shown if we delete an expense "dismiss"
    // let's make a message will appear after deleting an expense
    // ScaffoldMessenger is a special object which you can use for showing or hiding certain UI elements
    // .clearSnackBars() to remove any SnackBars before showing a new SnackBar "showing a new message"
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text(
          'Expense deleted',
        ),
        // like button
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              // insert an element into index...
              _registeredExpenses.insert(expanseIndex, expense);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // MediaQuery --> to help us to find out how much width and height we have available.
    // and if it's enough width, we want to switch from a column to a row,
    // "we want to switch the column and raw because in landscape mode we want to make the chart in the left of screen and list of expenses in the right of the screen"
    final width =
        MediaQuery.of(context).size.width; // to get the width of the screen
    MediaQuery.of(context).size.height; // to get the height of the screen

    Widget mainContent = const Center(
      child: Text('No expenses found. Start adding some!'),
    );

    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        onRemoveExpense: _removeExpense,
        expenses: _registeredExpenses,
      );
    }
    return Scaffold(
      // adding appBar
      appBar: AppBar(
        title: const Text('Flutter ExpenseTracker'),
        // used to display buttons
        actions: [
          // display a button that only contains an icon.
          // so not text and icons, but just an icon
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(Icons.add),
          ),
        ],
      ),

      // width --> handling the landscape mode
      // we want to switch between the column and raw because in landscape mode we want to make the chart in the left of screen and list of expenses in the right of the screen
      // Instead of setting the list of expenses after the chart in portrait mode
      body: width < 600
          ? Column(
              children: [
                Chart(
                  expenses: _registeredExpenses,
                ),
                // we used Expanded here because ExpensesList will return list of widget and each child of children Column()
                // should be a widget not list of widget so we used Expanded to solve this problem
                Expanded(
                  child: mainContent,
                ),
              ],
            )
          : Row(
              children: [
                // why we made chart is Expanded in the Row and not Expanded in the Column?
                // because this chart widget in the end is a container that has a width of double.infinity
                // so this container simply tries to take up as much width as it can get,
                // only restricted by the parent widget "Row", so the problem is the chart being inside the Row is:
                // that the Row also has a width of infinity, so the Row tries to get as much width as possible,
                // and the Row has childe also tries to get as much width as possible, so because this reason
                // "you have child {Chart} that tries to get as much width as it can get, and you have a parent {Row()} that tries to get as much width as it can get"
                // you get an error because flutter isn't able to display a UI.
                // so to solve this problem you should wrap this child "Chart" with Expanded which is basically always the solution
                // whenever you have widgets nested into each other that don't work together like this.
                // Expended --> Expanded constraints the child (i.e., Chart) to only take as much width as available in the Row after sizing the other Row children.
                Expanded(
                  child: Chart(
                    expenses: _registeredExpenses,
                  ),
                ),
                // we used Expanded here because ExpensesList will return list of widget and each child of children Column()
                // should be a widget not list of widget so we used Expanded to solve this problem
                Expanded(
                  child: mainContent,
                ),
              ],
            ),
    );
  }
}
