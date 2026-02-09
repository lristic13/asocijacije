# PRD: 1v1 Mode

## Introduction/Overview

The 1v1 Mode feature allows two players to compete directly against each other without forming teams. In this mode, players take turns explaining words to their opponent, who must guess them. The player who successfully explains more words across all rounds wins the game.

This mode addresses the need for a lighter, quicker gameplay option when only two people want to play, removing the requirement for 4+ players while maintaining the core game mechanics.

## Goals

1. Enable two players to play Asocijacije competitively without needing additional players
2. Maintain the same engaging 3-round structure (Normal → One Word → Pantomime)
3. Keep both players actively engaged throughout the game (one explains, one guesses)
4. Provide a balanced competitive experience where skill in explaining determines the winner

## User Stories

1. **As a player**, I want to select 1v1 mode from the home screen so that I can play with just one other person.

2. **As a player**, I want to enter my name and my opponent's name so that the game can track our individual scores.

3. **As the explaining player**, I want to explain words to my opponent within the time limit so that I can score points.

4. **As the guessing player**, I want to guess my opponent's explanations so that they can score points (and vice versa when roles swap).

5. **As a player**, I want to see the current score and who is winning after each turn so that I can track the competition.

6. **As a player**, I want to see a final results screen showing who won and by how many words so that we have a clear winner.

## Functional Requirements

### Mode Selection
1. The home screen must include a "1v1" mode option alongside the existing team mode
2. Selecting 1v1 mode must navigate to a player name entry screen (2 players)

### Player Setup
3. The player setup screen must allow entry of two player names (Player 1 and Player 2)
4. The system must validate that both names are entered before starting
5. The system must support both Normal and Quick game speed options

### Game Flow
6. The game must use 15 words per player (30 total words in the pool)
7. The game must follow the same 3-round structure: Normal → One Word → Pantomime
8. Players must alternate turns after each timer expires (P1 → P2 → P1 → P2 → ...)
9. The same word pool must be recycled across all 3 rounds (via `refreshWords()`)
10. The round must advance only when all words have been guessed (not just on timer expiry)

### Turn Mechanics
11. Each turn, the current player explains words while the opponent guesses
12. The timer durations must match team mode:
    - Normal speed: 60s / 60s / 75s (rounds 1/2/3)
    - Quick speed: 45s / 45s / 60s (rounds 1/2/3)
13. The explaining player taps "Next Word" when the opponent guesses correctly
14. The explaining player taps "Skip" to pass on a word (no point awarded)
15. Words must be blurred until the "Start" button is pressed (same as team mode)

### Scoring
16. Each correctly guessed word awards 1 point to the explaining player
17. Double points zone must be available in 1v1 mode (same as team mode)
18. The system must track individual scores for each player in memory (not persisted to Hive)
19. The current score for both players must be visible during gameplay
20. Player 1 always starts first (no randomization)

### Game End & Results
21. The game ends after both players have completed all 3 rounds
22. If scores are equal, declare a tie (show "It's a tie!" / "Nerešeno!")
23. The final screen must display:
    - Winner's name (or "It's a tie!" if equal scores)
    - Final scores for both players
    - Margin of victory (e.g., "Won by 3 words") - only if not a tie
24. A "Play Again" button must allow restarting with the same players
25. A "Home" button must return to the main menu

### Instructions Page
26. The instructions page must include a section explaining 1v1 mode rules
27. The 1v1 rules section must state: "The winner is the player who explains more words"

## Non-Goals (Out of Scope)

- Online/remote 1v1 play (both players must be on the same device)
- Ranked/leaderboard system for 1v1 matches
- Different word counts or timer durations specific to 1v1 mode
- Tournament/bracket mode for multiple 1v1 matches
- Spectator mode
- QR code word collection for 1v1 mode (uses standard word pool only)

## Design Considerations

### Home Screen
- Add a new card/button for "1v1" mode, styled consistently with existing mode buttons
- Consider placing it prominently as an alternative to team play

### Player Setup Screen
- Simpler than team setup: just 2 text fields for player names
- Reuse existing form styling from team name entry

### Game Screen
- Adapt existing game UI to show individual player scores instead of team scores
- Display "Player 1: X pts | Player 2: Y pts" format
- Show whose turn it is prominently (e.g., "Marko is explaining")

### Results Screen
- Create a new 1v1 results layout showing head-to-head comparison
- Highlight the winner with visual emphasis

## Technical Considerations

### State Management
- Extend `GameState` to support a `is1v1Mode` flag
- Add individual player score tracking in memory via Riverpod (not Hive)
- Create a simple `OneVsOneState` class to track player names and scores

### Provider Updates
- `gameAdminProvider` needs to handle 1v1 player rotation logic (P1 → P2 alternating)
- `wordsProvider` needs to support 15-word pool generation (instead of 8 for teams)
- Add `oneVsOneProvider` (StateProvider) to track player names and scores in memory

### Navigation
- New route for 1v1 setup page
- Reuse existing game page with conditional rendering based on mode

### Localization
- Add new ARB keys for 1v1-specific strings:
  - "1v1" / "1 na 1"
  - "{name} wins!" / "{name} pobeđuje!"
  - "It's a tie!" / "Nerešeno!"
  - "Won by X words" / "Pobeda za X reči"
  - Instructions text for 1v1 mode

## Success Metrics

1. Feature is fully playable end-to-end with 2 players
2. Score tracking accurately reflects words explained by each player
3. All 3 rounds function correctly with proper word recycling
4. Instructions page clearly explains 1v1 rules
5. No regressions in existing team mode functionality

## Open Questions

All key questions have been resolved:
- ~~Scores~~ → Memory only (not persisted)
- ~~Double Points~~ → Yes, available in 1v1
- ~~Who goes first~~ → Player 1 always starts
- ~~Tie handling~~ → Declare a tie

No remaining open questions.
