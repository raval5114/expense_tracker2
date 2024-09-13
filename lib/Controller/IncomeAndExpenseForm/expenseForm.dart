// import 'package:expense_tracker2/Provider/expenseTrackerProvider.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class ExpenseForm extends ConsumerStatefulWidget {
//   const ExpenseForm({super.key});

//   @override
//   ConsumerState<ExpenseForm> createState() => _ExpenseFormState();
// }

// class _ExpenseFormState extends ConsumerState<ExpenseForm> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _title = TextEditingController();
//   final TextEditingController _amount = TextEditingController();
//   final TextEditingController _description = TextEditingController();

//   String _dropDownDefaultItem = 'Others';

//   @override
//   Widget build(BuildContext context) {
//     return Form(
//         key: _formKey,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           //   crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             TextFormField(
//               autofocus: true,
//               style: const TextStyle(
//                   fontSize: 32,
//                   fontWeight: FontWeight.w700,
//                   color: Colors.blueAccent),
//               //cursorWidth: 1,
//               keyboardType: TextInputType.number,
//               inputFormatters: <TextInputFormatter>[
//                 FilteringTextInputFormatter.digitsOnly
//               ],
//               controller: _amount,
//               validator: (value) {
//                 if (value!.isEmpty) {
//                   return 'Enter Amount!!!';
//                 }
//                 return null;
//               },
//               decoration: const InputDecoration(
//                   prefix: Icon(
//                     Icons.currency_rupee,
//                     color: Colors.blueAccent,
//                   ),
//                   label: Text(
//                     'Enter Amount:',
//                     style: TextStyle(
//                         color: Colors.blueGrey,
//                         fontSize: 20,
//                         fontWeight: FontWeight.w700),
//                   ),
//                   suffix: Text(
//                     "INR",
//                     style: TextStyle(color: Colors.blueAccent),
//                   )),
//             ),
//             TextFormField(
//               style: const TextStyle(
//                   fontSize: 32,
//                   fontWeight: FontWeight.w700,
//                   color: Colors.blueAccent),
//               controller: _title,
//               decoration: const InputDecoration(
//                   label: Text(
//                 'Enter Title:',
//                 style: TextStyle(
//                     color: Colors.blueGrey,
//                     fontSize: 20,
//                     fontWeight: FontWeight.w700),
//               )),
//               validator: (value) {
//                 if (value!.isEmpty) {
//                   return 'Enter Title!!!';
//                 }
//                 return null;
//               },
//             ),
//             DropdownButtonFormField(
//                 //     padding: const EdgeInsets.all(12),
//                 value: _dropDownDefaultItem,
//                 style: const TextStyle(
//                     color: Colors.blueAccent,
//                     fontSize: 18,
//                     fontWeight: FontWeight.w700),
//                 decoration: const InputDecoration(
//                     label: Text(
//                   "Expenses made for",
//                   style: TextStyle(
//                       color: Colors.blueGrey,
//                       fontSize: 20,
//                       fontWeight: FontWeight.w700),
//                 )),
//                 dropdownColor: Colors.white,

//                 //style: const TextStyle(color: Colors.Blure),
//                 items: const [
//                   DropdownMenuItem(value: 'Bills', child: Text('Bills')),
//                   DropdownMenuItem(
//                       value: 'Subscriptions', child: Text('Subcriptions')),
//                   DropdownMenuItem(value: 'Dinning', child: Text('Dinning')),
//                   DropdownMenuItem(value: 'Rent', child: Text('Rent')),
//                   DropdownMenuItem(value: 'Others', child: Text('Others'))
//                 ],
//                 onChanged: (String? value) {
//                   setState(() {
//                     _dropDownDefaultItem = value!;
//                   });
//                 }),
//             TextFormField(
//               maxLines: 3,
//               controller: _description,
//               style: const TextStyle(
//                   color: Colors.blueAccent,
//                   fontSize: 22,
//                   fontWeight: FontWeight.w700),
//               decoration: const InputDecoration(
//                   label: Text(
//                 "Enter Description(Optional):",
//                 style: TextStyle(
//                     color: Colors.blueGrey,
//                     fontSize: 20,
//                     fontWeight: FontWeight.w700),
//               )),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 20.0),
//               child: TextButton(
//                   style: const ButtonStyle(
//                       backgroundColor:
//                           MaterialStatePropertyAll(Colors.blueAccent),
//                       fixedSize: MaterialStatePropertyAll(Size.infinite)),
//                   onPressed: () {
//                     if (_formKey.currentState!.validate()) {
//                       ref.watch(expenseTrackerProvider).addExpense(
//                           _amount.text.toString(),
//                           _title.text.toString(),
//                           _dropDownDefaultItem,
//                           _description.text.toString());

//                       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                           content: Text(
//                               "Amount of ${_amount.text.toString()} is debited sucessfully")));
//                     }
//                     //debugPrint('');
//                   },
//                   child: const Text(
//                     'Pay Amount',
//                     style: TextStyle(color: Colors.white),
//                   )),
//             )
//           ],
//         ));
//   }
// }
