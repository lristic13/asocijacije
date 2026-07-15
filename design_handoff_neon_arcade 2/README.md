# Handoff: Asocijacije — "Neon Arcade" Theme

## Overview
Asocijacije is a mobile party game (charades-style: teams of two compete to guess words against a timer). This package specifies the **Neon Arcade** visual theme — a loud, glowing, game-show aesthetic — across the four core screens: **Home**, **Game Setup**, **In-round Play**, and **Scoreboard**.

The goal of this handoff is to implement the Neon Arcade theme natively in the Asocijacije app codebase.

## About the Design Files
The files in this bundle are **design references created in HTML/React (via Babel in the browser)** — prototypes that show the intended look and behavior. They are **not production code to copy directly**, and they are not Flutter. The components are written as inline-styled React purely for prototyping convenience.

**This app is built in Flutter.** Your task is to **recreate these designs as native Flutter widgets** using the app's existing patterns — its theme, its widget library, its navigation (Navigator/go_router), and its state management (Provider/Riverpod/Bloc — whatever is already in use). Translate the design tokens below into a Flutter theme (a `colors.dart` / `app_theme.dart` with `Color` constants and `TextStyle`s). A **Flutter Implementation Guide** with concrete widget mappings and snippets is included near the end of this document.

> Note on units: every measurement in this doc is in **logical pixels**, which map **1:1 to Flutter's logical pixels** (`double` values in widgets). You can use the numbers directly — no conversion needed.

## Fidelity
**High-fidelity (hifi).** Colors, typography, spacing, radii, shadows, and glow values are final and exact — reproduce them pixel-faithfully. The only deliberately loose pieces are listed under "Open / to confirm" at the end.

