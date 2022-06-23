import 'dart:math';

import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit_sample/api/user_api.dart';
import 'package:retrofit_sample/di/injection.dart';
import 'package:retrofit_sample/model/user.dart';

void main() {
  configureInjection(Environment.dev);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  User? user;
  String? error;
  void getUserData() async {
    try {
      final userId = Random().nextInt(100).toString();
      final response = await getIt<UserApi>().getUser(userId);
      setState(() {
        user = response;
      });
    } catch (e) {
      setState(() {
        error = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: user != null
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    foregroundImage: NetworkImage(user!.profilePhoto!),
                  ),
                  Text(user!.name!),
                  Text('registered at ${user!.createdAt!.toString()}')
                ],
              ),
            )
          : Center(
              child: Text(error ?? ''),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => getUserData(),
        tooltip: 'Get user data',
        child: const Icon(Icons.refresh_outlined),
      ),
    );
  }
}
