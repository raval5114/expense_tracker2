import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AllPieChartComponents extends StatefulWidget {
  const AllPieChartComponents({super.key});

  @override
  State<AllPieChartComponents> createState() => _AllPieChartComponentsState();
}

class _AllPieChartComponentsState extends State<AllPieChartComponents> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 520,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              "Insights:",
              style: TextStyle(
                  fontSize: 30,
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.w700),
            ),
          ),
          const SizedBox(height: 10),
          // Wrapping ListView in a SizedBox to give it height
          SizedBox(
            height: 350, // Set desired height
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: const [
                SizedBox(
                  width: 300, // Set the width for each Card
                  height: 320,
                  child: Card(
                    elevation: 10,
                    child: PieChartComponent(),
                  ),
                ),
                SizedBox(
                  width: 300,
                  child: Card(
                    elevation: 10,
                    child: PieChartForCategoryForIncome(),
                  ),
                ),
                SizedBox(
                  width: 300,
                  child: Card(
                    elevation: 10,
                    child: PieChartForCategoryForExpense(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PieChartComponent extends ConsumerStatefulWidget {
  const PieChartComponent({super.key});

  @override
  ConsumerState<PieChartComponent> createState() => _PieChartComponentState();
}

class _PieChartComponentState extends ConsumerState<PieChartComponent> {
  int _touchedIndex = -1; // Keeps track of which section is touched
  String _touchedCategory = ""; // Keeps track of the touched category
  double _touchedValue = 0; // Keeps track of the touched value

  final List<Map<String, dynamic>> data = [
    {"Transaction Type": "Expense", "value": 15000, "color": Colors.red},
    {"Transaction Type": "Income", "value": 20000, "color": Colors.green},
  ];

  List<PieChartSectionData> _generateSections() {
    return data.asMap().entries.map((entry) {
      int index = entry.key;
      Map<String, dynamic> item = entry.value;

      final bool isTouched = index == _touchedIndex;
      final double fontSize =
          isTouched ? 18.0 : 14.0; // Larger text for touched section
      final double radius =
          isTouched ? 70.0 : 60.0; // Increase the radius when touched

      return PieChartSectionData(
        value: item["value"].toDouble(),
        color: item["color"],
        title: '${item["value"]}',
        radius: radius,
        titleStyle: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
      );
    }).toList();
  }

  void _updateTouchedData(int index) {
    if (index != -1) {
      setState(() {
        _touchedCategory = data[index]["Transaction Type"];
        _touchedValue = data[index]["value"].toDouble();
      });
    } else {
      setState(() {
        _touchedCategory = "";
        _touchedValue = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Income/Expense Ratio"),
        if (_touchedIndex != -1) ...[
          const SizedBox(height: 20),
          Text(
            'Category: $_touchedCategory',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            'Value: $_touchedValue',
            style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
          ),
        ],
        const SizedBox(height: 0),
        // Wrap the PieChart in a SizedBox or Container with a fixed height
        SizedBox(
          height: 300, // Set the desired height
          child: PieChart(
            swapAnimationDuration: const Duration(milliseconds: 750),
            swapAnimationCurve: Curves.easeInOutQuint,
            PieChartData(
              pieTouchData: PieTouchData(
                touchCallback: (FlTouchEvent event, pieTouchResponse) {
                  if (event is FlTapUpEvent) {
                    setState(() {
                      if (!event.isInterestedForInteractions ||
                          pieTouchResponse == null ||
                          pieTouchResponse.touchedSection == null) {
                        _touchedIndex = -1;
                        _updateTouchedData(-1);
                        return;
                      }
                      _touchedIndex =
                          pieTouchResponse.touchedSection!.touchedSectionIndex;
                      _updateTouchedData(_touchedIndex);
                    });
                  }
                },
              ),
              sections: _generateSections(),
              sectionsSpace: 2,
              centerSpaceRadius: 50,
            ),
          ),
        ),
      ],
    );
  }
}

class PieChartForCategoryForIncome extends ConsumerStatefulWidget {
  const PieChartForCategoryForIncome({super.key});

  @override
  ConsumerState<PieChartForCategoryForIncome> createState() =>
      _PieChartForCategoryForIncomeState();
}

class _PieChartForCategoryForIncomeState
    extends ConsumerState<PieChartForCategoryForIncome> {
  int _touchedIndex = -1; // Keeps track of which section is touched
  String _touchedCategory = ""; // Keeps track of the touched category
  double _touchedValue = 0; // Keeps track of the touched value

  final List<Map<String, dynamic>> incomeData = [
    {"Category": "Salary", "value": 30000, "color": Colors.green},
    {"Category": "Investments", "value": 12000, "color": Colors.blue},
    {"Category": "Freelance", "value": 8000, "color": Colors.orange},
    {"Category": "Other", "value": 5000, "color": Colors.purple},
  ];

  List<PieChartSectionData> _generateSections() {
    return incomeData.asMap().entries.map((entry) {
      int index = entry.key;
      Map<String, dynamic> item = entry.value;

      final bool isTouched = index == _touchedIndex;
      final double fontSize =
          isTouched ? 18.0 : 14.0; // Larger text for touched section
      final double radius =
          isTouched ? 70.0 : 60.0; // Increase the radius when touched

      return PieChartSectionData(
        value: item["value"].toDouble(),
        color: item["color"],
        title: '${item["value"]}',
        radius: radius,
        titleStyle: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
      );
    }).toList();
  }

  void _updateTouchedData(int index) {
    if (index != -1) {
      setState(() {
        _touchedCategory = incomeData[index]["Category"];
        _touchedValue = incomeData[index]["value"].toDouble();
      });
    } else {
      setState(() {
        _touchedCategory = "";
        _touchedValue = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Income Breakdown by Category"),
        if (_touchedIndex != -1) ...[
          const SizedBox(height: 20),
          Text(
            'Category: $_touchedCategory',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            'Value: $_touchedValue',
            style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
          ),
        ],
        const SizedBox(height: 0),
        // Wrap the PieChart in a SizedBox or Container with a fixed height
        SizedBox(
          height: 300, // Set the desired height
          child: PieChart(
            swapAnimationDuration: const Duration(milliseconds: 750),
            swapAnimationCurve: Curves.easeInOutQuint,
            PieChartData(
              pieTouchData: PieTouchData(
                touchCallback: (FlTouchEvent event, pieTouchResponse) {
                  if (event is FlTapUpEvent) {
                    setState(() {
                      if (!event.isInterestedForInteractions ||
                          pieTouchResponse == null ||
                          pieTouchResponse.touchedSection == null) {
                        _touchedIndex = -1;
                        _updateTouchedData(-1);
                        return;
                      }
                      _touchedIndex =
                          pieTouchResponse.touchedSection!.touchedSectionIndex;
                      _updateTouchedData(_touchedIndex);
                    });
                  }
                },
              ),
              sections: _generateSections(),
              sectionsSpace: 2,
              centerSpaceRadius: 50,
            ),
          ),
        ),
      ],
    );
  }
}

class PieChartForCategoryForExpense extends ConsumerStatefulWidget {
  const PieChartForCategoryForExpense({super.key});

  @override
  ConsumerState<PieChartForCategoryForExpense> createState() =>
      _PieChartForCategoryForExpenseState();
}

class _PieChartForCategoryForExpenseState
    extends ConsumerState<PieChartForCategoryForExpense> {
  int _touchedIndex = -1; // Keeps track of which section is touched
  String _touchedCategory = ""; // Keeps track of the touched category
  double _touchedValue = 0; // Keeps track of the touched value

  // Updated data to represent different expense categories
  final List<Map<String, dynamic>> expenseData = [
    {"Category": "Rent", "value": 10000, "color": Colors.red},
    {"Category": "Groceries", "value": 5000, "color": Colors.orange},
    {"Category": "Entertainment", "value": 2000, "color": Colors.blue},
    {"Category": "Utilities", "value": 1500, "color": Colors.purple},
    {"Category": "Transport", "value": 1000, "color": Colors.teal},
  ];

  List<PieChartSectionData> _generateSections() {
    return expenseData.asMap().entries.map((entry) {
      int index = entry.key;
      Map<String, dynamic> item = entry.value;

      final bool isTouched = index == _touchedIndex;
      final double fontSize =
          isTouched ? 18.0 : 14.0; // Larger text for touched section
      final double radius =
          isTouched ? 70.0 : 60.0; // Increase the radius when touched

      return PieChartSectionData(
        value: item["value"].toDouble(),
        color: item["color"],
        title: '${item["value"]}',
        radius: radius,
        titleStyle: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
      );
    }).toList();
  }

  void _updateTouchedData(int index) {
    if (index != -1) {
      setState(() {
        _touchedCategory = expenseData[index]["Category"];
        _touchedValue = expenseData[index]["value"].toDouble();
      });
    } else {
      setState(() {
        _touchedCategory = "";
        _touchedValue = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Expense Breakdown by Category"),
        if (_touchedIndex != -1) ...[
          const SizedBox(height: 20),
          Text(
            'Category: $_touchedCategory',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            'Value: $_touchedValue',
            style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
          ),
        ],
        const SizedBox(height: 0),
        // Wrap the PieChart in a SizedBox or Container with a fixed height
        SizedBox(
          height: 300, // Set the desired height
          child: PieChart(
            swapAnimationDuration: const Duration(milliseconds: 750),
            swapAnimationCurve: Curves.easeInOutQuint,
            PieChartData(
              pieTouchData: PieTouchData(
                touchCallback: (FlTouchEvent event, pieTouchResponse) {
                  if (event is FlTapUpEvent) {
                    setState(() {
                      if (!event.isInterestedForInteractions ||
                          pieTouchResponse == null ||
                          pieTouchResponse.touchedSection == null) {
                        _touchedIndex = -1;
                        _updateTouchedData(-1);
                        return;
                      }
                      _touchedIndex =
                          pieTouchResponse.touchedSection!.touchedSectionIndex;
                      _updateTouchedData(_touchedIndex);
                    });
                  }
                },
              ),
              sections: _generateSections(),
              sectionsSpace: 2,
              centerSpaceRadius: 50,
            ),
          ),
        ),
      ],
    );
  }
}
