import 'package:expenz/constants/colors.dart';
import 'package:expenz/constants/constants.dart';
import 'package:expenz/screens/main_screen.dart';
import 'package:expenz/services/user_service.dart';
import 'package:expenz/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class UserDataScreen extends StatefulWidget {
  const UserDataScreen({super.key});

  @override
  State<UserDataScreen> createState() => _UserDataScreenState();
}

class _UserDataScreenState extends State<UserDataScreen> {
  //for the check box
  bool _rememberMe = false;

  //form key for the form validations
  final _formKey = GlobalKey<FormState>();

  //controller for the text form fields
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  //remove textcontroller data when goes to other page.
  @override
  void dispose() {
    // TODO: implement dispose
    _userNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Enter your \nPersonal Details",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 30),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //form field for user name
                      TextFormField(
                        controller: _userNameController,
                        validator: (value) {
                          //check weather the user  entered a valid user name
                          if (value!.isEmpty) {
                            return "Please Enter Your Name.";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: "Name",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 15,
                            horizontal: 20,
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      //form field for email
                      TextFormField(
                        controller: _emailController,
                        validator: (value) {
                          //check weather the user  entered a valid user name
                          if (value!.isEmpty) {
                            return "Please Enter Your Email.";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: "Email",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 15,
                            horizontal: 20,
                          ),
                        ),
                      ),
                      SizedBox(height: 15),

                      //user password
                      TextFormField(
                        controller: _passwordController,
                        validator: (value) {
                          //check weather the user  entered a valid user name
                          if (value!.isEmpty) {
                            return "Please Enter Your Password.";
                          }
                          return null;
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: "Password",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 15,
                            horizontal: 20,
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      //user confirmed password
                      TextFormField(
                        controller: _confirmPasswordController,
                        validator: (value) {
                          //check weather the user  entered a valid user name
                          if (value!.isEmpty) {
                            return "Please Enter the same Password.";
                          }
                          return null;
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: "Confirm Password",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 15,
                            horizontal: 20,
                          ),
                        ),
                      ),
                      SizedBox(height: 30),

                      //remember me for the next time
                      Row(
                        children: [
                          Text(
                            "Remember Me for the next time",
                            style: TextStyle(
                              color: kGrey,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Expanded(
                            child: CheckboxListTile(
                              activeColor: kMainColor,
                              value: _rememberMe,
                              onChanged: (value) {
                                setState(() {
                                  _rememberMe =
                                      value!; //value eke opposite eka add wenawa
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 30),
                      //submit button
                      GestureDetector(
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            //form is valid process data.
                            String userName = _userNameController.text;
                            String email = _emailController.text;
                            String password = _passwordController.text;
                            String confirmPassword =
                                _confirmPasswordController.text;

                            //save the user name and email in device storage.
                            await UserServices.storeUserDetails(
                              userName: userName,
                              email: email,
                              password: password,
                              confirmPassword: confirmPassword,
                              context: context,
                            );

                            //navigate to the main screen.
                            if (context.mounted) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MainScreen(),
                                ),
                              );
                            }
                          }
                        },
                        child: CustomButton(
                          buttonName: "Next",
                          buttonColor: kMainColor,
                        ),
                      ),
                    ],
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
