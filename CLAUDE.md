# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

"Asocijacije" — a Flutter mobile game implementing a Serbian party game. Teams of 2 players explain concepts across 3 rounds: Normal (word explanations), One Word (single word clues), and Pantomime (gestures). Supports Serbian and English localization.

## Development Commands

```bash
flutter pub get                # Install dependencies
flutter gen-l10n               # Generate localization files from ARB files
flutter analyze                # Static analysis
flutter test                   # Run tests
flutter run                    # Run on connected device

# Code generation (required after modifying Hive models)
dart run build_runner build --delete-conflicting-outputs
```

## Architecture

### State Management — Riverpod

All providers in `lib/providers/all_providers.dart`:
- `gameAdminProvider` (StateProvider<GameState>) — team playing, player explaining, round in progress, allWordsGuessed flag
- `wordsProvider` (ChangeNotifierProvider<WordsState>) — word pools (wordsToPlay, usedWords), shuffle/refresh between rounds
- `playerNumberProvider`, `localeProvider`, `gameModeProvider`, `blurProvider`, `checkerProvider` — simple StateProviders

GameState uses immutable copyWith pattern for updates.

### Mixin Pattern

Game logic lives in mixins mixed into `ConsumerState` widgets (not pure Dart — they require `WidgetRef`):
- **GameMixin** (`lib/mixins/game_mixin.dart`) — round progression, team/player rotation, timer duration logic
- **FormsMixin** (`lib/mixins/forms_mixin.dart`) — form validation, word list selection by locale, Hive team generation
- **HomeCardsMixin** (`lib/mixins/home_cards_mixin.dart`) — menu card configuration

### Game Flow

- 3 rounds, advancing only when all words are guessed (not on timer expiry alone)
- Timer: Normal mode 45s/45s/60s, Quick mode 30s/30s/45s per round
- Team rotation: Team1-P1 → Team2-P1 → Team1-P2 → Team2-P2 → round advances
- Each player gets 8 words; same word pool recycled across rounds via `refreshWords()`
- Word blur (`blurProvider`) prevents opponents from seeing cards until "Start" pressed

### Data Persistence — Hive

- `Team` model (`lib/models/team.dart`) — `@HiveType(typeId: 0)`, fields: player1, player2, points
- Box keys: `'tim-1'`, `'tim-2'`, etc.
- Box utilities in `lib/util/boxes.dart` (getTeams, addPoints, getWinnerTeam)
- Box opened in StartGamePage, cleared on init, closed on HomePage exit
- **Game state is NOT persisted** — only team names/points. App close = game lost.

### Localization

- ARB files: `lib/l10n/app_sr.arb`, `lib/l10n/app_en.arb`
- Supported locales defined in `lib/l10n/l10n.dart`
- Usage: `AppLocalizations.of(context)!.keyName`
- Word lists: `rsWords` (334 words), `enWords` (590 words) in `lib/words/words.dart`
- **Caveat**: Game mode stored as localized string ('Normalan'/'Normal'), so locale shouldn't change mid-game

### Navigation

- Named routes in `lib/constants/app_routes.dart`: `/home`, `/startGame`, `/game`, `/scoreboard`, `/instructions`
- `NavigationService` (`lib/services/navigation_service.dart`) — global navigator key for context-free navigation
- Heavy use of `pushNamedAndRemoveUntil()` to prevent back-navigation during gameplay
- `PopScope` with `canPop: false` on game screens

### Key Dependencies

- **flutter_riverpod** — state management
- **hive/hive_flutter** — local storage (requires build_runner for code gen)
- **flutter_card_swiper** — word card swiping UI
- **circular_countdown_timer** — round timers with external controller
- **just_audio** — correct answer sound effect (`assets/sounds/correct-choice.mp3`)
- **firebase_core/firebase_analytics** — analytics
- **in_app_update** — Android-only in-app updates (checked on HomePage init)
- **flutter_form_builder** — team name input forms
