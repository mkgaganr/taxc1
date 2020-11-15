import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taxc/models/user.dart';
import 'package:taxc/screens/wrapper.dart';
import 'package:taxc/services/auth.dart';
import 'package:taxc/screens/home/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}