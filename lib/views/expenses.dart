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
        body: Column(
          children: <Widget>[
            Chart(expenses: _expenses),
            _expenses.isEmpty
                ? const Center(
                    child:
                        Text('No se encontraron gastos. Empieza a agregarlos!'),
                  )
                : Expanded(
                    child: ExpensesList(
                      onDeleteExpense: _deleteExpense,
                      expenses: _expenses,
                    ),
                  ),
          ],
        ));
  }
}
