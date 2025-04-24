import 'package:expenz/models/income_model.dart';
import 'package:flutter/material.dart';

extension CategoryColor on IncomeCategory {
  Color get clr {
    return switch (this) {
      IncomeCategory.freelance => const Color(0xFFE57373),
      IncomeCategory.passive => const Color(0xFF81C784),
      IncomeCategory.sales => const Color(0xFF64B5F6),
      IncomeCategory.salary => const Color(0xFFFFD54F),
    };
  }
}

extension CategoryImage on IncomeCategory {
  String get image {
    return switch (this) {
      IncomeCategory.freelance => "assets/images/freelance.png",
      IncomeCategory.passive => "assets/images/car.png",
      IncomeCategory.salary => "assets/images/health.png",
      IncomeCategory.sales => "assets/images/salary.png",
    };
  }
}
