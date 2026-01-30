# Tasks: QR Code Word Collection Feature

## Relevant Files

- `lib/services/word_collection_service.dart` - Service for creating sessions, watching submissions, collecting words
- `lib/pages/word_collection/word_collection_page.dart` - QR code display and progress tracking UI
- `lib/providers/all_providers.dart` - Add provider for custom words mode state
- `lib/pages/start_game/start_game_page.dart` - Add "Custom Words" button integration
- `lib/providers/words_state.dart` - Modify to accept custom words
- `lib/models/session_state.dart` - Data model for session state
- `lib/models/player_submission.dart` - Data model for player submissions
- `lib/l10n/app_sr.arb` - Serbian localization strings
- `lib/l10n/app_en.arb` - English localization strings
- `lib/constants/app_routes.dart` - Add route for word collection page
- `public/submit.html` - Web interface for word submission (Firebase Hosting)
- `firebase.json` - Firebase hosting configuration with rewrites
- `database.rules.json` - Firebase Realtime Database security rules
- `pubspec.yaml` - Add new dependencies

### Notes

- Firebase Realtime Database is used for real-time sync between host app and web guests
- Web interface is hosted on Firebase Hosting and accessed via QR code scan
- Player ID stored in localStorage for resume capability
- Session codes are case-insensitive (converted to uppercase)

## Instructions for Completing Tasks

**IMPORTANT:** As you complete each task, you must check it off in this markdown file by changing `- [ ]` to `- [x]`. This helps track progress and ensures you don't skip any steps.

Example:
- `- [ ] 1.1 Read file` → `- [x] 1.1 Read file` (after completing)

Update the file after completing each sub-task, not just after completing an entire parent task.

## Tasks

- [x] 1.0 Firebase Realtime Database Setup
  - [x] 1.1 Add `firebase_database: ^10.4.0` to pubspec.yaml
  - [x] 1.2 Add `qr_flutter: ^4.1.0` to pubspec.yaml
  - [x] 1.3 Add `uuid: ^4.0.0` to pubspec.yaml
  - [x] 1.4 Run `flutter pub get`
  - [x] 1.5 Create `database.rules.json` with security rules for sessions collection
  - [ ] 1.6 Enable Realtime Database in Firebase Console (if not already enabled)
  - [ ] 1.7 Deploy security rules via `firebase deploy --only database`

- [x] 2.0 Create Word Collection Service (Flutter)
  - [x] 2.1 Create `lib/models/player_submission.dart` with fields: playerId, words, submittedAt, playerName
  - [x] 2.2 Create `lib/models/session_state.dart` with fields: sessionId, playerCount, targetWords, submissions, totalWords, playersReady, isReady
  - [x] 2.3 Create `lib/services/word_collection_service.dart`
  - [x] 2.4 Implement `_generateSessionId()` - 6 character alphanumeric (exclude ambiguous chars)
  - [x] 2.5 Implement `createSession(int playerCount, String hostId)` - creates session in Firebase
  - [x] 2.6 Implement `watchSession(String sessionId)` - returns Stream<SessionState> for real-time updates
  - [x] 2.7 Implement `collectWords(String sessionId)` - returns List<String> of all submitted words
  - [x] 2.8 Implement `closeSession(String sessionId)` - marks session as completed
  - [x] 2.9 Implement `deleteSession(String sessionId)` - removes session from database

- [x] 3.0 Create Word Collection Screen UI (Flutter)
  - [x] 3.1 Add route `/wordCollection` to `lib/constants/app_routes.dart`
  - [x] 3.2 Create `lib/pages/word_collection/word_collection_page.dart`
  - [x] 3.3 Implement session creation on initState using playerNumberProvider
  - [x] 3.4 Display QR code using qr_flutter package with web URL containing session ID and locale
  - [x] 3.5 Display session code text below QR for manual entry fallback
  - [x] 3.6 Add StreamBuilder to watch session state in real-time
  - [x] 3.7 Display progress bar showing totalWords / targetWords
  - [x] 3.8 Display "X of Y players ready" text
  - [x] 3.9 Display player list with checkmarks for completed submissions
  - [x] 3.10 Add "Start Game" button that is disabled until isReady is true
  - [x] 3.11 Add cancel/back button that deletes session and returns to previous screen
  - [x] 3.12 On "Start Game" press, collect words and pass them to game flow
  - [x] 3.13 Add localization strings to app_sr.arb and app_en.arb

