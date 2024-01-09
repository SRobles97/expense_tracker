import '../models/expense.dart';

class MockedExpenses {
  static List<Expense> getMockedExpenses() {
    return [
      Expense(
        title: 'Subway',
        description: 'Desayuno pechuga de pollo 15cm',
        amount: 6400,
        date: DateTime.now(),
        category: Category.food,
      ),
      Expense(
        title: 'Dragon Quest Monsters: The Dark Prince',
        description: 'Me compre el juego de la Nintendo Switch',
        amount: 70000,
        date: DateTime.now(),
        category: Category.leisure,
      ),
      Expense(
        title: 'Pasajes',
        description: 'Gastos de micro de ida y vuelta de la Universidad',
        amount: 560,
        date: DateTime.now(),
        category: Category.travel,
      ),
    ];
  }
}
