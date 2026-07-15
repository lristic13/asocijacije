import 'package:flutter/material.dart';

/// Neon Arcade palette.
///
/// The `NA*` style tokens below are the source of truth for the redesign.
/// The legacy `englishViolet*` / `coral` / `tiffanyBlue` names are kept as
/// aliases that point at the new palette so existing widgets re-skin
/// automatically without a sweeping rename.
class AppColors {
  // ---- Neon Arcade tokens ----
  /// Base app background (deep indigo).
  static const Color bg = Color(0xFF0E0826);

  /// Primary text on dark.
  static const Color ink = Color(0xFFFFFFFF);

  /// Secondary / muted text (lavender-grey).
  static const Color sub = Color(0xFFA99FD6);

  /// Primary accent — main CTAs, active states, brand ".".
  static const Color orange = Color(0xFFFC7753);

  /// Secondary accent — destructive/ghost, Team Alpha.
  static const Color magenta = Color(0xFFFF4D8D);

  /// Tertiary accent — confirm, score highlight, Team Beta.
  static const Color cyan = Color(0xFF33E1CE);

  /// Word-card border/label, captions.
  static const Color violet = Color(0xFF8B7BE8);

  /// Raised card base (used in gradients).
  static const Color card = Color(0xFF1B1442);

  /// Lighter card top used in the word-card gradient.
  static const Color cardLight = Color(0xFF2A1E5C);

  /// Hard bottom "lip" shadow under orange buttons.
  static const Color orangeLip = Color(0xFFC9572F);

  /// Hard bottom "lip" shadow under cyan buttons.
  static const Color cyanLip = Color(0xFF1FAE9E);

  /// Dark text used on top of bright orange/cyan fills.
  static const Color inkOnFill = Color(0xFF1A0E2E);

  // ---- Legacy aliases (mapped onto the new palette) ----
  static const Color tiffanyBlue = cyan;
  static const Color tiffanyBlueDarker = cyanLip;
  static const Color englishViolet = card;
  static const Color englishVioletMoreLighter = violet;
  static const Color englishVioletLighter = sub;
  static const Color englishVioletDarker = bg;
  static const Color white = ink;
  static const Color whiteDarker = sub;
  static const Color coral = orange;
  static const Color coralDarker = orangeLip;
}
