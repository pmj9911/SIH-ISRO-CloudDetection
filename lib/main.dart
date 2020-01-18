import 'cloud_prediction_screen.dart';
import 'package:flutter/material.dart';
import 'cloud_details_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'ISRO Cloud Detector'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Map<String, Object>> _pages;
  bool refreshed = false;
  @override
  void initState() {
    _pages = [
      {
        'page': CloudPredictionScreen(),
        'title': 'Cloud Prediction',
      },
      {
        'page': CloudDetails(),
        'title': 'Cloud Details',
      },
    ];
    super.initState();
  }

  int _selectedPageIndex = 0;
  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(_pages[_selectedPageIndex]['title']),
        ),
      ),
      body: _pages[_selectedPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.yellow,
        currentIndex: _selectedPageIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            title: Text("Prediction"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.details),
            title: Text("Details"),
          ),
        ],
      ),
    );
  }
}
