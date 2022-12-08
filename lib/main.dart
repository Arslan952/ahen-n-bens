import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hensbuns/splashscreen.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme:const AppBarTheme(
          color: Colors.white,
          elevation: 0,

        ),
        primarySwatch: Colors.amber,
      ),
      home: const SplashScreen(),
    );
  }
}
