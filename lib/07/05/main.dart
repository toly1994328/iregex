import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/material.dart';

import 'repository/impl/db/local_db.dart';
import 'views/home_page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await LocalDb.instance.initDb();
  runApp(const MyApp());
  DesktopWindow.setWindowSize(const Size(720,480));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'regexpo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

