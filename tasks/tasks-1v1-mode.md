# Tasks: 1v1 Mode Implementation

## Relevant Files

- `lib/models/one_vs_one_state.dart` - New model class for 1v1 player names and scores
- `lib/models/game_state.dart` - Add `is1v1Mode` flag to existing GameState
- `lib/providers/all_providers.dart` - Add `oneVsOneProvider` StateProvider
- `lib/providers/words_state.dart` - Add support for 15-word pool generation
- `lib/l10n/app_sr.arb` - Serbian localization strings for 1v1 mode
- `lib/l10n/app_en.arb` - English localization strings for 1v1 mode
- `lib/pages/one_vs_one/one_vs_one_setup_page.dart` - New setup page for player names
- `lib/pages/one_vs_one/one_vs_one_results_page.dart` - New results screen for 1v1
- `lib/pages/home/home_page.dart` - Add 1v1 mode card/button
- `lib/pages/game/game_page.dart` - Adapt for 1v1 mode (scores, player display)
- `lib/pages/instructions/instructions_page.dart` - Add 1v1 rules section
- `lib/constants/app_routes.dart` - Add routes for 1v1 pages
- `lib/widgets/buttons/app_ingame_button.dart` - Update scoring logic for 1v1
- `lib/widgets/app_points.dart` - Display individual player scores in 1v1
- `lib/mixins/game_mixin.dart` - Add 1v1 round/player rotation logic
- `lib/mixins/home_cards_mixin.dart` - Add 1v1 card configuration

### Notes

- Scores are stored in memory via Riverpod (not persisted to Hive)
- 1v1 mode uses 15 words per player (30 total), recycled across 3 rounds
- Timer durations remain the same as team mode
- Player 1 always starts first

## Instructions for Completing Tasks

**IMPORTANT:** As you complete each task, you must check it off in this markdown file by changing `- [ ]` to `- [x]`. This helps track progress and ensures you don't skip any steps.

Example:
- `- [ ] 1.1 Read file` → `- [x] 1.1 Read file` (after completing)

Update the file after completing each sub-task, not just after completing an entire parent task.

## Tasks

- [x] 0.0 Create feature branch
  - [x] 0.1 Create and checkout a new branch: `git checkout -b feat/1v1-mode`

- [x] 1.0 Add 1v1 state management and providers
  - [x] 1.1 Create `lib/models/one_vs_one_state.dart` with `OneVsOneState` class (player1Name, player2Name, player1Score, player2Score, currentPlayer)
  - [x] 1.2 Add `copyWith()`, `resetScores()`, and `addPointToCurrentPlayer()` methods to OneVsOneState
  - [x] 1.3 Add `oneVsOneProvider` StateProvider in `all_providers.dart`
  - [x] 1.4 Add `is1v1Mode` field to `GameState` class in `game_state.dart`
  - [x] 1.5 Update `GameState.copyWith()` and `resetGame()` to handle `is1v1Mode`
  - [x] 1.6 Words per player constant added to `OneVsOneState` (15 words) - word pool setup will use this in setup page

- [x] 2.0 Add localization strings for 1v1 mode
  - [x] 2.1 Add Serbian strings to `app_sr.arb`: 1v1 mode name, winner text, tie text, margin text, instructions
  - [x] 2.2 Add English strings to `app_en.arb`: matching keys for all 1v1 strings
  - [x] 2.3 Run `flutter gen-l10n` to generate localization Dart files

- [x] 3.0 Create 1v1 setup page (player name entry)
  - [x] 3.1 Create `lib/pages/one_vs_one/` directory
  - [x] 3.2 Create `one_vs_one_setup_page.dart` with two TextFormField inputs for player names
  - [x] 3.3 Add form validation requiring both names to be entered
  - [x] 3.4 Add game speed toggle (Normal/Quick) using existing pattern
  - [x] 3.5 Add "Start Game" button that initializes `oneVsOneProvider` and `gameAdminProvider` with `is1v1Mode: true`
  - [x] 3.6 Initialize word pool with 15 words and navigate to game page

- [x] 4.0 Update home screen with 1v1 mode option
  - [x] 4.1 Add 1v1 card configuration to `HomeCardsMixin`
  - [x] 4.2 Add 1v1 card/button to home page UI (updated cardsCount to 4)
  - [x] 4.3 Add route constant for 1v1 setup page in `app_routes.dart`
  - [x] 4.4 Wire up navigation from home to 1v1 setup page (via NavigationService)

- [x] 5.0 Adapt game page for 1v1 mode
  - [x] 5.1 Add conditional check for `is1v1Mode` in `game_page.dart`
  - [x] 5.2 Create/modify `AppPoints` widget to show individual player scores when in 1v1 mode
  - [x] 5.3 Replace team name display with current explaining player's name
  - [x] 5.4 Update `AppInGameButton` to add points via `oneVsOneProvider` instead of Hive when in 1v1 mode
  - [x] 5.5 Update `GameMixin.roundEnd()` to alternate players (P1→P2→P1→P2) in 1v1 mode
  - [x] 5.6 Ensure round progression works correctly (advance after all words guessed)
  - [x] 5.7 Navigate to 1v1 results page instead of team final score when game ends (via NavigationService)

- [x] 6.0 Create 1v1 results screen
  - [x] 6.1 Create `one_vs_one_results_page.dart` in `lib/pages/one_vs_one/`
  - [x] 6.2 Display winner's name prominently (or "It's a tie!" if scores equal)
  - [x] 6.3 Show both player names with their final scores
  - [x] 6.4 Show margin of victory (e.g., "Won by 3 words") - only if not a tie
  - [x] 6.5 Add "Play Again" button that resets scores and restarts game with same players
  - [x] 6.6 Add "Home" button that resets all state and navigates to home
  - [x] 6.7 Add route constant for 1v1 results page in `app_routes.dart`

- [x] 7.0 Update instructions page with 1v1 rules
  - [x] 7.1 Add new section for 1v1 mode rules in `instructions_page.dart`
  - [x] 7.2 Include explanation: players alternate turns, opponent guesses
  - [x] 7.3 State winning condition: "The player who explains more words wins"

- [ ] 8.0 Test end-to-end gameplay
  - [ ] 8.1 Test player name entry form and validation
  - [ ] 8.2 Test Normal speed: all 3 rounds with P1→P2 alternation
  - [ ] 8.3 Test Quick speed: verify timer durations
  - [ ] 8.4 Test scoring including double points zone
  - [ ] 8.5 Test tie scenario (equal scores)
  - [ ] 8.6 Test "Play Again" restarts correctly
  - [ ] 8.7 Verify existing team mode has no regressions
