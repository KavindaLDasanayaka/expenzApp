import 'package:expenz/constants/colors.dart';
import 'package:expenz/constants/constants.dart';
import 'package:expenz/services/user_service.dart';
import 'package:expenz/widgets/income_expence_card.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //for store the username
  String userName = "";

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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ignore: deprecated_member_use
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
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
                            amount: 1200,
                            imageUrl: "assets/images/income.png",
                            bgColor: kGreen,
                          ),
                          IncomeExpenceCard(
                            title: "Expense",
                            amount: 2300,
                            imageUrl: "assets/images/expense.png",
                            bgColor: kRed,
                          ),
                        ],
                      ),
                    ],
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
