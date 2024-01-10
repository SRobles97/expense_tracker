import 'package:expense_tracker/utils/mocked_expenses.dart';
import 'package:expense_tracker/views/new_expense.dart';
import 'package:expense_tracker/widgets/chart/chart.dart';
import 'package:expense_tracker/widgets/expenses_list.dart';
import 'package:flutter/material.dart';

import '../models/expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({Key? key}) : super(key: key);

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  List<Expense> _expenses = [];

  @override
  void initState() {
    super.initState();
    initializeExpensesList();
  }

  void initializeExpensesList() {
    _expenses = MockedExpenses.getMockedExpenses();
  }

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      useSafeArea: true,
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return NewExpense(
          onAddExpense: _addExpense,
        );
      },
    );
  }

  void _addExpense(Expense expense) {
    setState(() {
      _expenses.add(expense);
    });
  }

  void _deleteExpense(Expense expense) {
    final expenseIndex = _expenses.indexOf(expense);
    setState(() {
      _expenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Gasto eliminado'),
        duration: const Duration(seconds: 2),
        action: SnackBarAction(
          label: 'Deshacer',
          onPressed: () {
            setState(() {
              _expenses.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          title: const Text('Flutter ExpenseTracker'),
          actions: [
            IconButton(
              onPressed: _openAddExpenseOverlay,
              icon: const Icon(Icons.add),
            ),
          ],
        ),
        body: width < 600
            ? Column(
                children: [
                  Chart(expenses: _expenses),
                  Expanded(
                    child: ExpensesList(
                      expenses: _expenses,
                      onDeleteExpense: _deleteExpense,
                    ),
                  ),
                ],
              )
            : Row(
                children: [
                  Expanded(
                    child: ExpensesList(
                      expenses: _expenses,
                      onDeleteExpense: _deleteExpense,
                    ),
                  ),
                  SizedBox(
                    width: 300,
                    child: Chart(expenses: _expenses),
                  ),
                ],
              ));
  }
}
