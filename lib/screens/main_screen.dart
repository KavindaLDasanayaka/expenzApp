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
    });
  }

  //function to fetch all income
  void fetchAllIncome() async {
    List<Income> loadedIncome = await IncomeService().loadIncome();
    setState(() {
      incomeList = loadedIncome;
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

  //function to remove expense
  void removeExpense(Expense expense) {
    ExpenseService().deleteExpense(expense.id, context);
    setState(() {
      expenseList.remove(expense);
    });
  }

  //function to remove the income
  void removeIncome(Income income) {
    IncomeService().deleteIncome(income.id, context);
    setState(() {
      incomeList.remove(income);
    });
  }

  //category total expenses
  Map<ExpenseCategory, double> calculateExpenseCategories() {
    Map<ExpenseCategory, double> categoryTotal = {
      ExpenseCategory.food: 0,
      ExpenseCategory.health: 0,
      ExpenseCategory.shopping: 0,
      ExpenseCategory.subscriptions: 0,
      ExpenseCategory.transport: 0,
    };

    for (Expense expense in expenseList) {
      categoryTotal[expense.category] =
          categoryTotal[expense.category]! + expense.amount;
    }
    return categoryTotal;
  }

  //category total incomes
  Map<IncomeCategory, double> calculateIncomeCategories() {
    Map<IncomeCategory, double> categoryTotal = {
      IncomeCategory.freelance: 0,
      IncomeCategory.passive: 0,
      IncomeCategory.salary: 0,
      IncomeCategory.sales: 0,
    };

    for (Income income in incomeList) {
      categoryTotal[income.category] =
          categoryTotal[income.category]! + income.amount;
    }
    return categoryTotal;
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      HomeScreen(expenseList: expenseList, incomeList: incomeList),
      TransactionsScreen(
        expenseList: expenseList,
        incomeList: incomeList,
        onDissMissedExpense: removeExpense,
        onDissMiessIncome: removeIncome,
      ),
      AddNewScreen(addExpense: addNewExpense, addIncome: addNewIncome),
      BudgetScreen(
        incomeCategoryTotal: calculateIncomeCategories(),
        expenseCategoryTotal: calculateExpenseCategories(),
      ),
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
