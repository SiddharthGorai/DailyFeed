import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:news/pages/home.dart';
import 'package:news/pages/sign_in.dart';
import 'package:news/pages/sign_up.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

  runApp(MyApp(sharedPreferences: sharedPreferences));


  // runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required SharedPreferences sharedPreferences});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    bool loggedIn = FirebaseAuth.instance.currentUser!=null;
    return MaterialApp(

     initialRoute: loggedIn ? '/home' : '/sign_in',
      // initialRoute: '/home',

      routes: {
        '/home' : (context) => Home(),
        '/sign_in' : (context) => SignIn(),
        '/sign_up' : (context) => SignUp(),

      },
      debugShowCheckedModeBanner: false,
    );
  }
}

