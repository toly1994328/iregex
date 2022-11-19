import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  bool _activeSwitch = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('HomePage'),),
      body: Center(
        child: Wrap(
          spacing: 20,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            ElevatedButton(onPressed: toggle, child: Text("toggle me")),
            Switch(value: _activeSwitch,
              onChanged: onChange,
            )
          ],
        ),
      ),
    );
  }

  void toggle(){
    setState(() {
      _activeSwitch=!_activeSwitch;
    });
  }

  void onChange(bool value){
    setState(() {
      _activeSwitch=value;
    });
  }
}