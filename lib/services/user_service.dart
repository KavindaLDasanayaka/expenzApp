import 'package:expenz/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserServices {
  static Future<void> storeUserDetails({
    required String userName,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    //if the password and confirm password matched then store the data.
    try {
      //check weather the password and confirm password are matching?

      if (password != confirmPassword) {
        rootScaffoldMessengerKey.currentState!.showSnackBar(
          SnackBar(
            content: Text("Password and Confirm Password do not match."),
          ),
        );
        return;
      }
      SharedPreferences prefs = await SharedPreferences.getInstance();

      await prefs.setString("username", userName);
      await prefs.setString("email", email);

      rootScaffoldMessengerKey.currentState!.showSnackBar(
        SnackBar(content: Text("User Details are stored successfully")),
      );
    } on Exception catch (e) {
      e.toString();
    }
  }

  //method to check whathter the user name is saved in the shared preferences
  static Future<bool> checkUsername() async {
    //create an instance for shared preferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userName = prefs.getString("username");
    //user name eka thiyenwanm username eka return karanwa naththm null eka return karnawa. false eka
    return userName != null;
  }

  //get the user name and the email
  static Future<Map<String, String>> getUserData() async {
    //create an instance fpr shared preferences
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? userName = pref.getString("username");
    String? email = pref.getString("email");

    return {"username": userName!, "email": email!};
  }
}
