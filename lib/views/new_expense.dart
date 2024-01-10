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
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;

    return LayoutBuilder(builder: (context, constraints) {
      final width = constraints.maxWidth;

      return SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, keyboardSpace + 16),
            child: Column(
              children: <Widget>[
                if (width >= 600)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(child: _buildTitleTextField()),
                      const SizedBox(width: 24),
                      Expanded(
                        child: _buildAmountTextField(),
                      ),
                    ],
                  )
                else
                  _buildTitleTextField(),
                Row(
                  children: <Widget>[
                    if (width < 600)
                      Expanded(
                        child: _buildTextField(
                            controller: _amountController,
                            prefixText: '\$',
                            labelText: 'Monto',
                            keyboardType: TextInputType.number),
                      ),
                    if (width < 600) const SizedBox(width: 5),
                    Expanded(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
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
                    )),
                    if (width >= 600)
                      Expanded(
                        child: _buildDropdown(),
                      ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  children: <Widget>[
                    if (width < 600) _buildDropdown(),
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
          ),
        ),
      );
    });
  }

  Widget _buildTitleTextField() {
    return _buildTextField(
      maxLength: 50,
      controller: _titleController,
      labelText: 'Título',
      keyboardType: TextInputType.text,
    );
  }

  Widget _buildAmountTextField() {
    return _buildTextField(
      controller: _amountController,
      prefixText: '\$',
      labelText: 'Monto',
      keyboardType: TextInputType.number,
    );
  }

  Widget _buildDropdown() {
    return DropdownButton(
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
        });
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
