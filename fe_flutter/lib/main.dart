import 'package:fe_flutter/view/add.dart';
import 'package:fe_flutter/view/auth/login.dart';
import 'package:fe_flutter/view/edit.dart';
import 'package:fe_flutter/view/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      routes: {
        '/': (context) => const Login(),
        '/home': (context) => const MyHomePage(),
        '/tambah-data': (context) => const AddBook(),
        '/edit-data': (context) => const EditBook()
      },
    );
  }
}
