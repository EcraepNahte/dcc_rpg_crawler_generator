import 'dart:math';

class CrawlerIdentificationService {
  static int crawlersInDungeon =
      12935453; // This is the number of crawlers that entered the dungeon in Dungeon Crawler Carl
  static int rolls = 3;

  static int generateCrawlerNumber() {
    return Random().nextInt(crawlersInDungeon - 1) +
        1; // Add one to ensure we don't get 0
    // TODO: make a loop and blacklist known crawler numbers from the books.
  }

  static String generateCrawlerName(
    String firstName,
    String lastName,
    int crawlerNumber,
  ) {
    int lettersToIncludeInLastName = _generateLetterCount(crawlerNumber);

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

  static int _generateLetterCount(int crawlerNumber) {
    // Use a probability where letters in their last name go up as their crawler number goes up.
    double progressToMax = log(crawlerNumber) / log(crawlersInDungeon);

    int lettersToIncludeInLastName = 0;
    double rand = Random().nextDouble();
    while (progressToMax > rand) {
      lettersToIncludeInLastName++;
      progressToMax *= .95;
      rand = Random().nextDouble();
    }

    return lettersToIncludeInLastName;
  }
}
