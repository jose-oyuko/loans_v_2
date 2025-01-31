import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final List<String> cardNames = [
    'Unpaid Loans',
    'Loans Given Today',
    'Loans Paid Today',
    'Loans Due Today',
    'Interest Given Today',
  ];

  @override
  Widget build(BuildContext context) {
    // Fixed card dimensions
    const double cardWidth = 350;
    const double cardHeight = 250;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: cardWidth, // Max card width
            mainAxisSpacing: 8.0,
            crossAxisSpacing: 8.0,
            childAspectRatio: cardWidth / cardHeight, // Width/height ratio
          ),
          itemCount: cardNames.length,
          itemBuilder: (context, index) {
            return SizedBox(
              width: cardWidth,
              height: cardHeight,
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        cardNames[index],
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 18),
                      ),
                      const Expanded(
                        child: Center(
                          child: Text(
                            '1500',
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text('Show'),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
