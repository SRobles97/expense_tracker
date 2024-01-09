import 'package:flutter/material.dart';

import '../models/expense.dart';

class NewExpense extends StatefulWidget {
  final void Function(Expense expense) onAddExpense;

  const NewExpense({Key? key, required this.onAddExpense}) : super(key: key);

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  bool _showTitleError = false;
  bool _showAmountError = false;
  bool _showDateError = false;
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.food;

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );

    if (pickedDate == null) return;
    setState(() {
      _selectedDate = pickedDate;
      _showDateError = false;
    });
  }

  void _submitForm() {
    final title = _titleController.text.trim();
    final amount = double.tryParse(_amountController.text.trim()) ?? 0;

    setState(() {
      _showTitleError = title.isEmpty;
      _showAmountError = amount <= 0;
      _showDateError = _selectedDate == null;
    });

    if (_showTitleError || _showAmountError || _showDateError) return;

    final expense = Expense(
      title: title,
      amount: amount,
      date: _selectedDate!,
      category: _selectedCategory,
      description: '',
    );

    widget.onAddExpense(expense);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
      child: Column(
        children: <Widget>[
          _buildTextField(
            maxLength: 50,
            controller: _titleController,
            labelText: 'Título',
            keyboardType: TextInputType.text,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Visibility(
                visible: _showTitleError,
                child: const Text(
                  'Este campo es obligatorio',
                  style: TextStyle(color: Colors.red),
                )),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: _buildTextField(
                    controller: _amountController,
                    prefixText: '\$',
                    labelText: 'Monto',
                    keyboardType: TextInputType.number),
              ),
              const SizedBox(width: 8),
              Expanded(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      const Text('Fecha seleccionada: '),
                      Text(_selectedDate == null
                          ? 'Ninguna'
                          : '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'),
                    ],
                  ),
                  IconButton(
                      onPressed: _presentDatePicker,
                      icon: const Icon(Icons.calendar_today))
                ],
              ))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Visibility(
                    visible: _showAmountError,
                    child: const Text(
                      'El monto es obligatorio',
                      style: TextStyle(color: Colors.red),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Visibility(
                    visible: _showDateError,
                    child: const Text(
                      'La fecha es obligatoria',
                      style: TextStyle(color: Colors.red),
                    )),
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: <Widget>[
              DropdownButton(
                  value: _selectedCategory,
                  items: Category.values.map(
                    (category) {
                      return DropdownMenuItem(
                        value: category,
                        child: Text(getLocalizedName(category)),
                      );
                    },
                  ).toList(),
                  onChanged: (value) {
                    setState(() {
                      if (value is Category) {
                        _selectedCategory = value;
                      }
                    });
                  }),
              const Spacer(),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancelar')),
              ElevatedButton(
                  onPressed: _submitForm, child: const Text('Guardar')),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    int? maxLength,
    String? prefixText,
    required TextEditingController controller,
    required String labelText,
    required TextInputType keyboardType,
  }) {
    return TextField(
      maxLength: maxLength, // maxLength puede ser null ahora
      controller: controller,
      decoration: InputDecoration(
        prefixText: prefixText,
        labelText: labelText,
      ),
      keyboardType: keyboardType,
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }
}
