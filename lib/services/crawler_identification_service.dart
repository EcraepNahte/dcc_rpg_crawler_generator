import 'dart:math';

import 'package:dcc_rpg_crawler_generator/model/stat_block.dart';

class CrawlerIdentificationService {
  static int crawlersInDungeon =
      12935453; // This is the number of crawlers that entered the dungeon in Dungeon Crawler Carl
  static int rolls = 3;

  static final races = [
    'Amazonian',
    'Arachnid',
    'Cat',
    'Cat Girl/Cat Boy',
    'Changbi Demon',
    'Changeling',
    'Crocodilian',
    'Doppelgänger',
    'Dwarf, Classic',
    'Dwarf, Fathom',
    'Elf, High',
    'Elf, City',
    'Elf, Night',
    'Frost Maiden',
    'Human',
    'Igneous',
    'Lajabless',
    'Obsidian Butterfly',
    'Primal',
    'Rat Hooligan',
    'Sasquatch',
    'Tetrakai',
    'Tigran',
    'Bune',
    'Caprid',
    'Grulke',
    'Hobgoblin',
    'Pocket Kuma',
    'Pterolykos',
    'Skyfowl',
  ];

  static final classes = [
    "Boring ol' Alchemist",
    "Alchemist",
    "Douchy Wizard School Wand-Maker",
    "Infernocrafter",
    "Prison Tattoo Artist",
    "Boring ol' Barbarian",
    "Gladiator",
    "Harii",
    "Feral Cat Berserker",
    "Shieldmaiden",
    "Boring ol' Bard",
    "Artist Alley Mogul",
    "Former Child Actor",
    "Necrobard",
    "Poet Laureate",
    "Professional Roadie",
    "Spellbinder",
    "Boring ol' Cleric",
    "Black Inquisitor General",
    "Santero",
    "Boring ol' Druid",
    "Herbalist",
    "Lifebringer",
    "Physicker",
    "Shepherd",
    "Boring ol' Fighter",
    "Pit Fighter",
    "Shotgun Messenger",
    "Straight To DVD Action Hero",
    "Sword and Boarder",
    "Monster Truck Driver",
    "Zulu Warrior",
    "Boring ol' Mage",
    "Blizzardmancer",
    "Crisper",
    "Fire Spritualist",
    "Forsaken Arialist",
    "Necromancer",
    "Boring ol' Monk",
    "Elemental Monk",
    "Prize Fighter",
    "Spirit Healer",
    "Street Monk",
    "Boring ol' Paladin",
    "Cavalier",
    "Sacred Paladin",
    "Boring ol' Rogue",
    "Bomb Squad Tech",
    "Compensated Anarchist",
    "High Rise Grifter",
    "Identity Theif",
    "Swashbuckler",
  ];

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

  static StatBlock generateCrawlerStats() {
    return StatBlock(
      strength: Random().nextInt(5) + 2,
      intelligence: Random().nextInt(5) + 2,
      constitution: Random().nextInt(5) + 2,
      dexterity: Random().nextInt(5) + 2,
      charisma: Random().nextInt(5) + 2,
    );
  }

  static String generateRandomRace() {
    return races.elementAt(Random().nextInt(races.length));
  }

  static String generateRandomClass() {
    return classes.elementAt(Random().nextInt(classes.length));
  }

  static int _generateLetterCount(int crawlerNumber) {
    // Use a probability where letters in their last name go up as their crawler number goes up.
    double progressToMax = log(crawlerNumber) / log(crawlersInDungeon);

    int lettersToIncludeInLastName = 0;
    double rand = Random().nextDouble();
    while (progressToMax > rand) {
      lettersToIncludeInLastName++;
      progressToMax *= .9;
      rand = Random().nextDouble();
    }

    return lettersToIncludeInLastName;
  }
}
