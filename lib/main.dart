import 'package:dcc_rpg_crawler_generator/pages/random_crawler_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(textTheme: GoogleFonts.josefinSansTextTheme()),
      home: const RandomCrawlerPage(),
    );
  }
}
