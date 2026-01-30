# PRD: QR Code Word Collection Feature

## 1. Introduction/Overview

The QR Code Word Collection feature allows players to submit custom words for the Asocijacije game using their own devices. The host's phone displays a QR code that opens a web page where each player submits exactly 8 words. The game can only start once all players have submitted their required words.

This feature enhances the party game experience by letting players personalize the word pool, making the game more engaging and tailored to the group's interests, inside jokes, or specific themes.

## 2. Goals

1. Enable players to contribute custom words via their own devices by scanning a QR code
2. Ensure exactly 8 words are collected from each player before the game can start
3. Provide real-time progress feedback to the host showing submission status
4. Support both Serbian and English languages on the web interface
5. Seamlessly integrate with the existing game flow on the Start Game page

## 3. User Stories

### Host (Flutter App)
- As a host, I want to generate a QR code so that other players can easily access the word submission page
- As a host, I want to see real-time progress of word submissions so I know when everyone is ready
- As a host, I want the "Start Game" button to only activate when all players have submitted 8 words so the game has enough content
- As a host, I want to cancel the session and return to normal gameplay if needed

### Guest (Web Browser)
- As a guest, I want to scan a QR code and immediately access the word submission page without downloading an app
- As a guest, I want to add exactly 8 words one by one with clear progress indication
- As a guest, I want to remove words I've added if I change my mind
- As a guest, I want confirmation that my words were successfully submitted
- As a guest, I want to use the interface in my preferred language (Serbian or English)

## 4. Functional Requirements

### 4.1 Firebase Setup
1. The system must use Firebase Realtime Database to sync word submissions between devices
2. Sessions must expire after 30 minutes to prevent stale data accumulation
3. Security rules must enforce that only 8 words can be submitted per player
4. Sessions must only accept submissions while status is "collecting"

### 4.2 Flutter App (Host Side)

5. The system must read player count from `playerNumberProvider` (supporting 2-10 players)
6. The app must generate a unique 6-character session ID using unambiguous characters (no 0/O, 1/I/L confusion)
7. The app must display a QR code that links to the web submission page
8. The app must display the session code as text for manual entry fallback
9. The app must show real-time progress: total words submitted, target words needed, and per-player status
10. The app must show a progress bar indicating overall completion percentage
11. The "Start Game" button must remain disabled until all players have submitted exactly 8 words each
12. Total required words = playerCount × 8
13. The app must allow the host to cancel the session and return to normal game flow
14. When the game starts, collected words must replace the default word list entirely (no mixing with `rsWords`/`enWords`)
15. The custom words must integrate with the existing `WordsState` provider

### 4.3 Web Interface (Guest Side)

16. The web page must load with the session ID from the URL path (e.g., `/submit/ABC123`)
17. The web page must validate that the session exists and is still collecting
18. The web page must support both Serbian and English languages
19. Language selection must be available to the user (auto-detect or manual selection)
20. Users must be able to add words one at a time via text input
21. Users must not be able to add more than 8 words
22. Users must not be able to add duplicate words (case-insensitive check)
23. The interface must show a progress bar (0/8 to 8/8 words)
24. Users must be able to remove words before submission
25. The Submit button must only activate when exactly 8 words are added
26. After successful submission, the interface must show confirmation and disable further input
27. The interface must show an error if the session has expired or ended

### 4.4 Start Game Page Integration

28. A "Custom Words" option/button must appear on the Start Game page before team setup
29. Tapping "Custom Words" must navigate to the Word Collection screen
30. After successful word collection, the app must proceed to team setup with custom words loaded
31. The user must be able to skip custom words and use default word lists

### 4.5 Error Handling

32. The system must handle network connectivity issues gracefully
33. The system must prevent submission to expired sessions
34. The system must clean up expired sessions periodically

## 5. Non-Goals (Out of Scope)

- Player names/identification on the web interface (submissions are anonymous)
- Editing words after submission
- Real-time preview of other players' words
- Content filtering for inappropriate words (trust-based for party game context)
- Offline mode for custom word collection
- Sharing session via SMS/WhatsApp (QR code and manual code entry only)
- Mixing custom words with default word lists
- Persisting custom word sessions across app restarts

## 6. Design Considerations

### Flutter App (Word Collection Screen)
- Display large, scannable QR code centered on screen
- Show session code prominently below QR code for manual entry
- Progress section with:
  - Linear progress bar
  - "X / Y words" text
  - "Z of N players ready" text
- Player list showing check marks for completed submissions
- Large "Start Game" button at bottom (disabled until ready)
- Use existing app color scheme (`AppColors.englishViolet` family)
- Use existing typography (`AppStyles`)

### Web Interface
- Mobile-first responsive design
- Clean, modern UI with gradient background
- Large touch targets for mobile users
- Clear visual feedback for word additions/removals
- Progress bar matching the overall app feel
- Language toggle in header or as initial selection

### Start Game Page
- Add "Custom Words" button/card before team setup section
- Visual indication when custom words mode is active
- Option to return to default words

## 7. Technical Considerations

### Dependencies to Add
```yaml
firebase_database: ^10.4.0  # Realtime Database
qr_flutter: ^4.1.0          # QR code generation
uuid: ^4.0.0                # Session ID generation
```

### Firebase Structure
```json
{
  "sessions": {
    "ABC123": {
      "createdAt": timestamp,
      "hostId": "device_id",
      "playerCount": 4,
      "status": "collecting",
      "expiresAt": timestamp,
      "targetWords": 32,
      "words": {
        "player_xyz": {
          "words": ["word1", "word2", ...],
          "submittedAt": timestamp
        }
      }
    }
  }
}
```

### Integration Points
- `playerNumberProvider` - read player count
- `wordsProvider` / `WordsState` - inject custom words instead of default lists
- `localeProvider` - pass locale preference to web interface URL
- Existing Firebase setup in `main.dart` (already initialized)

### Web Hosting
- Deploy web interface to Firebase Hosting
- URL pattern: `https://[project-id].web.app/submit/[sessionId]`
- Configure URL rewrites for clean paths

## 8. Success Metrics

1. **Functionality:** All players can successfully submit 8 words via QR code scan
2. **Reliability:** Session creation and word sync work without errors
3. **Performance:** Real-time updates appear within 1-2 seconds
4. **Usability:** Users can complete word submission without instructions
5. **Completion Rate:** Sessions started result in successful game starts (no abandonment due to technical issues)

## 9. Clarifications

1. **Word length:** No minimum word length requirement
2. **Word visibility:** Host receives all words when game starts (needed for gameplay), but during collection only shows counts per player
3. **Resume capability:** Players can resume submission if they close browser (persist player ID in localStorage)
4. **Completion notification:** No audio/visual notification needed - UI updates to show ready state
5. **Session code case:** Case-insensitive (convert input to uppercase for matching)
