import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:regexp/src/blocs/blocs.dart';
import 'package:regexp/src/repository/impl/db/local_db.dart';
import 'package:regexp/src/views/home/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalDb.instance.initDb();
  runApp(const MyApp());
  DesktopWindow.setWindowSize(const Size(900, 600));

}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RecordBloc>(
      create: (_) => RecordBloc(),
      child: BlocProvider<MatchBloc>(
        create: (_) => MatchBloc(),
        child:  BlocProvider<LinkRegexBloc>(
          create: (_) => LinkRegexBloc(),
          child: MaterialApp(
            title: 'regexpo',
            debugShowCheckedModeBanner: false,
            // themeMode: ThemeMode.light,
            themeMode: ThemeMode.dark,
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            darkTheme: ThemeData(
                brightness: Brightness.dark,
                primaryColor: const Color(0xff4699FB),
                appBarTheme: const AppBarTheme(backgroundColor: Color(0xff222222)),
                floatingActionButtonTheme: const FloatingActionButtonThemeData(
                    foregroundColor: Colors.white,
                    backgroundColor: Color(0xff4699FB)
                ),
                dividerColor: Colors.white,
                // switchTheme: SwitchThemeData(
                //     // trackColor: '',
                //     ),
                bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                    backgroundColor: Color(0xff181818),
                    selectedItemColor: Color(0xff4699FB)),
                scaffoldBackgroundColor: const Color(0xff010201)),
            home: const HomePage(),
          ),
        ),
      ),
    );
  }
}
