
import 'package:flutter/material.dart';
import 'package:flutter_application_3/ui/user/list.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: UserList()
    );
  }
}