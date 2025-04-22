import 'package:expenz/constants/colors.dart';
import 'package:expenz/models/expense_model.dart';
import 'package:expenz/models/income_model.dart';
import 'package:expenz/screens/add_new_screen.dart';
import 'package:expenz/screens/budget_screen.dart';
import 'package:expenz/screens/home_screen.dart';
import 'package:expenz/screens/profile_screen.dart';
import 'package:expenz/screens/transactions_screen.dart';
import 'package:expenz/services/expense_service.dart';
import 'package:expenz/services/income_service.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentPageIndex = 0;

  List<Expense> expenseList = [];
  List<Income> incomeList = [];

  //function to fetch expenses
  void fetchAllExpenses() async {
    List<Expense> loadedExpense = await ExpenseService().loadExpenses();
    setState(() {
      expenseList = loadedExpense;
      print(expenseList.length);
    });
  }

  //function to fetch income
  void fetchAllIncome() async {
    List<Income> loadIncome = await IncomeService().loadIncome();
    setState(() {
      incomeList = loadIncome;
      print(incomeList.length);
    });
  }

  void addNewExpense(Expense newExpense) {
    ExpenseService().saveExpenses(newExpense, context);

    //update the list of expenses
    setState(() {
      expenseList.add(newExpense);
    });
  }

  void addNewIncome(Income newIncome) {
    IncomeService().saveIncome(newIncome, context);
    setState(() {
      incomeList.add(newIncome);
    });
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    setState(() {
      fetchAllExpenses();
      fetchAllIncome();
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      HomeScreen(),
      TransactionsScreen(),
      AddNewScreen(addExpense: addNewExpense, addIncome: addNewIncome),
      BudgetScreen(),
      ProfileScreen(),
    ];

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentPageIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: kWhite,
        selectedItemColor: kMainColor,
        unselectedItemColor: kGrey,
        onTap: (index) {
          setState(() {
            _currentPageIndex = index;
          });
        },
        selectedLabelStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_rounded),
            label: "Transactions",
          ),
          BottomNavigationBarItem(
            icon: Container(
              decoration: BoxDecoration(
                color: kMainColor,
                shape: BoxShape.circle,
              ),
              padding: EdgeInsets.all(10),
              child: Icon(Icons.add, color: kWhite, size: 30), //
            ),
            label: "",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.rocket), label: "Budget"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
      body: pages[_currentPageIndex],
    );
  }
}
