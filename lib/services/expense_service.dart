import 'dart:convert';

import 'package:expenz/models/expense_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExpenseService {
  //Define the key for storing expenses in shared preferences
  static const String _expenseKey = 'expenses';

  //save the expense to shared preferences
  Future<void> saveExpenses(Expense expense, BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      //Shared preferences wala objects store kraganna ba e hinda ewa list of strings widiyata convert karagana store karaganne.
      List<String>? existingExpenses = prefs.getStringList(_expenseKey);

      //convert the existing expenses to a list of expense objects
      List<Expense> existingExpenseObjects = [];

      //existingExpenses eka empty naththam conversion eka karaganne.
      if (existingExpenses != null) {
        existingExpenseObjects =
            existingExpenses
                .map((e) => Expense.fromJSON(json.decode(e)))
                .toList();
      }

      //add the new expenses to the list
      existingExpenseObjects.add(expense);

      //convert the list of expense objects back to a list of strings.
      List<String> updatedExpenses =
          existingExpenseObjects.map((e) => json.encode(e.toJSON())).toList();

      //save the updated list of expenses to shared preferences
      await prefs.setStringList(_expenseKey, updatedExpenses);

      //show message
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Expense Added Successfully"),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (error) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error on Adding Expense!"),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  //load the expenses from shared pereferences
  Future<List<Expense>> loadExpenses() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    List<String>? existingExpenses = pref.getStringList(_expenseKey);

    //convert the existing expenses to a list of expense objects
    List<Expense> loadedExpenses = [];
    if (existingExpenses != null) {
      loadedExpenses =
          existingExpenses
              .map((e) => Expense.fromJSON(json.decode(e)))
              .toList();
    }
    return loadedExpenses;
  }

  //delete the expense from the shared preferences from the id
  Future<void> deleteExpense(int id, BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String>? existingExpenses = prefs.getStringList(_expenseKey);

      //convert the existing expenses to a list of expense objects.
      List<Expense> existingExpenseObjects = [];

      if (existingExpenses != null) {
        existingExpenseObjects =
            existingExpenses
                .map((e) => Expense.fromJSON(json.decode(e)))
                .toList();
      }

      //remove the selected id expense
      existingExpenseObjects.removeWhere((expens) => expens.id == id);

      //convert to json list of strings

      List<String> updatedExpenses =
          existingExpenseObjects.map((e) => json.encode(e.toJSON())).toList();

      //save updated list
      await prefs.setStringList(_expenseKey, updatedExpenses);

      //display success message
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Expense Deleted Successfully!"),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (error) {
      //display error message
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error Deleting Expense!"),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }
}
