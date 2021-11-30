import 'package:flutter/material.dart';
import 'package:myanma_number/myanma_num_helper.dart';

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
  String myanmarNumber = 'Myanmar Number Will Show Here';

  void _changeNumber() {
    setState(() {
      myanmarNumber = MyanmarNumHelper.getSimpleNumInMM(
        number: "92991.00533",
        isCommaSeparated: true,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(myanmarNumber),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _changeNumber(),
        tooltip: 'Increment',
        child: const Icon(Icons.compare_arrows_rounded),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
