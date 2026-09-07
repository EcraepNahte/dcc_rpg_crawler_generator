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

  Widget _createHealthBarSlot(int slot, Crawler crawler) {
    Color color = Colors.green;
    double hpFraction = crawler.currentHpBars / crawler.maxHpBars;
    if (hpFraction <= 1 / 3) {
      color = Colors.red;
    } else if (hpFraction <= 2 / 3) {
      color = Colors.yellow;
    }

    if (slot >= crawler.currentHpBars) {
      color = Colors.grey;
    }

    return GestureDetector(
      onTap: () {
        setState(() => crawler.currentHpBars = slot + 1);
      },
      child: Container(
        width: 40,
        height: 30,
        decoration: BoxDecoration(
          color: color,
          border: Border.all(
            color: const Color.fromARGB(255, 39, 38, 38),
            width: 2,
          ),
        ),
        child: Center(child: Text('${crawler.statBlock.constitution}')),
      ),
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
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    for (int i = 0; i < _crawler!.maxHpBars; i++)
                      _createHealthBarSlot(i, _crawler!),
                  ],
                ),
                SizedBox(height: 10),
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
                        'Crawler ${_crawler!.crawlerName}',
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
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        spacing: 12.0,
                        children: [
                          Text(
                            'Level: ${_crawler!.level}',
                            style: TextStyle(color: Colors.yellow),
                          ),
                          Text('|', style: TextStyle(color: Colors.red)),
                          Text(
                            'Mana: ${_crawler!.maxMana}',
                            style: TextStyle(color: Colors.yellow),
                          ),
                          Text('|', style: TextStyle(color: Colors.red)),
                          Text(
                            'Surprise: ${_crawler!.baseSurprise} + F',
                            style: TextStyle(color: Colors.yellow),
                          ),
                          Text('|', style: TextStyle(color: Colors.red)),
                          Text(
                            'Evade: ${_crawler!.baseEvade} + F',
                            style: TextStyle(color: Colors.yellow),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        spacing: 16.0,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'STR',
                                style: TextStyle(color: Colors.red),
                              ),
                              Text(
                                '${_crawler!.statBlock.strength} (+${_crawler!.strMod})',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall!
                                    .copyWith(color: Colors.yellow),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'INT',
                                style: TextStyle(color: Colors.red),
                              ),
                              Text(
                                '${_crawler!.statBlock.intelligence} (+${_crawler!.intMod})',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall!
                                    .copyWith(color: Colors.yellow),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'CON',
                                style: TextStyle(color: Colors.red),
                              ),
                              Text(
                                '${_crawler!.statBlock.constitution} (+${_crawler!.conMod})',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall!
                                    .copyWith(color: Colors.yellow),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'DEX',
                                style: TextStyle(color: Colors.red),
                              ),
                              Text(
                                '${_crawler!.statBlock.dexterity} (+${_crawler!.dexMod})',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall!
                                    .copyWith(color: Colors.yellow),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'CHA',
                                style: TextStyle(color: Colors.red),
                              ),
                              Text(
                                '${_crawler!.statBlock.charisma} (+${_crawler!.chaMod})',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall!
                                    .copyWith(color: Colors.yellow),
                              ),
                            ],
                          ),
                        ],
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