## Canvas & Units
- All screens are designed at a **mobile canvas of 320 × 690 logical px**, which equals Flutter logical pixels. Use the numbers as-is; lay out fluidly to device width (don't hard-code 320).
- The screen has rounded corners of `44px` in the prototype frame — that is the **prototype's device bezel**, not part of the UI. Ignore it; your `Scaffold` fills the device safe area.
- A custom **status bar** (9:01, signal, battery) and a **home indicator** (rounded bar) are drawn in the prototype only to simulate the device. **Do not build these** — use `SafeArea` and the real OS status bar.
- Default screen padding is **~22–26px horizontal**. Specifics per screen below.

---

## Design Tokens

### Colors
| Token | Hex | Use |
|---|---|---|
| `bg` | `#0E0826` | Base app background (deep indigo) |
| `ink` | `#FFFFFF` | Primary text on dark |
| `sub` | `#A99FD6` | Secondary / muted text (lavender-grey) |
| `orange` | `#FC7753` | **Primary** accent — main CTAs, active states, brand "." |
| `magenta` | `#FF4D8D` | Secondary accent — destructive/ghost ("Give up", "Exit"), Team Alpha |
| `cyan` | `#33E1CE` | Tertiary accent — confirm ("Got it"), score highlight, Team Beta |
| `violet` | `#8B7BE8` | Word-card border/label, captions |
| `card` | `#1B1442` | Raised card base (used in gradients) |
| `orangeLip` | `#C9572F` | Hard bottom "lip" shadow under orange buttons |
| `cyanLip` | `#1FAE9E` | Hard bottom lip under cyan buttons |
| `inkText` | `#1A0E2E` | Dark text used **on top of** bright orange/cyan fills |

**App background** is not flat — it is `bg` with three soft radial glows layered on top:
```css
background:
  radial-gradient(120% 70% at 15% -5%, rgba(252,119,83,.22), transparent 55%),   /* orange, top-left */
  radial-gradient(120% 70% at 95% 105%, rgba(51,225,206,.16), transparent 55%),  /* cyan, bottom-right */
  radial-gradient(90% 60% at 95% 0%, rgba(255,77,141,.14), transparent 60%),     /* magenta, top-right */
  #0E0826;
```
Use this same multi-radial wash on every screen.

### Typography
Two families (both Google Fonts; bundle them in the app):
- **Display — "Fredoka"**, weight **600** (SemiBold). All headings, numerals, button labels, brand wordmark, team names, the word being guessed. Slightly rounded, friendly, arcade-y.
- **Body — "Hanken Grotesk"**, weights **600 / 700 / 800**. Labels, captions, player names, toggles, small uppercase tags.

| Role | Family | Weight | Size | Notes |
|---|---|---|---|---|
| Brand wordmark | Fredoka | 600 | 62 (home) | "Asocijacije" + orange "." |
| Screen title | Fredoka | 600 | 26 | e.g. "New game." with orange period |
| Big numeral (timer) | Fredoka | 600 | 50 | inside timer ring |
| Big numeral (score) | Fredoka | 600 | 56 | cyan, glowing |
| Word to guess | Fredoka | 600 | 38 | white, soft white glow |
| Button label (primary) | Fredoka | 600 | 19–22 | |
| Section / team name | Fredoka | 600 | 17–22 | |
| Scoreboard score | Fredoka | 600 | 44 | |
| Uppercase micro-label | Hanken Grotesk | 700–800 | 10–14 | letter-spacing 1–2px, UPPERCASE |
| Player names / captions | Hanken Grotesk | 600–700 | 12–13 | color `sub` |

Title motif: most titles end with an **orange period "."** and a short **orange underline bar** (40×5px, radius 4, with a soft orange glow `0 0 12px rgba(252,119,83,.6)`).

### Spacing
Loose 8-pt-ish rhythm. Common gaps: `8, 9, 11, 13, 14, 18, 22px`. Screen vertical padding ~`8–18px` top, ~`18–24px` bottom. Cards use internal padding `13–20px`.

### Radius
| Element | Radius |
|---|---|
| Primary buttons | 20px |
| Ghost buttons | 18px |
| Cards / team cards | 18px |
| Word card | 24px |
| Chips (player count) | 16px |
| Small stat tiles | 12px |
| Pills / toggles / language switch | 20–30px (fully round) |

### Shadows & Glow (the signature of this theme)
- **Primary button (orange):** `box-shadow: 0 5px 0 #C9572F, 0 12px 26px rgba(252,119,83,.45)`. The first layer is a **hard, un-blurred "lip"** directly below (3D tactile key); the second is a soft colored glow.
- **Confirm button (cyan):** `0 5px 0 #1FAE9E, 0 12px 26px rgba(51,225,206,.45)`.
- **Glowing numerals/labels:** `text-shadow: 0 0 22px <accent>` (e.g. cyan score, white word).
- **Active chip:** `box-shadow: 0 0 22px rgba(252,119,83,.5)` (orange bloom, no lip).
- **Leading scoreboard row:** `box-shadow: 0 0 26px <teamColor>33` + a `1.5px` solid border in the team color.
- **Word card:** `box-shadow: 0 0 36px rgba(139,123,232,.3), inset 0 1px 0 rgba(255,255,255,.08)`.
- On press, primary/confirm buttons should **translate down ~3px and shrink the lip to `0 2px 0`** to feel physically depressed (add this; the static mock doesn't show it).

### Component primitives
**Primary button** (`NaBtn`): full-width, radius 20, padding `15–18px × 20px`, Fredoka 600 @ 19–22, fill = accent color, text = `#1A0E2E` (dark) on bright fills, white on dark fills, the dual lip+glow shadow above, `white-space: nowrap`, centered row with `gap: 9` for an optional leading icon/glyph.

**Ghost button** (`NaGhost`): full-width, radius 18, padding `13px × 18px`, Fredoka 600 @ 16, text = accent color, background `rgba(255,255,255,.04)`, border `1.5px solid <accent>55` (the `55` = ~33% alpha). Used in pairs (e.g. Instructions / Exit, Give up / Got it where Got it is primary).

---

## Screens / Views

### 1 — Home
- **Purpose:** Entry point; pick language, start a game, or read instructions.
- **Layout:** Column, padding `8px 26px 24px`. Top: centered **language segmented control**. Middle (flex-grow, centered): 🎉 emoji (56px, magenta drop-shadow), brand wordmark **"Asocijacije."** (Fredoka 600 @ 62, white with orange "."), tagline "forget the paper, use the app!" (Hanken 700 @ 14.5, cyan). Bottom: button stack.
- **Language control:** pill, bg `rgba(255,255,255,.05)`, radius 30, padding 4. Two options ("Srpski" / "English"), each Hanken 700 @ 13, padding `6×16`, radius 24. Active = orange fill + `#1A0E2E` text; inactive = `sub` text, transparent.
- **Buttons:** Primary **"▶ Start game"** (orange, big — fontSize 22, padding 18×20, play-triangle glyph). Below it a row of two ghost buttons: **"Instructions"** (cyan) and **"Exit"** (magenta), `gap: 11`.

### 2 — Game Setup
- **Purpose:** Configure player count, mode, options, round timers, and teams before play.
- **Layout:** Column, padding `6px 22px 18px`, `gap: 13`. Title **"New game."** (orange period) + underline bar. Then, top to bottom:
  1. **Player-count chips** — row of 4, `gap: 9`. Values 4 / 6 / 8 / 10. Each chip: flex:1, radius 16, padding `11px 0`, centered. Number (Fredoka 600 @ 22) over label "players" (Hanken 700 @ 10). **Active (4):** orange fill, dark text, orange glow. Inactive: bg `rgba(255,255,255,.05)`, `1.5px` border `rgba(255,255,255,.1)`.
  2. **Mode toggle** — two equal cells "Normal" / "Quick", radius 14, padding 12. Active ("Normal") = **cyan** fill + dark text + cyan glow; inactive = faint bg + border.
  3. **"Double points" switch row** — bg `rgba(255,255,255,.04)`, radius 14, padding `11×15`. Label Fredoka 600 @ 15.5. iOS-style toggle: track 46×26 radius 20, ON = orange + glow, white 20px knob inset 3px right.
  4. **Round timer tiles** — three equal tiles (Normal 45s / One word 45s / Mime 60s), radius 12, bg `rgba(255,255,255,.04)`. Time value cyan (Fredoka 600 @ 17) over label (Hanken 700 @ 10, `sub`).
  5. **Team cards (×2)** — radius 18, bg `rgba(255,255,255,.04)`, border `1.5px <teamColor>55`, glow `0 0 18px <teamColor>22`. Header: a `9px` dot (team color, glowing) + team name (Fredoka 600 @ 17). Body: row of player name fields, each flex:1, Hanken 600 @ 12.5, `sub` text, bg `rgba(0,0,0,.25)`, radius 11, padding `9×11`. **Team Alpha = magenta**, **Team Beta = cyan**.
- **Footer:** row — ghost **"Back"** (flex 1, white) + primary **"Next →"** (flex 1.4, orange).

### 3 — In-round Play
- **Purpose:** The active guessing round — timer counting down, current word, score, advance/skip.
- **Layout:** Column, padding `8px 24px 18px`.
  - **Header row:** title "Normal round." (orange period + underline) on the left; a circular **"i"** info button on the right (30px, `1.5px` border `sub`, Hanken 700 @ 14).
  - **Timer + score row:** centered, `gap: 22`. Left = **timer ring**; right = score block: label "SCORE" (Hanken 800 @ 14, `sub`, UPPERCASE, letter-spacing 1) over numeral (Fredoka 600 @ 56, **cyan**, glow `0 0 22px rgba(51,225,206,.5)`).
  - **Timer ring:** 142×142. SVG, two stacked circles radius 58, strokeWidth 11, rotated -90°. Track = `rgba(255,255,255,.08)`. Progress = orange, `stroke-linecap: round`, dashoffset by remaining %, drop-shadow `0 0 8px rgba(252,119,83,.8)`. Center numeral Fredoka 600 @ 50, white.
  - **Turn caption:** centered. Team name (Fredoka 600 @ 19) + "Player 1 → Player 2" (Hanken 700 @ 13, `sub`, with orange arrow).
  - **Word card (the focal element):** flex-grow center. Full-width, radius 24, padding `44px 20px`, background `linear-gradient(150deg, #2A1E5C, #1B1442)`, border `1.5px #8B7BE866`, shadow `0 0 36px rgba(139,123,232,.3), inset 0 1px 0 rgba(255,255,255,.08)`. Inside: kicker "EXPLAIN THIS" (Hanken 800 @ 11, violet, letter-spacing 2, UPPERCASE) over the **word** "Hamburger" (Fredoka 600 @ 38, white, soft white glow).
  - **Footer:** ghost **"Give up"** (magenta, flex 1) + primary **"✓ Got it"** (**cyan**, flex 1.3).

### 4 — Scoreboard
- **Purpose:** Between-round standings; shows leader and who's up next.
- **Layout:** Column, padding `10px 24px 18px`.
  - **Header:** centered 🏆 (38px) + "Scoreboard." (Fredoka 600 @ 30, orange period).
  - **Score rows (×2):** `gap: 16`, `margin-top: 30`. Each row radius 20, padding `18×20`, space-between. **Leader** row: background `linear-gradient(120deg, <teamColor>28, rgba(255,255,255,.03))`, border `1.5px <teamColor>`, glow `0 0 26px <teamColor>33`, and a 👑 crown (22px) absolutely positioned `top:-12 left:18`. Non-leader: bg `rgba(255,255,255,.04)`, border `1.5px rgba(255,255,255,.1)`. Left = team name (Fredoka 600 @ 22) + players (Hanken 600 @ 12.5, `sub`). Right = score numeral (Fredoka 600 @ 44; leader colored + glow, else white).
  - **Up-next line:** centered, Fredoka 600 @ 17, white, with cyan team name + 🎤.
  - **Footer:** primary **"Next round →"** (orange, fontSize 21).

---

## Interactions & Behavior
- **Navigation:** Home → Setup → Play → Scoreboard → (Play next round) … loop until game ends. "Back" returns Setup→Home. Info "i" opens an Instructions overlay/sheet.
- **Button press:** primary/confirm buttons depress — translateY +3px and lip shrinks `0 5px 0` → `0 2px 0` over ~80ms. Ghost buttons brighten background to `rgba(255,255,255,.08)`.
- **Timer:** counts down per the round's configured seconds (45 normal/one-word, 60 mime). Ring `stroke-dashoffset` animates linearly with time remaining; ring color stays orange but should pulse/red-shift toward magenta under ~5s (suggested enhancement). At 0s the round ends → Scoreboard.
- **"Got it":** increments current team score (or +2 if Double points is on), advances to next word, brief cyan flash on the score numeral. **"Give up":** advances word with no points.
- **Chips / mode / toggle:** immediate selection; selected gains fill + glow as specified. Only one player-count and one mode active at a time.
- **Language switch:** swaps all copy between Serbian ("Srpski") and English; persists choice.
- **Reduced motion:** disable glows-pulsing and press-translate; keep static end states.

## State Management
- `language`: 'sr' | 'en' (persisted)
- `setup`: `{ playerCount: 4|6|8|10, mode: 'normal'|'quick', doublePoints: bool, timers: {normal, oneWord, mime}, teams: [{name, color, players[]}] }`
- `round`: `{ activeTeamIndex, activePlayerPair, roundType, secondsLeft, currentWord, wordQueue[] }`
- `scores`: per-team integer; `leaderIndex` derived.
- `phase`: 'home' | 'setup' | 'play' | 'scoreboard'.
- Word list/deck: data requirement — a categorized word bank per language (not included; see Assets).

## Assets
- **Fonts:** Fredoka (600) and Hanken Grotesk (600/700/800) — Google Fonts; bundle locally for offline play.
- **Emoji used as art:** 🎉 (home), 🏆 👑 🎤 (scoreboard), ▶ ✓ → glyphs in buttons. These are system emoji in the mock — for a polished store build, consider replacing with a custom icon set in the same warm palette (optional).
- **Word bank:** not included — supply/confirm the gameplay word lists per category and language.
- **No raster images** are used; everything is type, color, and CSS/SVG glow.

## Flutter Implementation Guide

### Suggested structure
```
lib/theme/neon_arcade_colors.dart   // Color constants + gradients
lib/theme/neon_arcade_text.dart     // TextStyle helpers
lib/widgets/neon_background.dart     // the multi-radial wash
lib/widgets/neon_button.dart         // NaButton + NaGhostButton
lib/widgets/timer_ring.dart          // CustomPainter ring with glow
lib/screens/{home,setup,play,scoreboard}_screen.dart
```

### Colors (`neon_arcade_colors.dart`)
```dart
import 'package:flutter/material.dart';

class NA {
  static const bg        = Color(0xFF0E0826);
  static const ink       = Color(0xFFFFFFFF);
  static const sub       = Color(0xFFA99FD6);
  static const orange    = Color(0xFFFC7753);
  static const magenta   = Color(0xFFFF4D8D);
  static const cyan      = Color(0xFF33E1CE);
  static const violet    = Color(0xFF8B7BE8);
  static const card      = Color(0xFF1B1442);
  static const orangeLip = Color(0xFFC9572F);
  static const cyanLip   = Color(0xFF1FAE9E);
  static const inkOnFill = Color(0xFF1A0E2E); // dark text on bright fills
}
```
Alpha note: the CSS `<color>55` hex-alpha suffixes mean ~33% opacity → use `NA.cyan.withOpacity(0.33)` etc. (`55`/255 ≈ 0.33, `22`≈0.13, `28`≈0.16, `66`≈0.40).

### Fonts
Use the **google_fonts** package (`GoogleFonts.fredoka(...)`, `GoogleFonts.hankenGrotesk(...)`) or bundle the TTFs and declare them in `pubspec.yaml`. Display = Fredoka w600; Body = Hanken Grotesk w600/700/800. For offline store builds, bundling locally is recommended.

### Background wash (`neon_background.dart`)
Flutter has no multi-radial CSS gradient, so **stack radial gradients** over the base color:
```dart
Widget neonBackground({required Widget child}) => DecoratedBox(
  decoration: const BoxDecoration(color: NA.bg),
  child: Stack(children: [
    _glow(const Alignment(-0.7, -1.05), const Color(0x38FC7753), 1.2), // orange TL  (.22)
    _glow(const Alignment(0.9, 1.05),  const Color(0x2933E1CE), 1.2),  // cyan BR    (.16)
    _glow(const Alignment(0.9, -1.0),  const Color(0x24FF4D8D), 0.9),  // magenta TR (.14)
    Positioned.fill(child: child),
  ]),
);
Widget _glow(Alignment c, Color color, double r) => Positioned.fill(
  child: DecoratedBox(decoration: BoxDecoration(
    gradient: RadialGradient(center: c, radius: r,
      colors: [color, color.withOpacity(0)], stops: const [0.0, 0.55]))));
```

### Signature button shadow (the lip + glow)
The two-layer CSS shadow → a **list of two `BoxShadow`s** (first = hard lip, blur 0, offset y; second = soft colored glow):
```dart
boxShadow: const [
  BoxShadow(color: NA.orangeLip, offset: Offset(0, 5), blurRadius: 0),        // hard lip
  BoxShadow(color: Color(0x73FC7753), offset: Offset(0, 12), blurRadius: 26), // glow (.45)
],
```
Wrap in `GestureDetector`/`InkWell` + `AnimatedContainer` (≈80ms): on press, `transform: Matrix4.translationValues(0,3,0)` and shrink the lip offset to `Offset(0,2)`.

### Glowing text & numerals
Flutter `TextStyle.shadows` gives the bloom directly:
```dart
TextStyle(fontSize: 56, color: NA.cyan,
  shadows: [Shadow(color: NA.cyan.withOpacity(0.5), blurRadius: 22)]);
```

### Timer ring (`timer_ring.dart`)
Use a `CustomPainter` (size 142): paint the track circle (radius 58, stroke 11, `Colors.white.withOpacity(.08)`), then the progress arc (`Paint..color = NA.orange ..strokeCap = StrokeCap.round ..strokeWidth = 11`, sweep = `2*pi*remainingFraction`, start `-pi/2`). Add the glow with `maskFilter: MaskFilter.blur(BlurStyle.normal, 4)` on a second arc pass. Center the numeral with a `Stack` + `Text` (Fredoka w600, 50, white). Animate with an `AnimationController` driving `secondsLeft`.

### Other mappings
| Prototype (CSS/React) | Flutter |
|---|---|
| `border-radius` | `BorderRadius.circular(n)` |
| `1.5px solid <c>55` border | `Border.all(color: c.withOpacity(.33), width: 1.5)` |
| inset highlight `inset 0 1px 0 …` | a thin top `Border` or a `LinearGradient` overlay (no true inset shadow) |
| iOS toggle | `Switch` themed to `NA.orange`, or a custom `AnimatedContainer` track |
| segmented language control | `Row` of `GestureDetector` pills, or `CupertinoSlidingSegmentedControl` |
| emoji art (🎉🏆👑🎤) | `Text` emoji are fine; swap for custom icons later if desired |
| word card gradient | `LinearGradient(begin: topLeft-ish, colors: [Color(0xFF2A1E5C), NA.card])` |

### Don't port
`source/shared.jsx` is the prototype's fake phone (status bar, home bar, bezel). **Skip it entirely** — use `Scaffold` + `SafeArea`.

---

## Files in this bundle
- `Neon Arcade Theme.html` — open in a browser to see all four screens rendered live at true size (the visual source of truth).
- `source/directionA.jsx` — the React reference components for all four screens (`AHome`, `ASetup`, `APlay`, `AScore`) with exact values (colors, sizes, shadows). Read it to pull precise numbers; **do not** ship it — reimplement as Flutter widgets.
- `source/shared.jsx` — the prototype phone shell. **Prototype-only** — do not port; use `Scaffold`/`SafeArea`.

## Open / to confirm
- Exact word-bank content and categories.
- Game-end condition (round count or score target) and the win screen (not yet designed).
- Instructions screen content (referenced by the "i" button and Home "Instructions").
- Whether to replace emoji with custom icons for store polish.
