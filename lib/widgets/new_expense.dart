import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:num_27_expense_tracker_responsive_and_adaptive_app/models/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  // TextEditingController --> To optimize for handling user input and the object can be passed as a value to text field
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  // when creating TextEditing controller you should tell flutter to delete this controller when the widget is not needed anymore
  // because otherwise this TextEditingController would live on memory and will not be deleted even though the widget is not visible anymore,
  // so when using TextEditingController we should always use dispose method
  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  // this variable and method used by onChanged
  // String _enteredValue = '';
  // void _saveTitleInput(String inputValue) {
  //   _enteredValue = inputValue;
  // }

  DateTime? _selectedDate;
  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    // initialDate --> the date that is selected initially when the picker is opened
    // firstDate --> lowest (oldest) possible date that can be selected
    // lastDate  --> maximum date that can be selected
    // Note that showDatePicker is an object from Future type
    // Future object is simply an object from the future, it simply an object that wraps a value which you don't have yet,
    // but you will have in the future
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
      // How to store showDatePicker ??
      // so here to store the value from user in the future we have two options:
      // 1) using .then() method
      // 2) using async await
      // in this example we will use async await to store the value will be get from user in the future
      // 1) okay now, How .then() method works?!
      // ).then(value) {}
      // then() method should be executed in the future once the value is available "once the user choose date",
      // this method to store the value from showDatePicker after the user Enters it
      // instead of then we can use async await !!!!
    );
    // When using async and await, the lines of code "after await" will be executed only once the value is available.
    // It will wait for the user to pick a date, and after the user selects a value, the code will continue executing.
    // so, when using async await those lines of code will be executed only once the value is available
    // once the user picked the date so those lines of code "after await" will wait some time and after picking the value from user those lines will be executed
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  // showDialog is based on the device's system (Android or iOS) because dialogs have a different appearance on iOS.
  void _showDialog() {
    // if we are in IOS
    if (Platform.isIOS) {
      // Cupertino is simply the name of the IOS styling language or design language
      // this will show different appearance of dialog in the IOS only {IOS look} for Dialog
      // this is how we can build adaptive apps by using "Platform" to determine on which platform you are,
      // and then use can use that information to run different code for different platforms.
      showCupertinoDialog(
        context: context,
        builder: (ctx) => CupertinoAlertDialog(
          title: const Text('Invalid Input'),
          content: const Text(
              'Please make sure a valid title, amount, date and category, was entered....'),
          actions: [
            TextButton(
              onPressed: () {
                // to close this dialog and delete it
                Navigator.pop(ctx);
              },
              child: const Text('Okay'),
            )
          ],
        ),
      );
    } else {
      // show an error message for android normal showDialog
      showDialog(
        context: context,
        // builder --> wants a builder function which should be a function that takes some context an input
        // and returns a widget as a value and the widget will be the content of that pop-up dialog that will be shown
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid Input'),
          content: const Text(
              'Please make sure a valid title, amount, date and category, was entered....'),
          actions: [
            TextButton(
              onPressed: () {
                // to close this dialog and delete it
                Navigator.pop(ctx);
              },
              child: const Text('Okay'),
            )
          ],
        ),
      );
    }
  }

  void _submitExpenseDate() {
    // double.tryParse --> to covert String into double if it's able to convert that string to a double number
    // or it returns null if it's not able to convert it
    // ex: tryParse('Hello) => null
    // ex: tryParse('1.21) => 1.21
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;
    // trim ---> to remove excess white space at the beginning of end
    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
      _showDialog();
      return;
    }
    // adding new expense here after checking the validation of the input
    widget.onAddExpense(
      Expense(
        title: _titleController.text,
        amount: enteredAmount,
        date: _selectedDate!,
        category: _selectedCategory,
      ),
    );
    // to close and remove the current context and current screen "adding new expense screen"
    Navigator.pop(context);
  }

  Category _selectedCategory = Category.leisure;

  @override
  Widget build(BuildContext context) {
    // viewInsets --> contains extra information about UI elements that might be overlapping certain parts of the UI
    // in viewInsets.bottom --> i get any extra UI elements that are overlapping the UI from bottom
    // in this case the virtual keyboard slides in from the bottom and overlaps my UI,
    // so here with MediaQuery of viewInsets bottom, I can get the amount of space taken up by that keyboard.
    final virtualKeyboardSpace = MediaQuery.of(context).viewInsets.bottom;

    // we want to handle our new expense in landscape mode --> like we to make tha amount and title in the same raw, drop down button and data picker also in the same raw,
    // So here, we can use the same approach as in expenses.dart, such as using MediaQuery.of(context).size.width, but we will use different solution,
    // we will use Layout Builder --> automatically adjusts studio available space.
    return LayoutBuilder(builder: (ctx, constraint) {
      // constraint telling us which constraint are applied by the parent widget "the parent widget of new_expense here",
      // and this constrain object tells us the minimum and maximum amount of width and height that we can use.
      // ! Ex: constraint.minHeight, constraint.maxHeight, constraint.minWidth, constraint.maxWidth;
      // so using constraint you know exactly how much space you have available and then decide which layout should be rendered,
      // and this allows you to build a widget that can be used anywhere in your widget tree, and it doesn't care about
      // the available width or height of the screen, it doesn't care about the screen orientation,
      // but it only cares how much width and height is available to this specific widget here "new expense widget".
      // so this is the difference between MediaQuery and LayoutBuilder:
      // MediaQuery gives us the height and width of the all screen but LayoutBuilder gives us the available width and height to specific widget
      // MediaQuery >= LayoutBuilder
      // So here, in our example, because the NewExpense widget is inside that modal, its width and height match the screen size.
      // Therefore, using MediaQuery or LayoutBuilder will achieve the same result.
      // so using LayoutBuilder makes us also use the new expense, which at anywhere else in our widget tree, and it will only care about the constraints set by the parent widget,
      // it won't care about the available screen width or height,
      // but if we used MediaQuery the new expense will only care about the width and height of the entire screen or the available width and height of the entire screen.

      final width = constraint.maxWidth; // storing the maximum width we can use
      return SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            // virtualKeyboardSpace --> dynamically add extra padding space to make sure that the keyboard that might be opened up
            // once the user taps into a textfield is respected and the content is pushed up appropriately.
            padding: EdgeInsets.fromLTRB(16, 16, 16, virtualKeyboardSpace + 16),
            child: Column(
              children: [
                if (width >= 600)
                  Row(
                    // crossAxisAlignment --> in case of Row is a vertical alignment
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: TextField(
                          // To take input from user there are two ways
                          // 1) onChanged -> allows us to register a function that will be triggered whenever the value in that TextField changes "To take input from user"
                          // onChanged: _saveTitleInput,
                          // 2) using controller
                          controller: _titleController,
                          // maximum amount of character that can be entered into this text input field
                          maxLength: 50,
                          // control  which  virtual keyboard should be opened when the users taps into  this TextField
                          keyboardType: TextInputType
                              .text, // this type is opened by default
                          decoration: const InputDecoration(
                            label: Text('Title'),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 14,
                      ),
                      // wrapped TextField with Expanded because, TextField turns out to be a widget which has problems with being placed
                      // in a Row like this because it's wants to take much space horizontally as possible And the Row by default doesn't
                      // restrict the amount of space that can be taken
                      // so we wrapped TextField in an Expanded widget because TextField are actually widgets that are also unconstrained regarding their width,
                      // as is the Row and as we learned if we have unconstrained widget inside of unconstrained widget "TextField inside Row",
                      // we would face problems so to solve this we will wrap TextField inside Expanded
                      Expanded(
                        child: TextField(
                          controller: _amountController,
                          // the type of virtual keyboard that will be opened when the users taps into this TextField is a number
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            prefixText: '\$ ',
                            label: Text('Amount'),
                          ),
                        ),
                      ),
                    ],
                  )
                else
                  // display such a text input element "allows users to enter some text"
                  TextField(
                    // To take input from user there are two ways
                    // 1) onChanged -> allows us to register a function that will be triggered whenever the value in that TextField changes "To take input from user"
                    // onChanged: _saveTitleInput,
                    // 2) using controller
                    controller: _titleController,
                    // maximum amount of character that can be entered into this text input field
                    maxLength: 50,
                    // control  which  virtual keyboard should be opened when the users taps into  this TextField
                    keyboardType:
                        TextInputType.text, // this type is opened by default
                    decoration: const InputDecoration(
                      label: Text('Title'),
                    ),
                  ),
                if (width >= 600)
                  Row(
                    children: [
                      DropdownButton(
                        value: _selectedCategory,
                        items: Category.values
                            .map(
                              (category) => DropdownMenuItem(
                                // value will be stored internally for every dropdown item
                                value: category,
                                child: Text(
                                  category.name.toUpperCase(),
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              _selectedCategory = value;
                            });
                          }
                        },
                      ),
                      const SizedBox(
                        width: 24,
                      ),
                      Expanded(
                        child: Row(
                          // mainAxisAlignment  -->  in a Row to control horizontal alignment
                          mainAxisAlignment: MainAxisAlignment.end,
                          // crossAxisAlignment -->  in a Row to control vertical alignment
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              _selectedDate == null
                                  ? 'No date selected'
                                  // " ! " to ensure and force that _selectedDate won't be null
                                  : formatter.format(_selectedDate!),
                            ),
                            IconButton(
                              onPressed: _presentDatePicker,
                              icon: const Icon(
                                Icons.calendar_month,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  )
                else
                  Row(
                    // wrapped anything with Expanded to make sure that it takes as much space as it can get on the screen, but nothing more
                    children: [
                      // wrapped TextField with Expanded because, TextField turns out to be a widget which has problems with being placed
                      // in a Row like this because it's wants to take much space horizontally as possible And the Row by default doesn't
                      // restrict the amount of space that can be taken
                      // so we wrapped TextField in an Expanded widget because TextField are actually widgets that are also unconstrained regarding their width,
                      // as is the Row and as we learned if we have unconstrained widget inside of unconstrained widget "TextField inside Row",
                      // we would face problems so to solve this we will wrap TextField inside Expanded
                      Expanded(
                        child: TextField(
                          controller: _amountController,
                          // the type of virtual keyboard that will be opened when the users taps into this TextField is a number
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            prefixText: '\$ ',
                            label: Text('Amount'),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      // Row inside the Row we should use wrap the inner Row with Expanded
                      Expanded(
                        child: Row(
                          // mainAxisAlignment  -->  in a Row to control horizontal alignment
                          mainAxisAlignment: MainAxisAlignment.end,
                          // crossAxisAlignment -->  in a Row to control vertical alignment
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              _selectedDate == null
                                  ? 'No date selected'
                                  // " ! " to ensure and force that _selectedDate won't be null
                                  : formatter.format(_selectedDate!),
                            ),
                            IconButton(
                              onPressed: _presentDatePicker,
                              icon: const Icon(
                                Icons.calendar_month,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                const SizedBox(
                  height: 16,
                ),
                if (width >= 600)
                  Row(
                    children: [
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          // to close the overlay screen "adding new expense" when tapped on cancel button
                          // pop method simply removes this overlay "context" from the screen {"close the new expense screen"}
                          Navigator.pop(context);
                        },
                        child: const Text('Cancel'),
                      ),
                      ElevatedButton(
                        onPressed: _submitExpenseDate,
                        child: const Text('Save Expense'),
                      ),
                    ],
                  )
                else
                  Row(
                    children: [
                      DropdownButton(
                        value: _selectedCategory,
                        items: Category.values
                            .map(
                              (category) => DropdownMenuItem(
                                // value will be stored internally for every dropdown item
                                value: category,
                                child: Text(
                                  category.name.toUpperCase(),
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              _selectedCategory = value;
                            });
                          }
                        },
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          // to close the overlay screen "adding new expense" when tapped on cancel button
                          // pop method simply removes this overlay "context" from the screen {"close the new expense screen"}
                          Navigator.pop(context);
                        },
                        child: const Text('Cancel'),
                      ),
                      ElevatedButton(
                        onPressed: _submitExpenseDate,
                        child: const Text('Save Expense'),
                      )
                    ],
                  )
              ],
            ),
          ),
        ),
      );
    });
    // ? so as we mentioned before, in this scenario, where this new expense widget effectively does take up the entire screen anyways,
    // ? we could have also simply used MediaQuery as we did in the expenses widget, but we used alternative approach using layoutBuilder
    // ? which can be very useful if we have a widget that should only care about its parent widget and not necessarily about the entire available screen size.
  }
}
