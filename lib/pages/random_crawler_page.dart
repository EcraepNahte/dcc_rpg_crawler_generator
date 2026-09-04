import 'dart:convert';

import 'package:dcc_rpg_crawler_generator/model/crawler.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RandomCrawlerPage extends StatefulWidget {
  const RandomCrawlerPage({super.key});

  @override
  State<StatefulWidget> createState() => RandomCrawlerPageState();
}

class RandomCrawlerPageState extends State<RandomCrawlerPage> {
  Crawler? _crawler;
  void _generateRandomCrawler() async {
    http.Response response = await http.get(
      Uri.parse('https://randomuser.me/api/'),
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      if (jsonResponse['results'] != null &&
          jsonResponse['results'].isNotEmpty) {
        Map<String, dynamic> userJson = jsonResponse['results'][0];
        setState(() {
          _crawler = Crawler.fromJson(userJson);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Random Crawler Page'),
            if (_crawler != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(_crawler!.crawlerName),
                  Text('#${_crawler!.crawlerNumber}'),
                  Text('${_crawler!.firstName} ${_crawler!.lastName}'),
                ],
              ),
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: _generateRandomCrawler,
            ),
          ],
        ),
      ),
    );
  }
}
