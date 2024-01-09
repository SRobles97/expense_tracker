import 'package:flutter/material.dart';

import '../models/expense.dart';

class ExpenseItem extends StatelessWidget {
  final Expense expense;

  const ExpenseItem({
    required this.expense,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              expense.title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(
              height: 4,
            ),
            Row(
              children: <Widget>[
                Text(expense.formattedAmount),
                const Spacer(),
                Row(
                  children: <Widget>[
                    Icon(
                      expense.icon,
                      size: 16,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(expense.formattedDate),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
