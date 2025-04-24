import 'package:expenz/constants/constants.dart';
import 'package:expenz/services/user_service.dart';
import 'package:expenz/widgets/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferences.getInstance();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: UserServices.checkUsername(),
      builder: (context, snapshot) {
        //if the snapshot is still waiting
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else {
          //here the has username will  be set to true if the is there in the snap shot and otherwise false
          bool hasUserName =
              snapshot.data ??
              false; // meken wenne ?? naththm falase eka daganna eka.
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(fontFamily: "Inter"),
            scaffoldMessengerKey: rootScaffoldMessengerKey,
            home: Wrapper(showMainScreen: hasUserName),
          );
        }
      },
    );
  }
}
