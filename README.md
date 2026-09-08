# DCC RPG Crawler Generator

A small Flutter app for generating randomized dungeon crawler characters inspired by the DCC RPG style. Each generated crawler includes a portrait, random name, level, race/class, stat block, and combat-ready traits such as hit points, mana, surprise, and evade.

## Overview

This app creates a one-off "crawler" from a pool of randomized personal data and fantasy identity generation. It is meant to feel like a quick generator for table-ready NPCs or player-character concepts for a dungeon-crawling campaign.

The generator pulls profile data from the public randomuser.me API, then applies custom logic to create a DCC-style crawler identity, including:

- Dungeon Crawler Carl-ized name and Crawler Number
- Level scaling based on selected dungeon floor
- randomized stats in the five core attributes
- Race and class generation on higher floors
- Image, age, location, and gender metadata
- Interactive health bar display and combat numbers

## Features

- Random crawler generation with a single tap
- Floor selector from 1 to 18
- Filter drawer for gender and nationality selections
- Stat block display for STR, INT, CON, DEX, and CHA
- Derived modifier values and combat values

## Tech Stack

- Flutter / Dart
- Provider for state management
- HTTP for remote user generation
- Intl for number formatting
- Google Fonts for the UI typography

## Requirements

Before running the app, make sure you have Flutter installed and configured correctly:

- Flutter SDK 3.12.0 or newer
- A supported IDE such as VS Code or Android Studio
- An emulator, simulator, or a desktop browser for running the app

## Getting Started

1. Clone the repository
2. Install dependencies
3. Run the app

```bash
git clone https://github.com/ecraepnahte/dcc_rpg_crawler_generator.git
cd dcc_rpg_crawler_generator
flutter pub get
flutter run
```

## Optional Android Build

To build the project for android:

```bash
flutter build apk
```

The build outputs will be found in the `build/app/outputs/flutter-apk/` directory.

## Optional iOS Build (Theoretical)

I do not have a mac, but theoretically, someone that does could build for iOS and Mac.
Instructions can be found in the [Flutter Docs](https://docs.flutter.dev/deployment/ios)

## Project Structure

```text
lib/
  main.dart                 # App entry point and provider setup
  model/
    crawler.dart            # Crawler generation and stat calculations
    stat_block.dart         # Core attribute model
  services/
    crawler_identification_service.dart
                           # Name, race, class, and stat generation logic
  view/
    random_crawler_page.dart
                           # Main UI for displaying generated crawlers
  viewmodel/
    filter_data.dart        # Shared state for filter selections
  widgets/
    filter_drawer.dart      # Filter sheet UI
```

## Notes

- The app uses the public randomuser.me API to generate the base identity for each crawler.
- Floor 1 generates lower-level crawlers, while higher floors increase potential level and special identity generation.
- This project is a prototype / generator rather than a full RPG rules engine.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
