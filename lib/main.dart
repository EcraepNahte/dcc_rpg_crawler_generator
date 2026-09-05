import 'package:dcc_rpg_crawler_generator/view/random_crawler_page.dart';
import 'package:dcc_rpg_crawler_generator/viewmodel/filter_data.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(create: (_) => FilterData(), child: MainApp()));
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
