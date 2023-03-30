import 'package:flutter/material.dart';

import 'di/dependency_injection.dart';
import 'ui/page/venues_page.dart';

void main() {
  setUpDependencies();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Venues per location',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const VenuesPage(),
    );
  }
}
