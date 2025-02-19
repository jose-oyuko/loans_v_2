import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'pages.dart';
import 'dashboard.dart';
import 'register.dart';
import 'customers_details.dart';

Future<void> main() async {
  await dotenv.load(fileName: '.env');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.green),
      home: const RootPage(),
    );
  }
}

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  final GlobalKey<NavigatorState> _contentNavigatorKey =
      GlobalKey<NavigatorState>();
  int _selectedIndex = 0;

  final List<String> buttonNames = [
    'Dash Board',
    'Register Customer',
    'Customer Details',
    'Messages',
    'Mpesa',
    'Debts Due Today',
    'Debts Over Dues',
    'Active Debts',
    'Past Transactions'
  ];

  void _onButtonTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _contentNavigatorKey.currentState?.popUntil((route) => route.isFirst);
    });
  }

  // Function to get the corresponding page widget based on selected index
  Widget _getPageContent(int index) {
    switch (index) {
      case 0:
        return const Dashboard();
      case 1:
        return const Register();
      case 2:
        return CustomersTable;
      default:
        return Center(
            child: Text('Page $index',
                style: const TextStyle(fontSize: 24))); // Default page
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("New Loans App"),
        ),
        body: Row(
          children: [
            Container(
              color: Colors.blue[50],
              width: 200,
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Menu',
                    style: TextStyle(fontSize: 18),
                  ),
                  const Divider(),
                  ...List.generate(buttonNames.length, (index) {
                    return Column(children: [
                      ElevatedButton(
                          onPressed: () => _onButtonTapped(index),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: _selectedIndex == index
                                  ? Colors.blue
                                  : Colors.grey),
                          child: Text(buttonNames[index])),
                      const SizedBox(
                        height: 15,
                      ),
                    ]);
                  }),
                ],
              ),
            ),
            const VerticalDivider(
              thickness: 1,
              width: 1,
            ),
            Expanded(
              child: Navigator(
                key: _contentNavigatorKey,
                onGenerateRoute: (RouteSettings settings) {
                  return MaterialPageRoute(
                    builder: (_) => _getPageContent(_selectedIndex),
                  );
                },
              ),
            ),
          ],
        ));
  }
}
