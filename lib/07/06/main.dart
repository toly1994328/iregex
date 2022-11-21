import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'repository/impl/db/local_db.dart';
import 'views/home_page.dart';
import 'views/record/bloc/record_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalDb.instance.initDb();
  runApp(const MyApp());
  DesktopWindow.setWindowSize(const Size(720, 480));
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
      home: BlocProvider<RecordBloc>(
        create: (_) => RecordBloc(),
        child: const HomePage(),
      ),
    );
  }
}
