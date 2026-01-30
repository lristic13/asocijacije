// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Serbian (`sr`).
class AppLocalizationsSr extends AppLocalizations {
  AppLocalizationsSr([String locale = 'sr']) : super(locale);

  @override
  String get language => 'Srpski';

  @override
  String get asocijacije => 'Asocijacije';

  @override
  String get saPapiricaUApp => 'sa papirića u aplikaciju!';

  @override
  String get pocniIgru => 'Počni igru';

  @override
  String get uputstvaZaIgru => 'Uputstva za igru';

  @override
  String get izlaz => 'Izlaz';

  @override
  String get ime1Igraca => 'Ime 1.igrača';

  @override
  String get ime2Igraca => 'Ime 2.igrača';

  @override
  String get igraca => 'igrača';

  @override
  String get dalje => 'Dalje';

  @override
  String get nazad => 'Nazad';

  @override
  String get tim => 'Tim';

  @override
  String get normalnaRunda => 'Normalna Runda';

  @override
  String get normalnaRundaUput =>
      'Treba objasniti zadatu reč bez korišćenja iste, ili korena iste. Traje 45 sekundi.';

  @override
  String get jednaRecRunda => 'Jedna reč Runda';

  @override
  String get jednaRecRundaUput =>
      'Treba objasniti zadatu reč korišćenjem samo jedne reči koja je slična zadatoj, ili će asocirati na zadatu reč. Traje 45 sekundi.';

  @override
  String get pantomimaRunda => 'Pantomima Runda';

  @override
  String get pantomimaRundaUput =>
      'Treba objasniti zadatu reč pantomimom. Traje 60 sekundi.';

  @override
  String get rezultatUput =>
      'Rezultat se sabira kroz runde, tim sa najviše poena je pobednički.';

  @override
  String get odustajanjeUput =>
      'Ukoliko ne možete da objasnite reč, možete odustati od objašnjavanja i preneti do sad osvojene bodove.';

  @override
  String get napomena => 'Napomena';

  @override
  String get napomenaTekst =>
      'U novu rundu se ne prelazi dok se ne pogode sve reči iz trenutne runde!';

  @override
  String get unesiteImeIgraca => 'Unesite ime igrača!';

  @override
  String get daLiSteSigurniIzlaz =>
      'Da li ste sigurni da želite da izađete? Moraćete da krenete igru iz početka!';

  @override
  String get poeni => 'Poeni';

  @override
  String get odustani => 'Odustani';

  @override
  String get odustajete => 'Odustajete?';

  @override
  String get odustaniAlertContent =>
      'Ako odustanete, prenosite bodove i na redu je sledeći tim.';

  @override
  String get sledecaRec => 'Sledeća reč';

  @override
  String get sledeciTim => 'Sledeći tim';

  @override
  String get start => 'Start';

  @override
  String get da => 'Da';

  @override
  String get ne => 'Ne';

  @override
  String get rezultat => 'Rezultat';

  @override
  String get sledeciIgraTim => 'Sledeći igraju';

  @override
  String get krajIgre => 'Kraj igre';

  @override
  String get pobednikJeTim => 'Pobednici su';

  @override
  String get novaIgra => 'Nova igra';

  @override
  String get pogodjeneSveReci =>
      'Pogodili ste sve reči!\n Pređite na sledeću rundu';

  @override
  String get izaberiMod => 'Izaberi mod igre';

  @override
  String get normalan => 'Normalan';

  @override
  String get brzi => 'Brzi';

  @override
  String get dupliPoeni => 'Dupli poeni';

  @override
  String get dvaPoena => '2 poena';

  @override
  String get dupliPoeniObjasnjenje =>
      'Reči pogođene u poslednjih nekoliko sekundi runde donose 2 poena umesto 1!\n\nNormalan mod:\n• Normalna i Jedna reč runda: poslednjih 10 sekundi\n• Pantomima runda: poslednjih 15 sekundi\n\nBrzi mod:\n• Normalna i Jedna reč runda: poslednjih 7 sekundi\n• Pantomima runda: poslednjih 10 sekundi';

  @override
  String get imeTima => 'Ime tima';

  @override
  String get unesiteImeTima => 'Unesite ime tima!';

  @override
  String get prikupiReci => 'Prikupi reči';

  @override
  String get skenirajDaDodas => 'Skeniraj da dodaš reči';

  @override
  String get kodSesije => 'Kod sesije';

  @override
  String get napredak => 'Napredak';

  @override
  String igracaSpremo(Object ready, Object total) {
    return '$ready od $total igrača spremno';
  }

  @override
  String get igraci => 'Igrači';

  @override
  String get igrac => 'Igrač';

  @override
  String get pocniIgruBtn => 'POČNI IGRU ✓';

  @override
  String get cekanjeNaReci => 'ČEKANJE NA REČI...';

  @override
  String potrebnoJosReci(Object count) {
    return 'Potrebno još $count reči';
  }

  @override
  String get greskaKreiranjaSesije => 'Greška pri kreiranju sesije';

  @override
  String get koristiSvojeReci => 'Koristi svoje reči';

  @override
  String get izaberiReci => 'Izaberi reči';

  @override
  String get kakoZeliteDaIgrate => 'Kako želiš da igraš?';

  @override
  String get koristiReciIzAplikacije => 'Koristi reči iz aplikacije';

  @override
  String get viseOdReciSpremno => 'Više od 1500 unapred pripremljenih reči';

  @override
  String get svakiIgracDodaje =>
      'Svaki igrač dodaje 8 reči skeniranjem QR koda';
}
