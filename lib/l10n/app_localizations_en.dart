// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get language => 'English';

  @override
  String get asocijacije => 'Asocijacije';

  @override
  String get saPapiricaUApp => 'forget the paper, use the app!';

  @override
  String get pocniIgru => 'Start game';

  @override
  String get uputstvaZaIgru => 'Instructions';

  @override
  String get izlaz => 'Exit';

  @override
  String get ime1Igraca => 'Player 1 name';

  @override
  String get ime2Igraca => 'Player 2 name';

  @override
  String get igraca => 'players';

  @override
  String get dalje => 'Next';

  @override
  String get nazad => 'Back';

  @override
  String get tim => 'Team';

  @override
  String get normalnaRunda => 'Normal Round';

  @override
  String get normalnaRundaUput =>
      'The word should be explained without using the target word. Round duration: 45 seconds.';

  @override
  String get jednaRecRunda => 'One word Round';

  @override
  String get jednaRecRundaUput =>
      'The word should be explained using only one word, which will be similar to the target one, or will remind you of the target one. Round duration: 45 seconds.';

  @override
  String get pantomimaRunda => 'Mime Round';

  @override
  String get pantomimaRundaUput =>
      'The word should be explained using only mime. Round duration: 60 seconds.';

  @override
  String get rezultatUput =>
      'The result is accumulated through the rounds, the team with the most points wins.';

  @override
  String get odustajanjeUput =>
      'If you can\'t explain the target word, you can give up and transfer the points.';

  @override
  String get napomena => 'Note';

  @override
  String get napomenaTekst =>
      'The round won\'t be changed until all the words from the current round have been guessed!';

  @override
  String get unesiteImeIgraca => 'Enter player name!';

  @override
  String get daLiSteSigurniIzlaz =>
      'Are you sure you want to quit? You will have to start the game again!';

  @override
  String get poeni => 'Score';

  @override
  String get odustani => 'Give up';

  @override
  String get odustajete => 'Give up?';

  @override
  String get odustaniAlertContent =>
      'If you give up, you\'ll transfer the points and it\'s the next team\'s turn.';

  @override
  String get sledecaRec => 'Next word';

  @override
  String get sledeciTim => 'Next team';

  @override
  String get start => 'Start';

  @override
  String get da => 'Yes';

  @override
  String get ne => 'No';

  @override
  String get rezultat => 'Score';

  @override
  String get sledeciIgraTim => 'Up next is Team';

  @override
  String get krajIgre => 'Final score';

  @override
  String get pobednikJeTim => 'The winner is Team';

  @override
  String get novaIgra => 'New game';

  @override
  String get pogodjeneSveReci =>
      'You\'ve guessed all the words!\n Move on to the next round!';

  @override
  String get izaberiMod => 'Choose game mode';

  @override
  String get normalan => 'Normal';

  @override
  String get brzi => 'Quick';

  @override
  String get dupliPoeni => 'Double points';

  @override
  String get dvaPoena => '2 points';

  @override
  String get dupliPoeniObjasnjenje =>
      'Words guessed in the final seconds of the round earn 2 points instead of 1!\n\nNormal mode:\n• Normal and One-word rounds: last 10 seconds\n• Mime round: last 15 seconds\n\nQuick mode:\n• Normal and One-word rounds: last 7 seconds\n• Mime round: last 10 seconds';
}
