## Relevant Files

- `lib/providers/all_providers.dart` - Add `doublePointsProvider`
- `lib/models/game_mode.dart` - Add double points threshold constants
- `lib/l10n/app_sr.arb` - Add Serbian localization strings
- `lib/l10n/app_en.arb` - Add English localization strings
- `lib/pages/start_game/start_game_page.dart` - Add toggle switch UI
- `lib/util/boxes.dart` - Update `addPoints` to support adding variable points
- `lib/widgets/buttons/app_ingame_button.dart` - Determine point value based on timer and pass to addPoints
- `lib/widgets/app_cards_builder.dart` - Show "2 points" label on card during double points zone
- `lib/widgets/app_timer.dart` - Timer widget (read remaining time via CountDownController)
- `lib/pages/game/game_page.dart` - Reset doublePointsProvider on game exit
- `lib/widgets/app_final_score.dart` - Reset doublePointsProvider on new game

### Notes

- Run `flutter gen-l10n` after updating ARB files.
- Run `flutter analyze` after all changes to verify no issues.
- `CountDownController.getTime()` returns a `String` — parse to int for threshold comparison.

## Instructions for Completing Tasks

**IMPORTANT:** As you complete each task, you must check it off in this markdown file by changing `- [ ]` to `- [x]`. This helps track progress and ensures you don't skip any steps.

Update the file after completing each sub-task, not just after completing an entire parent task.

## Tasks

- [x] 1.0 Add double points provider and constants
  - [x] 1.1 Add `doublePointsProvider` (`StateProvider<bool>`, default `false`) to `lib/providers/all_providers.dart`
  - [x] 1.2 Add threshold constants to `GameMode` in `lib/models/game_mode.dart`: `normalDoublePointsThreshold = 10`, `quickDoublePointsThreshold = 7`, `normalMimeDoublePointsThreshold = 15`, `quickMimeDoublePointsThreshold = 10`
- [x] 2.0 Add localization strings
  - [x] 2.1 Add to `app_sr.arb`: `"dupliPoeni"`: `"Dupli poeni"`, `"dvaPoena"`: `"2 poena"`
  - [x] 2.2 Add to `app_en.arb`: `"dupliPoeni"`: `"Double points"`, `"dvaPoena"`: `"2 points"`
  - [x] 2.3 Run `flutter gen-l10n`
- [x] 3.0 Add toggle switch to start game page
  - [x] 3.1 Add a `Switch` widget with label below the game mode buttons row in `start_game_page.dart`
  - [x] 3.2 Wire the toggle to read/write `doublePointsProvider`
- [x] 4.0 Implement double points scoring logic
  - [x] 4.1 Update `Boxes.addPoints` to accept an optional `int points` parameter (default 1)
  - [x] 4.2 In `AppInGameButton`, when "Next word" is pressed, check if double points is enabled and timer is within threshold — pass `2` or `1` to `addPoints`
  - [x] 4.3 Add a helper method to determine the current threshold based on game mode and round
- [x] 5.0 Add "2 points" label on word card during double points zone
  - [x] 5.1 Pass `CountDownController` and double points state to `AppCardsBuilder`
  - [x] 5.2 Show a localized "2 poena" / "2 points" label on the card when in the double points zone (not blurred, timer within threshold, feature enabled)
- [x] 6.0 Reset double points state on new game
  - [x] 6.1 In `app_final_score.dart` "New game" button, reset `doublePointsProvider` to `false`
  - [x] 6.2 In `game_page.dart` exit dialog "Yes" button, reset `doublePointsProvider` to `false`
- [x] 7.0 Verify with flutter analyze
  - [x] 7.1 Run `flutter analyze` and fix any issues
