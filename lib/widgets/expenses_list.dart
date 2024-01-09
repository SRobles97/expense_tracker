import 'package:expense_tracker/widgets/expense_item.dart';
import 'package:flutter/material.dart';

import '../models/expense.dart';

class ExpensesList extends StatelessWidget {
  final List<Expense> expenses;
  final void Function(Expense expense) onDeleteExpense;

  const ExpensesList(
      {Key? key, required this.expenses, required this.onDeleteExpense})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (context, index) {
        return Dismissible(
            background: Container(
              color: Theme.of(context).colorScheme.error,
              child: const Icon(
                Icons.delete,
                color: Colors.white,
                size: 40,
              ),
            ),
            key: ValueKey(expenses[index].id),
            onDismissed: (_) => onDeleteExpense(expenses[index]),
            child: ExpenseItem(expense: expenses[index]));
      },
    );
  }
}
