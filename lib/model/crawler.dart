import 'dart:math';

import 'package:dcc_rpg_crawler_generator/model/stat_block.dart';
import 'package:dcc_rpg_crawler_generator/services/crawler_identification_service.dart';

class Crawler {
  final String firstName;
  final String lastName;
  final bool isMale;
  final String crawlerName;
  final int crawlerNumber;
  final String imageUrl;
  final int age;
  final String city;
  final String state;
  final String country;
  int level;
  final StatBlock statBlock;
  final int maxHpBars = 10;
  String crawlerRace = 'Human';
  String crawlerClass = '';

  int get strMod => _getMod(statBlock.strength);
  int get intMod => _getMod(statBlock.intelligence);
  int get conMod => _getMod(statBlock.constitution);
  int get dexMod => _getMod(statBlock.dexterity);
  int get chaMod => _getMod(statBlock.charisma);

  int get maxMana => statBlock.intelligence;
  int get baseEvade => 10 + dexMod;
  int get baseSurprise => 10 + intMod;

  int currentHpBars = 0;
  int currentMana = 0;

  Crawler({
    required this.crawlerName,
    required this.crawlerNumber,
    required this.firstName,
    required this.lastName,
    required this.isMale,
    required this.imageUrl,
    required this.age,
    required this.city,
    required this.state,
    required this.country,
    required this.statBlock,
    this.level = 1,
    int? floor,
  }) {
    _initStats(floor);
  }

  void _initStats(int? floor) {
    if (floor != null) {
      if (floor == 1) {
        level = Random().nextInt(5) + 1;
      } else if (floor == 2) {
        level = Random().nextInt(5) + 6;
      } else {
        final int levelMin = (floor - 2) * 10 - 5;
        final int levelMax = (floor - 2) * 10 + 10;

        level = Random().nextInt(levelMax - levelMin) + levelMin;
      }
    }

    for (int i = 0; i < level * 3; i++) {
      _updateRandomStat();
    }

    if (floor != null ? floor >= 3 : false) {
      crawlerClass = CrawlerIdentificationService.generateRandomClass();
      crawlerRace = CrawlerIdentificationService.generateRandomRace();
    }

    currentHpBars = maxHpBars;
    currentMana = maxMana;
  }

  void _updateRandomStat() {
    final int rand = Random().nextInt(5);

    switch (rand) {
      case 0:
        statBlock.strength++;
      case 1:
        statBlock.intelligence++;
      case 2:
        statBlock.constitution++;
      case 3:
        statBlock.dexterity++;
      case 4:
        statBlock.charisma++;
    }
  }

  int _getMod(int stat) {
    if (stat < 1) {
      return 0;
    } else if (stat < 3) {
      return 1;
    } else if (stat < 6) {
      return 2;
    } else if (stat < 10) {
      return 3;
    } else if (stat < 20) {
      return 4;
    } else if (stat < 50) {
      return 5;
    } else if (stat < 100) {
      return 6;
    } else if (stat < 150) {
      return 7;
    } else if (stat < 200) {
      return 8;
    } else if (stat < 250) {
      return 9;
    } else {
      return 10;
    }
  }

  static Crawler? fromJson(Map<String, dynamic> json, int? floor) {
    try {
      String crawlerFirstName = json['name']['first'] ?? '';
      String crawlerLastName = json['name']['last'] ?? '';

      int randomNumber = CrawlerIdentificationService.generateCrawlerNumber();
      String generatedName = CrawlerIdentificationService.generateCrawlerName(
        crawlerFirstName,
        crawlerLastName,
        randomNumber,
      );

      return Crawler(
        crawlerName: generatedName,
        crawlerNumber: randomNumber,
        firstName: crawlerFirstName,
        lastName: crawlerLastName,
        isMale: json['gender'] == 'male',
        imageUrl: json['picture']['large'] ?? '',
        age: json['dob']['age'] ?? 25,
        city: json['location']['city'] ?? '',
        state: json['location']['state'] ?? '',
        country: json['location']['country'] ?? '',
        statBlock: CrawlerIdentificationService.generateCrawlerStats(),
        floor: floor,
      );
    } catch (e) {
      return null;
    }
  }
}
