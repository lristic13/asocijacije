import 'package:asocijacije_nove/mixins/game_mixin.dart';
import 'package:asocijacije_nove/models/game_state.dart';
import 'package:asocijacije_nove/providers/all_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

/// Minimal host that mixes in [GameMixin] so we can invoke its methods with a
/// real [WidgetRef] / [BuildContext]. NavigationService safely no-ops in tests
/// (no navigator), so only the state transitions run.
class _Harness extends ConsumerStatefulWidget {
  const _Harness();
  @override
  ConsumerState<_Harness> createState() => _HarnessState();
}

class _HarnessState extends ConsumerState<_Harness> with GameMixin {
  @override
  Widget build(BuildContext context) => const SizedBox.shrink();
}

Future<_HarnessState> _pump(
  WidgetTester tester, {
  required int players,
  required GameState initial,
}) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        playerNumberProvider.overrideWith((ref) => players),
        gameAdminProvider.overrideWith((ref) => initial),
      ],
      child: const MaterialApp(home: _Harness()),
    ),
  );
  return tester.state<_HarnessState>(find.byType(_Harness));
}

void _emptyPool(WidgetRef ref) {
  final words = ref.read(wordsProvider);
  words.wordsToPlay.clear();
  words.usedWords
    ..clear()
    ..addAll(List.generate(32, (i) => 'w$i'));
}

void main() {
  testWidgets(
    'pool empties on last team P2 → round advances exactly once (no skip)',
    (tester) async {
      final host = await _pump(
        tester,
        players: 4,
        initial: const GameState(
          teamPlaying: 2,
          playerExplaining: 2,
          roundInProgress: 1,
        ),
      );
      _emptyPool(host.ref);

      // Game-page "Next team" button, then scoreboard "Next" (pool still empty).
      host.roundEnd(host.context, host.ref);
      host.allWordsGuessed(host.context, host.ref);

      expect(host.ref.read(gameAdminProvider).roundInProgress, 2);
    },
  );

  testWidgets(
    'pool empties mid-rotation (team1 P1) → round advances exactly once',
    (tester) async {
      final host = await _pump(
        tester,
        players: 4,
        initial: const GameState(
          teamPlaying: 1,
          playerExplaining: 1,
          roundInProgress: 1,
        ),
      );
      _emptyPool(host.ref);

      host.roundEnd(host.context, host.ref);
      host.allWordsGuessed(host.context, host.ref);

      expect(host.ref.read(gameAdminProvider).roundInProgress, 2);
    },
  );

  testWidgets(
    'timer expires with words remaining → round does NOT advance',
    (tester) async {
      final host = await _pump(
        tester,
        players: 4,
        initial: const GameState(
          teamPlaying: 2,
          playerExplaining: 2,
          roundInProgress: 1,
        ),
      );
      // Words still on the pile — a turn ended by the timer, not by clearing.
      host.ref.read(wordsProvider).wordsToPlay.addAll(['a', 'b', 'c']);

      host.roundEnd(host.context, host.ref);
      // Scoreboard would NOT call allWordsGuessed because the pool isn't empty.

      expect(host.ref.read(gameAdminProvider).roundInProgress, 1);
    },
  );
}
