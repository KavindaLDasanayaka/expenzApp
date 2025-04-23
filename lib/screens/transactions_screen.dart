import 'package:expenz/constants/colors.dart';
import 'package:expenz/constants/constants.dart';
import 'package:expenz/models/expense_model.dart';
import 'package:expenz/models/income_model.dart';
import 'package:expenz/widgets/expense_card.dart';
import 'package:expenz/widgets/income_card.dart';
import 'package:flutter/material.dart';

class TransactionsScreen extends StatefulWidget {
  final List<Expense> expenseList;
  final List<Income> incomeList;
  final void Function(Expense) onDissMissedExpense;
  final void Function(Income) onDissMiessIncome;

  const TransactionsScreen({
    super.key,
    required this.expenseList,
    required this.onDissMissedExpense,
    required this.incomeList,
    required this.onDissMiessIncome,
  });

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(kDefaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "See your financial report",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: kMainColor,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "Expenses",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: kBlack,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: widget.expenseList.length,
                      itemBuilder: (context, index) {
                        final expense = widget.expenseList[index];
                        return Dismissible(
                          key: ValueKey(expense),
                          direction: DismissDirection.startToEnd,
                          onDismissed: (direction) {
                            setState(() {
                              widget.onDissMissedExpense(expense);
                            });
                          },
                          child: ExpenseCard(
                            title: expense.title,
                            date: expense.date,
                            amount: expense.amount,
                            category: expense.category,
                            description: expense.description,
                            time: expense.time,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Text(
                "Income",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: kBlack,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.27,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: ListView.builder(
                      itemCount: widget.incomeList.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final income = widget.incomeList[index];

                        return Dismissible(
                          onDismissed: (direction) {
                            setState(() {
                              widget.onDissMiessIncome(income);
                            });
                          },
                          key: ValueKey(income),
                          child: IncomeCard(
                            title: income.title,
                            description: income.description,
                            category: income.category,
                            amount: income.amount,
                            time: income.time,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
