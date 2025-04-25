import 'package:expenz/constants/colors.dart';
import 'package:expenz/constants/constants.dart';
import 'package:expenz/models/expense_model.dart';
import 'package:expenz/models/income_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class Chart extends StatefulWidget {
  //map ekak widyata define karagannawa total eka hoyaganna
  final Map<ExpenseCategory, double> expenseCategoryTotal;
  final Map<IncomeCategory, double> incomeCategoryTotal;

  //page dekema pie charts thiyena hinda income ekakda expense ekakda kyla balnana me widyat varible ekak define karagnnawa.
  final bool isExpense;

  const Chart({
    super.key,
    required this.expenseCategoryTotal,
    required this.incomeCategoryTotal,
    required this.isExpense,
  });

  @override
  State<Chart> createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  //sections data
  List<PieChartSectionData> getSectins() {
    if (widget.isExpense) {
      return [
        PieChartSectionData(
          color: expenseCategoryColors[ExpenseCategory.food],
          value: widget.expenseCategoryTotal[ExpenseCategory.food] ?? 0,
          showTitle: false,
          radius: 60,
        ),
        PieChartSectionData(
          color: expenseCategoryColors[ExpenseCategory.health],
          value: widget.expenseCategoryTotal[ExpenseCategory.health] ?? 0,
          showTitle: false,
          radius: 60,
        ),
        PieChartSectionData(
          color: expenseCategoryColors[ExpenseCategory.shopping],
          value: widget.expenseCategoryTotal[ExpenseCategory.shopping] ?? 0,
          showTitle: false,
          radius: 60,
        ),
        PieChartSectionData(
          color: expenseCategoryColors[ExpenseCategory.subscriptions],
          value:
              widget.expenseCategoryTotal[ExpenseCategory.subscriptions] ?? 0,
          showTitle: false,
          radius: 60,
        ),
        PieChartSectionData(
          color: expenseCategoryColors[ExpenseCategory.transport],
          value: widget.expenseCategoryTotal[ExpenseCategory.transport] ?? 0,
          showTitle: false,
          radius: 60,
        ),
      ];
    } else {
      return [
        PieChartSectionData(
          color: incomeCategoryColors[IncomeCategory.freelance],
          value: widget.incomeCategoryTotal[IncomeCategory.freelance] ?? 0,
          showTitle: false,
          radius: 60,
        ),
        PieChartSectionData(
          color: incomeCategoryColors[IncomeCategory.passive],
          value: widget.incomeCategoryTotal[IncomeCategory.passive] ?? 0,
          showTitle: false,
          radius: 60,
        ),
        PieChartSectionData(
          color: incomeCategoryColors[IncomeCategory.salary],
          value: widget.incomeCategoryTotal[IncomeCategory.salary] ?? 0,
          showTitle: false,
          radius: 60,
        ),
        PieChartSectionData(
          color: incomeCategoryColors[IncomeCategory.sales],
          value: widget.incomeCategoryTotal[IncomeCategory.sales] ?? 0,
          showTitle: false,
          radius: 60,
        ),
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    final PieChartData pieChartData = PieChartData(
      sectionsSpace: 0,
      centerSpaceRadius: 70,
      startDegreeOffset: -90,
      sections: getSectins(),
      borderData: FlBorderData(show: false),
    );
    return Container(
      height: 250,
      padding: EdgeInsets.all(kDefaultPadding),
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          PieChart(pieChartData),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "70%",
                style: TextStyle(color: kBlack, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text("of 100%", style: TextStyle(color: kGrey)),
            ],
          ),
        ],
      ),
    );
  }
}
