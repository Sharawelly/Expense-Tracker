// we download this package to make us generate unique ID dynamically whenever a new expense object is created
import 'package:flutter/material.dart';
// we download this package to make us format our Date
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

final formatter = DateFormat.yMd();

const uuid = Uuid();

// fixed set of allowed values so that we have to use on of those values when creating new expense (enum is a combination of predefined allowed values)
// all values in enums are constant variables
enum Category {
  food,
  travel,
  leisure,
  work,
}

// map
const categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight_takeoff,
  Category.leisure: Icons.movie,
  Category.work: Icons.work,
};

// this class will describe which data structure an expense in this app should have (which kind of structure an expense should have)
class Expense {
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid
            .v4(); // generate unique id dynamically whenever a new expense object is created

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  // getter methods in dart
  String get formattedDate {
    return formatter.format(date);
  }
}

// this class is for our chart
// One ExpenseBucket for every category
class ExpenseBucket {
  const ExpenseBucket({
    required this.category,
    required this.expenses,
  });

  // new additional constructor
  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
      // don't forget "where" is used to filter elements into a new list based on some condition
      : expenses = allExpenses
            .where((expense) => expense.category == category)
            .toList();

  final Category category;
  final List<Expense> expenses;

  double get totalExpenses {
    double sum = 0;
    for (final expense in expenses) {
      sum += expense.amount;
    }

    return sum;
  }
}
