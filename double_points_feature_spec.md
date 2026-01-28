# Double Points Feature Specification - Asocijacije Game

## Overview
This document describes the implementation of the optional "Double Points" feature in the Asocijacije Flutter game. When enabled, words guessed during the final seconds of each round earn double points (2 points instead of 1).

## Feature Toggle
- **Location:** Start Game setup page
- **UI Element:** Toggle switch labeled "Dupli Poeni" or "Double Points"
- **Default State:** OFF (disabled by default)
- **State Persistence:** Setting should persist within the game setup session but can be changed before starting each new game

## Double Points Rules by Round

### Normal Round (45 seconds)
- **Double Points Window:** Last 10 seconds (when timer shows ≤10 seconds remaining)
- Words guessed when timer is at 10s, 9s, 8s... 1s earn 2 points

### One-Word Round (45 seconds)
- **Double Points Window:** Last 10 seconds (when timer shows ≤10 seconds remaining)
- Words guessed when timer is at 10s, 9s, 8s... 1s earn 2 points

### Mime Round (60 seconds)
- **Double Points Window:** Last 15 seconds (when timer shows ≤15 seconds remaining)
- Words guessed when timer is at 15s, 14s, 13s... 1s earn 2 points

## Implementation Requirements

### Game Setup
1. Add toggle switch in the game setup/configuration screen
2. Label clearly in Serbian: "Dupli Poeni u Poslednjih X Sekundi" or similar
3. Brief description tooltip: "Reči pogođene u poslednjih 10/15 sekundi donose duplo poena"
4. Store the setting in game configuration state

### During Gameplay
1. **Timer Monitoring:** Track remaining time on each turn
2. **Point Calculation Logic:**
   ```
   if (doublePointsEnabled) {
     if (round == Normal || round == OneWord) {
       if (timeRemaining <= 10) {
         points = 2;
       } else {
         points = 1;
       }
     } else if (round == Mime) {
       if (timeRemaining <= 15) {
         points = 2;
       } else {
         points = 1;
       }
     }
   } else {
     points = 1;
   }
   ```

3. **Visual Feedback:**
   - When double points zone is active, show visual indicator:
     - Timer changes color (e.g., gold/yellow)
     - Border glow or pulse animation
     - Optional: "2x" badge/icon appears
   
4. **Audio Feedback (Optional):**
   - Subtle sound cue when entering double points zone
   - Different success sound when earning 2 points vs 1 point

5. **Score Display:**
   - When word is guessed during double points window:
     - Show "+2" animation or "⚡ DUPLO! +2" message
     - Update team score accordingly
   - Regular words show "+1" as normal

### Score Tracking
- Ensure all scoring logic properly accounts for double points
- Final scoreboard should accurately reflect all points earned
- (Optional) Show breakdown of regular vs double points in final stats

## Edge Cases

1. **Word guessed exactly at threshold:**
   - If timer shows exactly 10s (or 15s for Mime): counts as double points
   
2. **Feature disabled mid-game:**
   - Should not be possible - toggle only available during setup
   
3. **Timer precision:**
   - Use integer seconds for clarity (10, 9, 8... not 10.5s)
   
4. **Give Up button:**
   - If team gives up during double points window, no points awarded (standard behavior)

## UI/UX Considerations

### Visual Hierarchy
- Make double points zone visually distinct but not distracting
- Should enhance tension without overwhelming gameplay
- Consider accessibility (color blind friendly indicators)

### Information Display
- Players should clearly understand when they're in double points zone
- Don't rely solely on color - use icons, text, or animation
- Keep UI clean during non-double-points gameplay

### Fairness
- All teams have equal opportunity to earn double points
- Natural balance occurs across multiple rounds and turns
- The feature adds excitement without significantly unbalancing the game

## Testing Checklist

- [ ] Toggle works correctly on setup page
- [ ] Double points activate at correct time thresholds for each round
- [ ] Points are correctly awarded (2 vs 1)
- [ ] Visual indicators appear when entering double points zone
- [ ] Score calculation is accurate in final results
- [ ] Feature works correctly when disabled
- [ ] No crashes or bugs when rapidly guessing words in double points zone
- [ ] Timer display remains accurate
- [ ] Works correctly across all team counts (2-10 players)

## Future Enhancements (Optional)

- Save double points preference per player/device
- Statistics tracking: "X% of your points came from double points zone"
- Different multipliers (3x, 5x) for special events
- Custom timing windows for house rules

---

**Version:** 1.0  
**Last Updated:** January 2026  
**Game:** Asocijacije (Flutter)
