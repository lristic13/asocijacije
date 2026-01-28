# Code Review — Asocijacije

**Overall Rating: 6/10 → 7.5/10 (after fixes)**

| Area | Before | After |
|------|--------|-------|
| Architecture & Structure | 7/10 | 8/10 |
| Error Handling | 3/10 | 5/10 |
| Testing | 1/10 | 1/10 |
| Code Quality | 6/10 | 8/10 |
| Best Practices | 5/10 | 7/10 |

---

## What's Good

- **Riverpod + mixin composition** is a reasonable architecture for this app size
- **GameState** has proper immutable copyWith pattern with equality/hashCode
- **NavigationService** with global key is well-structured
- **Localization** is set up correctly with ARB files and generated code
- **Const constructors** used consistently across widgets
- **Named routes** keep navigation organized

---

## Critical Issues

### 1. Zero meaningful tests — NOT FIXED
`test/widget_test.dart` is the default Flutter counter app test — it doesn't test this app at all. Game logic (round progression, scoring, team rotation) is completely untested.

### 2. ~~AudioPlayer memory leak~~ — FIXED
~~`lib/widgets/buttons/app_ingame_button.dart` — AudioPlayer is created but never disposed.~~
Added `dispose()` to `_AppInGameButtonState` that cleans up the `_audio` instance.

### 3. ~~Silent Firebase/Hive failures~~ — FIXED
~~`lib/main.dart` — if Firebase or Hive init fails, the app continues silently.~~
Hive init now runs without try-catch (crashes on failure, as it should — the app can't work without it). Firebase is wrapped separately since it's optional. Added `WidgetsFlutterBinding.ensureInitialized()`.

### 4. ~~Unsafe Hive box access~~ — FIXED
~~`lib/pages/game/game_page.dart` — box is accessed without verifying it's open.~~
Now uses `Boxes.getTeams()` with null check and fallback defaults.

### 5. ~~Game mode stored as localized string~~ — FIXED
~~`lib/providers/all_providers.dart` — default is `'Normalan'` (Serbian), compared against strings.~~
Replaced with `GameMode` enum (`GameMode.normal`, `GameMode.quick`). Updated `gameModeProvider`, `GameMixin.calculateRoundTime()`, `AppModeButton` (now takes a `GameMode mode` param), `StartGamePage`, and `AppLanguagesRow` (removed unnecessary gameModeProvider update on locale change).

---

## Medium Issues

### 6. ~~Hard-coded magic numbers~~ — FIXED
~~Timer durations, words-per-player, final round number scattered as literals.~~
All moved to named constants on `GameMode`: `normalRound1And2Duration`, `normalRound3Duration`, `quickRound1And2Duration`, `quickRound3Duration`, `wordsPerPlayer`, `finalRound`. `AppCardsBuilder` now uses `_cardsBufferCount`.

### 7. No loading states — NOT FIXED
Async operations (box opening, update checks) run without any loading indicator. Lower priority — the operations are fast enough that users are unlikely to notice.

### 8. ~~Inconsistent navigation~~ — FIXED
~~NavigationService exists but many places call `Navigator` directly.~~
Replaced direct `Navigator.pushNamedAndRemoveUntil` calls with `NavigationService.goToHome()` / `NavigationService.goToScoreboard()` / `NavigationService.goToStartGame()` / `NavigationService.goToInstructions()` in `game_mixin.dart`, `game_page.dart`, `app_final_score.dart`, and `home_cards_mixin.dart`.

### 9. Null-bang (`!`) overuse — NOT FIXED
`AppLocalizations.of(context)!` used everywhere. This is standard Flutter localization practice when locales are properly configured, so the risk is low in practice.

### 10. ~~`device_preview` in production dependencies~~ — FIXED
~~`pubspec.yaml` — should be in `dev_dependencies`.~~
Moved `device_preview`, `build_runner`, and `hive_generator` to `dev_dependencies`.

---

## Minor Issues

### 11. ~~Duplicate team fetch in GameMixin~~ — FIXED
~~`initBoxAndPlayers` fetched the same team ID twice.~~
Removed the entire method — it assigned to local parameters (no effect) and was unused.

### 12. ~~Box sorting mutates in place~~ — FIXED
~~`lib/util/boxes.dart` — `getWinnerTeam` sorted the original list.~~
Now uses `toList()..sort()` to sort a copy. Also fixed the comparator parameter naming for clarity.

### 13. ~~Words as in-memory lists~~ — FIXED
~~334 Serbian + 590 English words as top-level `List<String>` variables.~~
Moved to JSON asset files (`assets/words/sr.json`, `assets/words/en.json`). Added `WordsLoader` service that reads from assets via `rootBundle`. `FormsMixin.validateForms` is now async. Deleted `lib/words/words.dart`.

### 14. No accessibility — NOT FIXED
No `Semantics` widgets, no screen reader labels. Would require a dedicated effort across all widgets.

### 15. ~~Commented-out code~~ — FIXED
~~`lib/widgets/app_title_text.dart` had commented-out lines.~~
Removed. Also removed empty `dispose()` methods in `game_page.dart` and `start_game_page.dart`.

### 16. ~~`_checkForUpdate()` outside class~~ — FIXED
~~`lib/pages/home/home_page.dart` — was a top-level function instead of a class method.~~
Moved inside `_HomePageConsumerState`, added `catchError` handling, fixed `super.initState()` call order.

---

## Remaining Improvement Opportunities

1. **Write unit tests for GameMixin** — round progression, team rotation, and timer calculation are the core logic and deserve test coverage
2. **Add loading states** — particularly for Hive box opening in `StartGamePage`
3. **Add accessibility** — `Semantics` widgets for screen readers
