## Relevant Files

- `lib/models/team.dart` - Add `teamName` field to the Hive model
- `lib/models/team.g.dart` - Regenerated Hive adapter (via build_runner)
- `lib/widgets/cards/team_card.dart` - Add team name input field to the card UI
- `lib/mixins/forms_mixin.dart` - Extract and store `teamName` from form data
- `lib/pages/scoreboard/scoreboard_page.dart` - Display team name instead of "Tim X"
- `lib/pages/game/game_page.dart` - Display current team name during gameplay
- `lib/widgets/app_final_score.dart` - Show winner team name
- `lib/util/boxes.dart` - Update `getWinnerTeam` to return `Team` object
- `lib/l10n/app_sr.arb` - Add Serbian localization strings
- `lib/l10n/app_en.arb` - Add English localization strings

### Notes

- After modifying `team.dart`, run `dart run build_runner build --delete-conflicting-outputs` to regenerate the Hive adapter.
- Run `flutter gen-l10n` after updating ARB files.
- Run `flutter analyze` after all changes to verify no issues.

## Instructions for Completing Tasks

**IMPORTANT:** As you complete each task, you must check it off in this markdown file by changing `- [ ]` to `- [x]`. This helps track progress and ensures you don't skip any steps.

Update the file after completing each sub-task, not just after completing an entire parent task.

## Tasks

- [x] 1.0 Update Team model with teamName field
  - [x] 1.1 Add `@HiveField(4) String teamName` to `lib/models/team.dart` (required in constructor)
  - [x] 1.2 Update `toString()` to include `teamName`
  - [x] 1.3 Run `dart run build_runner build --delete-conflicting-outputs` to regenerate `team.g.dart`
- [x] 2.0 Add localization strings
  - [x] 2.1 Add `"imeTima": "Ime tima"` and `"unesiteImeTima": "Unesite ime tima!"` to `lib/l10n/app_sr.arb`
  - [x] 2.2 Add `"imeTima": "Team name"` and `"unesiteImeTima": "Enter team name!"` to `lib/l10n/app_en.arb`
  - [x] 2.3 Run `flutter gen-l10n` to regenerate localization files
- [x] 3.0 Update TeamCard UI with team name input
  - [x] 3.1 Replace the static `"Tim ${index + 1}"` header text with a `FormBuilderTextField` for `teamName`
  - [x] 3.2 Add required validation using the new `unesiteImeTima` localization string
  - [x] 3.3 Use `AppStyles.errorInputDecoration` with `imeTima` label, matching existing player field styling
- [x] 4.0 Update FormsMixin to store team name
  - [x] 4.1 In `validateForms`, extract `formData['teamName']` alongside player1/player2
  - [x] 4.2 Pass `teamName` to the `Team` constructor
- [x] 5.0 Update display screens to show team name
  - [x] 5.1 Update `Boxes.getWinnerTeam` in `lib/util/boxes.dart` to return `Team?` instead of `String?`
  - [x] 5.2 In `scoreboard_page.dart`, replace `'Tim ${index + 1}'` with `currentTeam.teamName`
  - [x] 5.3 In `scoreboard_page.dart`, update the "Sledeći igra Tim X" text to show team name by looking up the team from Hive
  - [x] 5.4 In `game_page.dart`, store and display the current team's `teamName` (e.g. in a header or near the explaining row)
  - [x] 5.5 In `app_final_score.dart`, replace the winner text to use `winnerTeam.teamName` instead of extracting the last char of the Hive key
- [x] 6.0 Verify with flutter analyze
  - [x] 6.1 Run `flutter analyze` and fix any issues
