import 'package:dcc_rpg_crawler_generator/pages/random_crawler_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: RandomCrawlerPage());
  }
}
