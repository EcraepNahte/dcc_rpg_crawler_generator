import 'dart:convert';

import 'package:dcc_rpg_crawler_generator/model/crawler.dart';
import 'package:dcc_rpg_crawler_generator/viewmodel/filter_data.dart';
import 'package:dcc_rpg_crawler_generator/widgets/filter_drawer.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class RandomCrawlerPage extends StatefulWidget {
  const RandomCrawlerPage({super.key});

  @override
  State<StatefulWidget> createState() => RandomCrawlerPageState();
}

class RandomCrawlerPageState extends State<RandomCrawlerPage> {
  Crawler? _crawler;
  var formatter = NumberFormat.decimalPattern(
    'en_US',
  ); // TODO: get user region eventually

  @override
  void initState() {
    super.initState();
    _generateRandomCrawler(null);
  }

  void _generateRandomCrawler(FilterData? data) async {
    http.Response response = await http.get(
      Uri.parse(
        'https://randomuser.me/api/${data != null ? data.queryParams() : ''}',
      ),
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

  void _showFilterDrawer() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => const FilterDrawer(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.blueGrey,
        foregroundColor: Colors.yellow,
        onPressed: _showFilterDrawer,
        label: const Text("Filters"),
        icon: const Icon(Icons.filter_list),
      ),
      body: Consumer<FilterData>(
        builder: (context, data, child) {
          return Container(
            alignment: Alignment.center,
            color: Colors.black,
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Random Crawler Generator',
                  style: Theme.of(
                    context,
                  ).textTheme.headlineLarge!.copyWith(color: Colors.amber),
                ),
                if (_crawler != null)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.network(
                        _crawler!.imageUrl,
                        webHtmlElementStrategy: WebHtmlElementStrategy.prefer,
                        height: 200,
                        width: 200,
                        fit: BoxFit.fill,
                      ),
                      Text(
                        _crawler!.crawlerName,
                        style: Theme.of(context).textTheme.headlineLarge!
                            .copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.yellow,
                            ),
                      ),
                      Text(
                        '#${formatter.format(_crawler!.crawlerNumber)}',
                        style: Theme.of(
                          context,
                        ).textTheme.headlineSmall!.copyWith(color: Colors.red),
                      ),
                      Text(
                        '${_crawler!.firstName} ${_crawler!.lastName} | ${_crawler!.age} ${_crawler!.isMale ? 'M' : 'F'}',
                        style: Theme.of(
                          context,
                        ).textTheme.bodyLarge!.copyWith(color: Colors.grey),
                      ),
                      Text(
                        '${_crawler!.state}, ${_crawler!.country}',
                        style: Theme.of(
                          context,
                        ).textTheme.bodyMedium!.copyWith(color: Colors.grey),
                      ),
                    ],
                  ),
                SizedBox(height: 20),
                TextButton.icon(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all<Color>(Colors.red),
                    foregroundColor: WidgetStateProperty.all<Color>(
                      Colors.white,
                    ),
                    textStyle: WidgetStateProperty.all<TextStyle>(
                      Theme.of(context).textTheme.labelLarge!,
                    ),
                  ),
                  icon: Icon(Icons.refresh),
                  label: Text('New Crawler'),
                  onPressed: () => _generateRandomCrawler(data),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