- [x] 4.0 Create Web Interface for Word Submission
  - [x] 4.1 Create `public/` directory in project root for Firebase Hosting
  - [x] 4.2 Create `public/submit.html` with responsive mobile-first design
  - [x] 4.3 Add Firebase SDK imports and initialization
  - [x] 4.4 Implement session ID extraction from URL path
  - [x] 4.5 Implement player ID generation and localStorage persistence for resume capability
  - [x] 4.6 Add language toggle (Serbian/English) with translations
  - [x] 4.7 Implement word input field with "Add" button
  - [x] 4.8 Display progress bar (0/8 to 8/8)
  - [x] 4.9 Display word tags with remove (×) buttons
  - [x] 4.10 Implement duplicate word prevention (case-insensitive)
  - [x] 4.11 Disable "Add" button when 8 words reached
  - [x] 4.12 Enable "Submit" button only when exactly 8 words added
  - [x] 4.13 Implement submit function that writes to Firebase
  - [x] 4.14 Show success message and disable inputs after submission
  - [x] 4.15 Handle session expired/invalid errors gracefully
  - [x] 4.16 Create `firebase.json` with hosting config and URL rewrites for `/submit/**`
  - [ ] 4.17 Deploy web interface via `firebase deploy --only hosting`

- [x] 5.0 Integrate with Start Game Page
  - [x] 5.1 Add `customWordsProvider` StateProvider<bool> to all_providers.dart
  - [x] 5.2 Add "Custom Words" button/card to start_game_page.dart before team setup
  - [x] 5.3 Add localization strings for "Custom Words" button and description
  - [x] 5.4 Navigate to WordCollectionPage when "Custom Words" is tapped
  - [x] 5.5 Handle return from WordCollectionPage with collected words
  - [x] 5.6 Show visual indicator when custom words mode is active
  - [x] 5.7 Add option to cancel custom words and return to default word list

- [x] 6.0 Integrate Custom Words with Game Flow
  - [x] 6.1 Add `customWordsListProvider` StateProvider<List<String>> to all_providers.dart
  - [x] 6.2 Modify FormsMixin.validateForms() to check customWordsListProvider before using default lists
  - [x] 6.3 Custom words are shuffled the same way as default words
  - [x] 6.4 Reset customWordsListProvider when game ends or user cancels (app_final_score.dart, game_page.dart exit dialog)
  - [x] 6.5 Custom words integrate with existing refreshWords() logic between rounds (uses same wordsToPlay/usedWords mechanism)

- [ ] 7.0 Testing and Cleanup
  - [x] 7.1 Run flutter analyze - No issues found
  - [ ] 7.2 Enable Realtime Database in Firebase Console
  - [ ] 7.3 Deploy database rules: `firebase deploy --only database`
  - [ ] 7.4 Deploy web interface: `firebase deploy --only hosting`
  - [ ] 7.5 Test session creation and QR code generation
  - [ ] 7.6 Test web interface on multiple browsers (Chrome, Safari mobile)
  - [ ] 7.7 Test real-time progress updates from web to Flutter app
  - [ ] 7.8 Test resume capability (close browser, reopen, continue adding words)
  - [ ] 7.9 Test with different player counts (4, 6, 8, 10 players)
  - [ ] 7.10 Test game flow with custom words (all 3 rounds)
  - [ ] 7.11 Verify no regressions in default word list gameplay
