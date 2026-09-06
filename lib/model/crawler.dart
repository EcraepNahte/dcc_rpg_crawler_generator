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
  final StatBlock statBlock;

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
  });

  static Crawler? fromJson(Map<String, dynamic> json) {
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
      );
    } catch (e) {
      return null;
    }
  }
}
