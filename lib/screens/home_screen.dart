import 'package:expenz/constants/colors.dart';
import 'package:expenz/constants/constants.dart';
import 'package:expenz/models/expense_model.dart';
import 'package:expenz/models/income_model.dart';
import 'package:expenz/services/user_service.dart';
import 'package:expenz/widgets/expense_card.dart';
import 'package:expenz/widgets/income_expence_card.dart';
import 'package:expenz/widgets/line_chart.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final List<Expense> expenseList;
  final List<Income> incomeList;
  const HomeScreen({
    super.key,
    required this.expenseList,
    required this.incomeList,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //for store the username
  String userName = "";
  double expenseTotal = 0;
  double incomeTotal = 0;

  @override
  void initState() {
    // TODO: implement initState
    UserServices.getUserData().then((value) {
      if (value["username"] != null) {
        setState(() {
          userName = value["username"]!;
        });
      }
    });
    setState(() {
      //total amount of expenses
      for (var i = 0; i < widget.expenseList.length; i++) {
        expenseTotal += widget.expenseList[i].amount;
      }

      for (var k = 0; k < widget.incomeList.length; k++) {
        incomeTotal += widget.incomeList[k].amount;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ignore: deprecated_member_use
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //bg color column
              Container(
                height: MediaQuery.of(context).size.height * 0.25,

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                  // ignore: deprecated_member_use
                  color: kMainColor.withOpacity(0.37),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(kDefaultPadding),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: kMainColor,
                              border: Border.all(color: kMainColor, width: 3),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.asset(
                                "assets/images/user.jpg",
                                width: 50,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),

                          Text(
                            "Welcome, $userName",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(width: 20),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.notifications,
                              color: kMainColor,
                              size: 30,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IncomeExpenceCard(
                            title: "Income",
                            amount: incomeTotal,
                            imageUrl: "assets/images/income.png",
                            bgColor: kGreen,
                          ),
                          IncomeExpenceCard(
                            title: "Expense",
                            amount: expenseTotal,
                            imageUrl: "assets/images/expense.png",
                            bgColor: kRed,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              //line chart display
              const Padding(
                padding: EdgeInsets.all(kDefaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Spend Frequency",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 20),
                    LineChartSample(),
                  ],
                ),
              ),

              //recent transactions
              Padding(
                padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Recent Transactions",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        widget.expenseList.isEmpty
                            ? Text(
                              "No expenses added yet, add some expenses to see here.",
                              style: TextStyle(fontSize: 16, color: kGrey),
                            )
                            : ListView.builder(
                              itemCount: widget.expenseList.length,
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                final expense = widget.expenseList[index];
                                return ExpenseCard(
                                  title: expense.title,
                                  date: expense.date,
                                  amount: expense.amount,
                                  category: expense.category,
                                  description: expense.description,
                                  time: expense.time,
                                );
                              },
                            ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
