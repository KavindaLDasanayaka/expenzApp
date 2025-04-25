import 'package:expenz/constants/colors.dart';
import 'package:expenz/constants/constants.dart';
import 'package:expenz/models/income_model.dart';
import 'package:expenz/screens/onboarding_screen.dart';
import 'package:expenz/services/expense_service.dart';
import 'package:expenz/services/income_service.dart';
import 'package:expenz/services/user_service.dart';
import 'package:expenz/widgets/profile_card.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String userName = "";
  String email = "";

  @override
  void initState() {
    // TODO: implement initState
    UserServices.getUserData().then((value) {
      if (value['username'] != null && value['email'] != null) {
        setState(() {
          userName = value['username']!;
          email = value["email"]!;
        });
      }
    });
    super.initState();
  }

  //open scaffold messenger for logout
  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      // ignore: deprecated_member_use
      backgroundColor: kWhite,
      context: context,
      builder: (context) {
        return Container(
          height: 200,
          padding: const EdgeInsets.all(kDefaultPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Logout?",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: kBlack,
                ),
              ),
              SizedBox(height: 10),
              const Text(
                "Are you sure you want to log out?",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: kGrey,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      //clear the user data
                      await UserServices.clearUserData();

                      //clear the expenses
                      if (context.mounted) {
                        await ExpenseService().deleteAllExpenses(context);
                      }
                      //clear the Incomes
                      if (context.mounted) {
                        await IncomeService().deleteAllIncomes(context);
                        //navigate to the onboarding screen
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const OnboardingScreen(),
                          ),
                          (route) => false,
                        );
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                        // ignore: deprecated_member_use
                        kMainColor,
                      ),
                    ),
                    child: Text(
                      "Yes",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: kWhite,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    }, //
                    //
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                        // ignore: deprecated_member_use
                        kRed,
                      ),
                    ),
                    child: Text(
                      "No",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: kWhite,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
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

                    //const SizedBox(width: 5),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Welcome, $userName",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          email,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: kGrey,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 20),
                    IconButton(
                      onPressed: () {},
                      icon: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          // ignore: deprecated_member_use
                          color: kMainColor.withOpacity(0.2),
                        ),

                        child: Icon(Icons.edit, color: kMainColor, size: 30),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                const ProfileCard(
                  icon: Icons.wallet,
                  title: "Mywallet",
                  color: kMainColor,
                ),
                const ProfileCard(
                  icon: Icons.settings,
                  title: "Settings",
                  color: kYellow,
                ),
                const ProfileCard(
                  icon: Icons.download,
                  title: "Donwload",
                  color: kGreen,
                ),
                GestureDetector(
                  onTap: () {
                    _showBottomSheet(context);
                  },
                  child: const ProfileCard(
                    icon: Icons.logout,
                    title: "Logout",
                    color: kRed,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
