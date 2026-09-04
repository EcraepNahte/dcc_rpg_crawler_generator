import 'dart:math';

class CrawlerIdentificationService {
  static int crawlersInDungeon =
      12935453; // This is the number of crawlers that entered the dungeon in Dungeon Crawler Carl

  static int generateCrawlerNumber() {
    return Random().nextInt(crawlersInDungeon);
    // TODO: make a loop and blacklist known crawler numbers from the books.
  }

  static String generateCrawlerName(
    String firstName,
    String lastName,
    int crawlerNumber,
  ) {
    // Use a probability where numbers go up as their crawler number goes up.
    int lettersToIncludeInLastName = 3;
    String crawlerName = '$firstName ';

    int suffixNumber = 0;
    for (int i = 0; i < lettersToIncludeInLastName; i++) {
      if (i < lastName.length) {
        crawlerName += lastName[i];
      } else {
        suffixNumber++;
      }
    }

    if (suffixNumber > 0) {
      crawlerName += ' $suffixNumber';
    }

    return crawlerName;
  }
}
