import 'dart:convert';

import 'package:expenz/models/income_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IncomeService {
  //define the key for store list
  static const String _incomeKey = 'income';

  //method to store
  Future<void> saveIncome(Income income, BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      List<String>? existingIncomeList = prefs.getStringList(_incomeKey);

      List<Income> existingIncomeObject = [];

      if (existingIncomeList != null) {
        existingIncomeObject =
            existingIncomeList
                .map((e) => Income.fromJSON(json.decode(e)))
                .toList();
      }

      //add the new income to list
      existingIncomeObject.add(income);

      //convert the object list to json string list
      List<String> updatedIncomeList =
          existingIncomeObject.map((e) => json.encode(e.toJSON())).toList();

      //save in shared prefereces
      await prefs.setStringList(_incomeKey, updatedIncomeList);

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Income Added Successfully!"),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (error) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Income Adding Failed!"),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  Future<List<Income>> loadIncome() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String>? existingIncomeList = prefs.getStringList(_incomeKey);

    List<Income> loadedIncomeList = [];

    if (existingIncomeList != null) {
      loadedIncomeList =
          existingIncomeList
              .map((e) => Income.fromJSON(json.decode(e)))
              .toList();
    }

    return loadedIncomeList;
  }

  //delete income from shared preferences
  Future<void> deleteIncome(int id, BuildContext context) async {
    try {
      //get instance
      SharedPreferences prefs = await SharedPreferences.getInstance();

      List<String>? existingIncomeList = prefs.getStringList(_incomeKey);

      List<Income> existingIncomeObjects = [];

      if (existingIncomeList != null) {
        existingIncomeObjects =
            existingIncomeList
                .map((e) => Income.fromJSON(json.decode(e)))
                .toList();
      }

      //removing the selected id income
      existingIncomeObjects.removeWhere((incom) => incom.id == id);

      //convrt to json again
      List<String> updatedIncomeList =
          existingIncomeObjects.map((e) => json.encode(e.toJSON())).toList();

      //save in shared Preferences
      await prefs.setStringList(_incomeKey, updatedIncomeList);

      //display success message
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Income Deleted Successfully!"),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (error) {
      print(error);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Income Deleting Failed!"),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }
}
