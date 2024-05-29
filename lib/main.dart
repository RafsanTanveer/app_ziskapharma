import 'package:flutter/material.dart';
import './screens/loginScreen.dart';
import './screens/areaSetting.dart';
import './screens/mainMgtScreen.dart';
import './screens/salesMgtScreen.dart';
import './screens/userInfoScreen.dart';
import './screens/customerSettingScreen.dart';
import './screens/areaSetting.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 5, 112, 9)),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        "/loging": (context) => Loginscreen(),
        "/areasetting": (context) => Areasetting(),
        "/mainmgt": (context) => Mainmgtscreen(),
        "/salesmgt": (context) => Salesmgtscreen(),
        "/userinfo": (context) => Userinfoscreen(),
        "/cstrstts": (context) => CustomerSettingScreen(),

      },
      home: Loginscreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
          elevation: 1.5,
          child: Column(children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(),
              child: Text('Drawer Header'),
            ),
            Expanded(
                child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                ListTile(
                  title: Text('Name'),
                  leading: Icon(Icons.person),
                  onTap: () {},
                ),
                ListTile(
                  title: Text('My Orders'),
                  leading: Icon(Icons.add_shopping_cart),
                  onTap: () {},
                ),
              ],
            )),
            Container(
              color: Colors.black,
              width: double.infinity,
              height: 0.1,
            ),
            Container(
                padding: EdgeInsets.all(10),
                height: 100,
                child: Text(
                  "V1.0.0",
                  style: TextStyle(fontWeight: FontWeight.bold),
                )),
          ])),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Container(
              padding: EdgeInsets.all(3),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text('this is first clild'),
                  Text('this is second clild'),
                  Text('this is first clild'),
                  Text('this is second clild'),
                  Text('this is first clild'),
                  Text('this is second clild'),
                  Text('this is first clild'),
                  Text('this is second clild'),
                  Text('this is first clild'),
                  Text('this is second clild'),
                  Text('this is first clild'),
                  Text('this is second clild'),
                  Text('this is first clild'),
                  Text('this is second clild'),
                  Text('this is first clild'),
                  Text('this is second clild'),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
