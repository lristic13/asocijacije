# Asocijacije — App Icon ("Neon Arcade")

Drop-in iOS and Android launcher icons. Same artwork everywhere: the rounded **A** with
cool-white bloom, neon cyan + magenta speech bubbles, and a glowing ember dot on the deep
indigo glow wash. All PNGs are pre-rendered at the required resolutions from the 1024 master.

## iOS
`ios/AppIcon.appiconset/` is a complete asset catalog set with a `Contents.json`.

**Install:** in Xcode, delete the existing `AppIcon` in `Assets.xcassets` and drag this
`AppIcon.appiconset` folder in (or copy the PNGs + `Contents.json` over the existing set).
The `1024×1024` master doubles as the App Store icon. Icons are opaque (no alpha) — iOS
applies the rounded-corner mask itself.

## Android
`android/res/` follows the standard resource layout.

- **Adaptive icon (API 26+):** `mipmap-anydpi-v26/ic_launcher.xml` +
  `ic_launcher_round.xml` reference two layers per density:
  - `ic_launcher_background.png` — full-bleed art dimmed into a backdrop (opaque), so the
    glow continues past the foreground edges on any mask shape.
  - `ic_launcher_foreground.png` — the full mark shrunk to ~66% and centered (transparent
    around it) so the A, bubbles, and dot all survive any mask (circle, squircle, rounded
    square).
- **Legacy icons (API < 26):** `ic_launcher.png` + `ic_launcher_round.png` per density.
- **Play Store listing:** `ic_launcher-playstore.png` (512×512).

**Install:** merge `android/res/` into your app module's `src/main/res/`. Ensure your
manifest points at it: `android:icon="@mipmap/ic_launcher"` and
`android:roundIcon="@mipmap/ic_launcher_round"`.

> Flutter shortcut: instead of hand-placing files you can use `flutter_launcher_icons` with
> `ios/AppIcon.appiconset/icon-1024.png` as the source `image_path` and
> `ic_launcher_foreground.png` (xxxhdpi) as `adaptive_icon_foreground` with
> `adaptive_icon_background: "#000000"`.

## Regenerating / tweaking
The artwork is drawn in code (canvas), not painted — so orb size, glow spread, and color
temperature are all parametric. The master source is `app-icon/Asocijacije Icon.html`
(the `drawIcon` function). Ask and I can re-export with any adjustment, or in a
different accent.

## Sizes included
- **iOS:** 1024, 180, 167, 152, 120, 87, 80, 76, 60, 58, 40, 29, 20 px
- **Android adaptive:** 108 / 162 / 216 / 324 / 432 px (mdpi→xxxhdpi), fg + bg
- **Android legacy:** 48 / 72 / 96 / 144 / 192 px, square + round
- **Play Store:** 512 px
