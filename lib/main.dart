
import 'package:flutter/material.dart';
import 'package:widgets_example/layout/layout.dart';
import 'package:widgets_example/utils/theme.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.data,
      themeMode: ThemeMode.light,
      home: const MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return const Layout();
  }
/*
  _usersScreen() => const UsersScreen();

  Widget _prepareLoginScreen() {
    return BlocProvider(
      create: (BuildContext context) {
        return LoginBloc();
      },
      child: const LoginScreen(),
    );
  }*/
}
