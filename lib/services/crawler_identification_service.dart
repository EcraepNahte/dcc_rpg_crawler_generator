import 'dart:math';

class CrawlerIdentificationService {
  static int crawlersInDungeon =
      12935453; // This is the number of crawlers that entered the dungeon in Dungeon Crawler Carl
  static int rolls = 3;

  static int generateCrawlerNumber() {
    return Random().nextInt(crawlersInDungeon);
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
    int maxLetters = 10;
    double logProgress = log(crawlerNumber) / log(crawlersInDungeon);
    double linearProgress = crawlerNumber / crawlersInDungeon;
    double blendFactor =
        0.1; // Adjust to control blend between linear and log. Higher = more curve
    double progressToMax =
        (1.0 - blendFactor) * linearProgress + blendFactor * logProgress;
    int bias = (progressToMax * maxLetters).round();
    int rolls = 4;
    int lettersToIncludeInLastName = Random().nextInt(bias + 1);

    for (int i = 1; i < rolls; i++) {
      lettersToIncludeInLastName = max(
        lettersToIncludeInLastName,
        Random().nextInt(bias + 1),
      );
    }

    return lettersToIncludeInLastName;
  }
}
