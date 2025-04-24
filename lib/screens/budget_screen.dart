import 'package:expenz/constants/colors.dart';
import 'package:expenz/constants/constants.dart';
import 'package:expenz/models/expense_model.dart';
import 'package:expenz/models/income_model.dart';
import 'package:expenz/widgets/category_card.dart';
import 'package:expenz/widgets/pie_chart.dart';
import 'package:flutter/material.dart';

class BudgetScreen extends StatefulWidget {
  final Map<ExpenseCategory, double> expenseCategoryTotal;
  final Map<IncomeCategory, double> incomeCategoryTotal;

  const BudgetScreen({
    super.key,
    required this.expenseCategoryTotal,
    required this.incomeCategoryTotal,
  });

  @override
  State<BudgetScreen> createState() => _BudgetScreenState();
}

class _BudgetScreenState extends State<BudgetScreen> {
  int _selectedMethod = 0;

  //method to find the category color from the category
  Color getCategoryColor(dynamic category) {
    if (category is ExpenseCategory) {
      return expenseCategoryColors[category]!;
    } else {
      return incomeCategoryColors[category]!;
    }
  }

  @override
  Widget build(BuildContext context) {
    final data =
        _selectedMethod == 0
            ? widget.expenseCategoryTotal
            : widget.incomeCategoryTotal;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Financial Report",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: kBlack,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: kDefaultPadding,
                  vertical: kDefaultPadding / 2,
                ),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.06,
                  decoration: BoxDecoration(
                    // ignore: deprecated_member_use
                    color: kWhite,
                    borderRadius: BorderRadius.circular(100),

                    boxShadow: [
                      // ignore: deprecated_member_use
                      BoxShadow(color: kBlack.withOpacity(0.1), blurRadius: 20),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedMethod = 0;
                            });
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.04,

                            decoration: BoxDecoration(
                              color: _selectedMethod == 0 ? kRed : kWhite,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 50,
                                vertical: 5,
                              ),
                              child: Text(
                                "Expense",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: _selectedMethod == 0 ? kWhite : kBlack,
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedMethod = 1;
                            });
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.04,
                            decoration: BoxDecoration(
                              color: _selectedMethod == 1 ? kGreen : kWhite,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 50,
                                vertical: 5,
                              ),
                              child: Text(
                                "Income",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: _selectedMethod == 1 ? kWhite : kBlack,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              //pie chart implementing
              const SizedBox(height: 20),
              Chart(
                expenseCategoryTotal: widget.expenseCategoryTotal,
                incomeCategoryTotal: widget.incomeCategoryTotal,
                isExpense: _selectedMethod == 0,
              ),

              const SizedBox(height: 20),

              //list of categories
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: data.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    final category = data.keys.toList()[index];
                    final total = data.values.toList()[index];
                    return CategoryCard(
                      title: category.name,
                      amount: total,
                      total: data.values.reduce(
                        (value, element) => value + element,
                      ),
                      progressColor: getCategoryColor(category),
                      isExpense: _selectedMethod == 0,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
