# PRD: Team Names Feature

## Introduction/Overview

Currently, teams are labeled generically as "Tim 1", "Tim 2", etc. throughout the game. Players can only input individual player names. This feature adds a required team name input field to each team card, allowing teams to choose their own name (e.g., "Lavovi", "Dream Team"). The team name replaces the generic "Tim X" label everywhere in the app — team cards, game screen, scoreboard, and winner announcement.

## Goals

1. Allow each team to input a custom team name before starting the game
2. Display team names consistently across all screens (setup, gameplay, scoreboard, final score)
3. Keep the existing player name inputs unchanged

## User Stories

- As a player, I want to give my team a custom name so the game feels more personal and fun.
- As a player, I want to see my team name on the scoreboard and winner screen instead of "Tim 1".

## Functional Requirements

1. **Team Card UI**: Add a text input field for team name above the player name fields in `TeamCard`. The field label should be localized ("Ime tima" / "Team name").
2. **Validation**: Team name is required. Show a localized validation error if left empty ("Unesite ime tima" / "Enter team name").
3. **Team Model**: Add a `teamName` field (`String`) to the `Team` Hive model. This requires running `build_runner` to regenerate the adapter.
4. **Form Processing**: In `FormsMixin.validateForms`, extract the `teamName` form value and pass it to the `Team` constructor.
5. **Display — Team Card Header**: Replace the static `"Tim ${index + 1}"` text in `TeamCard` with a live preview of the entered team name, or keep "Tim ${index + 1}" as the placeholder/label.
6. **Display — Scoreboard**: Replace `"Tim ${index + 1}"` with `currentTeam.teamName` in `scoreboard_page.dart`.
7. **Display — Game Page**: Show the current team's name somewhere visible during gameplay (e.g., in the explaining row area or as a header).
8. **Display — Final Score**: Replace the winner announcement to use `teamName` instead of extracting the last character of the Hive key.
9. **Localization**: Add ARB entries for new strings: team name label and validation message.

## Non-Goals (Out of Scope)

- Team name uniqueness validation (duplicate names are allowed)
- Changing team count logic — the number of teams still derives from `playerNumberProvider / 2`

## Design Considerations

- The team name field should appear as the first field in the team card, above the two player name fields
- Use the same input styling (`AppStyles.errorInputDecoration`) as player name fields for consistency
- On the scoreboard, show team name as the primary label with player names in parentheses below (current pattern)

## Technical Considerations

- **Hive migration**: Adding `teamName` as `@HiveField(4)` to `Team` requires running `dart run build_runner build --delete-conflicting-outputs` to regenerate `team.g.dart`
- **Boxes.getWinnerTeam**: Currently returns the Hive key string (`"tim-1"`). Should be updated to return the `Team` object (or its `teamName`) so the final score widget can display the actual name
- **FormBuilder**: The team name field uses `name: 'teamName'` in the form, extracted alongside `player1`/`player2` in `validateForms`

## Success Metrics

- All team cards show a team name input field
- Team names appear on scoreboard, game page, and winner announcement
- `flutter analyze` passes with no issues

## Open Questions

- None — requirements are clear.
