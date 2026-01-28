# PRD: Double Points Feature

## Introduction/Overview

An optional game modifier that awards 2 points instead of 1 for words guessed during the final seconds of each round. When enabled via a toggle on the start game page, a "2 points" label appears on the word card during the double points window, and scoring updates accordingly. This adds excitement and tension to the final moments of each turn.

## Goals

1. Allow players to enable/disable double points before starting a game
2. Award 2 points for words guessed in the final seconds of each round
3. Provide clear visual feedback (label on the card) when double points are active
4. Scale thresholds appropriately for both Normal and Quick game modes

## User Stories

- As a player, I want to toggle double points on/off during game setup so I can choose whether to play with this modifier.
- As a player, I want to see a "2 points" label on the word card when I'm in the double points zone so I know the stakes are higher.
- As a player, I want my team to earn 2 points for correctly guessed words in the final seconds.

## Functional Requirements

1. **Toggle on Start Game Page**: Add a toggle switch below the game mode selection, labeled "Dupli poeni" (SR) / "Double points" (EN). Default: OFF.
2. **Provider**: Add a `doublePointsProvider` (`StateProvider<bool>`) to track the setting, defaulting to `false`.
3. **Double Points Thresholds** (seconds remaining):

   | Round | Normal Mode | Quick Mode |
   |-------|------------|------------|
   | Normal (Round 1) | ≤ 10s | ≤ 7s |
   | One Word (Round 2) | ≤ 10s | ≤ 7s |
   | Mime (Round 3) | ≤ 15s | ≤ 10s |

4. **Scoring Logic**: When double points is enabled and the timer is within the threshold, `Boxes.addPoints` should add 2 instead of 1. Otherwise, add 1 as normal.
5. **Visual Feedback**: When in the double points zone, display a "2 poena" / "2 points" label on the word card. No animation needed — just update the score normally.
6. **Timer Access**: The game needs to read the current remaining time from `CountDownController` to determine if the double points window is active.
7. **Reset**: The `doublePointsProvider` should be reset when starting a new game (alongside other game state resets).
8. **Localization**: Add ARB entries for toggle label, and card label.

## Non-Goals (Out of Scope)

- Audio feedback for entering the double points zone
- Animated "+2" or "DUPLO!" text effects
- Score breakdown (regular vs double) on the final scoreboard
- Persisting the double points preference across app sessions
- Custom timing windows or multipliers beyond 2x

## Design Considerations

- The toggle should appear below the game mode buttons on the start game page, using a `Switch` widget styled consistently with the app theme
- The "2 points" label on the card should be clearly visible but not obstruct the word text — positioned at the top or bottom of the card
- Timer color does not change — the card label is the sole indicator

## Technical Considerations

- `CountDownController` from `circular_countdown_timer` needs to expose the remaining time. Verify that `controller.getTime()` returns a usable value for threshold comparison.
- `Boxes.addPoints` currently always increments by 1. It needs a `points` parameter (defaulting to 1) or a new method to support adding 2.
- Double points thresholds should live as constants in `GameMode` alongside existing timer duration constants.
- The card widget (`AppCardsBuilder`) needs access to the timer state and double points setting to conditionally show the label.

## Success Metrics

- Toggle appears and functions correctly on start game page
- Points correctly award 2 during the threshold window when enabled
- "2 points" label appears on the card during the double points zone
- Feature has no effect when toggle is OFF
- `flutter analyze` passes with no issues

## Open Questions

- None — requirements are clear.
