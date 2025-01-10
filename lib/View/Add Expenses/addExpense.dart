import 'package:expense_tracker2/Modal/auth.dart';
import 'package:expense_tracker2/Modal/transaction.dart';
import 'package:expense_tracker2/Provider/UserProvider.dart';
import 'package:expense_tracker2/Provider/expenseTrackerProvider.dart';
import 'package:expense_tracker2/Provider/sessionProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddExpense extends ConsumerStatefulWidget {
  const AddExpense({super.key});

  @override
  ConsumerState<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends ConsumerState<AddExpense> {
  @override
  void initState() {
    super.initState();
    addTransaction();
  }

  void addTransaction() {
    final email = ref.read(sessionProvider).user?.email;
    ref.read(expenseTrackerProvider).loadData(email!);
    debugPrint('Data is loaded');
  }

  final _formKey = GlobalKey<FormState>();
  String? _expenseName;
  String? _category = 'Food';
  double? _amount;
  DateTime _selectedDate = DateTime.now();
  OverlayEntry? _overlayEntry;
  String? _customCategory;
  final _customCategoryController = TextEditingController();

  // Dynamic list of categories with "Other" always at the end
  final List<String> _categories = ["Food", "Transport", "Shopping", "Other"];

  @override
  Widget build(BuildContext context) {
    // Define blue color palette
    const Color primaryBlue = Colors.blue;
    final Color lightBlue = Colors.blue.shade100;
    const Color blueAccent = Colors.blueAccent;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add Expense",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: primaryBlue,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Expense Name Field
                const Text(
                  "Expense Name",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryBlue,
                  ),
                ),
                const SizedBox(height: 8.0),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "Enter expense name",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: lightBlue),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: blueAccent),
                    ),
                  ),
                  onSaved: (value) {
                    _expenseName = value;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter an expense name";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),

                // Amount Field
                const Text(
                  "Amount",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryBlue,
                  ),
                ),
                const SizedBox(height: 8.0),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "Enter amount",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: lightBlue),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: blueAccent),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  onSaved: (value) {
                    _amount = double.tryParse(value ?? '');
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter an amount";
                    } else if (double.tryParse(value) == null) {
                      return "Please enter a valid number";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),

                // Date Picker
                const Text(
                  "Date",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryBlue,
                  ),
                ),
                const SizedBox(height: 8.0),
                Row(
                  children: [
                    Text(
                      "${_selectedDate.toLocal()}".split(' ')[0],
                      style: const TextStyle(fontSize: 16),
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () => _selectDate(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: blueAccent,
                      ),
                      child: const Text(
                        "Select Date",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),

                // Category Dropdown
                const Text(
                  "Category",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryBlue,
                  ),
                ),
                const SizedBox(height: 8.0),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    hintText: "Select category",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: lightBlue),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: blueAccent),
                    ),
                  ),
                  value: _category,
                  items: _categories
                      .map((category) => DropdownMenuItem<String>(
                            value: category,
                            child: Text(category),
                          ))
                      .toList(),
                  onChanged: (value) {
                    if (value == "Other") {
                      _showCustomCategoryOverlay(context);
                    } else {
                      setState(() {
                        _category = value;
                      });
                    }
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please select a category";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24.0),

                // Submit Button
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        _formKey.currentState?.save();
                        // Show confirmation
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Expense added successfully!"),
                          ),
                        );
                        // Submit form logic
                        debugPrint("Expense Name: $_expenseName");
                        debugPrint("Amount: $_amount");
                        debugPrint("Category: $_category");
                        debugPrint("Date: $_selectedDate");

                        ref.read(expenseTrackerProvider).addTransaction(
                            Transaction(
                                title: _expenseName!,
                                amount: _amount.toString(),
                                category: _category!,
                                discription: '',
                                transactionType: 'Expense',
                                bankType: '',
                                time: _selectedDate.toIso8601String()));
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: blueAccent,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24.0, vertical: 12.0),
                    ),
                    child: const Text(
                      "Submit",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Date picker function
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  // Show the overlay for custom category input
  void _showCustomCategoryOverlay(BuildContext context) {
    OverlayState overlayState = Overlay.of(context);
    _overlayEntry = _createOverlayEntry(context);

    overlayState.insert(_overlayEntry!);
  }

  OverlayEntry _createOverlayEntry(BuildContext context) {
    return OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).size.height * 0.25,
        left: MediaQuery.of(context).size.width * 0.1,
        width: MediaQuery.of(context).size.width * 0.8,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10.0,
                  spreadRadius: 2.0,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Enter Custom Category",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8.0),
                TextField(
                  controller: _customCategoryController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter category name",
                  ),
                ),
                const SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        _customCategoryController.clear();
                        _overlayEntry?.remove();
                      },
                      child: const Text("Cancel"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _customCategory = _customCategoryController.text;
                          // Remove "Other" from the list, add the custom category, and re-add "Other"
                          _categories.remove("Other");
                          _categories.add(_customCategory!);
                          _categories.add("Other");
                          _category = _customCategory;
                        });
                        _customCategoryController.clear();
                        _overlayEntry?.remove();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                      ),
                      child: const Text(
                        "Add",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
