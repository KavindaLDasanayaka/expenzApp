import 'dart:convert';

import 'package:expenz/models/income_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IncomeService {
  //income list
  List<Income> existingIncome = [];

  //Define the key for storing expenses in shared preferences
  static const String _incomeKey = "income";

  //save the expense to shared preferences
  Future<void> saveIncome(Income income, BuildContext context) async {
    try {
      //shared preferences walain instance ekak hadagannawa
      SharedPreferences prefs = await SharedPreferences.getInstance();

      //shared pereferences wala thiyena tika string list ekakata dagannawa meka nullable wenanath puluwan.
      List<String>? existingIncomes = prefs.getStringList(_incomeKey);

      //itapasse list ekak widiyata ena strings tika convert karagena daganna ona income objects list ekakata . ekata me widyata aluth list ekak define karagnnawa.
      List<Income> existingIncomeObjects = [];

      //dan ara exsting income list eka emptyada check karagnnawa empty naththam eke ewa obejcts walata convert karagnnawa kalin define karapu fromJson method eka use karala.

      if (existingIncomes != null) {
        existingIncomeObjects =
            existingIncomes
                .map((e) => Income.fromJSON(json.decode(e)))
                .toList();
      }

      // dan e convert karagan hadagathtu existing income object list ekata me method ekata pass karana income object eka add karagnnawa.
      existingIncomeObjects.add(income);

      //dan aye shared preferences wala store karaganna ona hinda aye encode karanna ona list of strings widyata.

      List<String> updatedIncome =
          existingIncomeObjects.map((e) => json.encode(e.toJSON())).toList();

      //dan save karanwa shared preferences wala
      await prefs.setStringList(_incomeKey, updatedIncome);

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Income added successfully!"),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Income added Failed!"),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  //load the incomes from shared pereferences
  Future<List<Income>> loadIncome() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? existingIncome = prefs.getStringList(_incomeKey);

    List<Income> loadedIncome = [];

    if (existingIncome != null) {
      loadedIncome =
          existingIncome.map((e) => Income.fromJSON(json.decode(e))).toList();
    }
    return loadedIncome;
  }
}
