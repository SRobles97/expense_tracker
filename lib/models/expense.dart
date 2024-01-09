import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

final formatter = DateFormat.yMd();

enum Category { food, travel, leisure, work }

String getLocalizedName(Category category) {
  switch (category) {
    case Category.food:
      return 'Comida';
    case Category.travel:
      return 'Viaje';
    case Category.leisure:
      return 'Ocio';
    case Category.work:
      return 'Trabajo';
    default:
      return 'Desconocido';
  }
}

const categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight_takeoff,
  Category.leisure: Icons.movie,
  Category.work: Icons.work,
};

class Expense {
  final String id;
  final String title;
  final String description;
  final double amount;
  final DateTime date;
  final Category category;

  Expense(
      {required this.title,
      required this.description,
      required this.amount,
      required this.date,
      required this.category})
      : id = uuid.v4();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'amount': amount,
      'date': date,
    };
  }

  get formattedAmount {
    return '\$${amount.toStringAsFixed(0).replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (match) => '${match[1]}.',
        )}';
  }

  get icon {
    return categoryIcons[category];
  }

  get formattedDate {
    return formatter.format(date);
  }
}

class ExpenseBucket {
  final Category category;
  final List<Expense> expenses;

  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses
            .where((expense) => expense.category == category)
            .toList();

  ExpenseBucket({required this.category, required this.expenses});

  double get totalExpenses {
    return expenses.fold(0, (total, expense) => total + expense.amount);
  }
}
