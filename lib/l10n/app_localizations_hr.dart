// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Croatian (`hr`).
class AppLocalizationsHr extends AppLocalizations {
  AppLocalizationsHr([String locale = 'hr']) : super(locale);

  @override
  String get language => 'Hrvatski';

  @override
  String get asocijacije => 'Asocijacije';

  @override
  String get saPapiricaUApp => 's papirića u aplikaciju!';

  @override
  String get pocniIgru => 'Počni igru';

  @override
  String get uputstvaZaIgru => 'Upute za igru';

  @override
  String get izlaz => 'Izlaz';

  @override
  String get ime1Igraca => 'Ime 1. igrača';

  @override
  String get ime2Igraca => 'Ime 2. igrača';

  @override
  String get igraca => 'igrača';

  @override
  String get dalje => 'Dalje';

  @override
  String get nazad => 'Natrag';

  @override
  String get tim => 'Tim';

  @override
  String get normalnaRunda => 'Normalna runda';

  @override
  String get normalnaRundaUput =>
      'Zadanu riječ treba objasniti bez korištenja te riječi ili njezina korijena. Traje 60 sekundi.';

  @override
  String get jednaRecRunda => 'Jedna riječ runda';

  @override
  String get jednaRecRundaUput =>
      'Zadanu riječ treba objasniti korištenjem samo jedne riječi koja je slična zadanoj ili asocira na zadanu riječ. Traje 60 sekundi.';

  @override
  String get pantomimaRunda => 'Pantomima runda';

  @override
  String get pantomimaRundaUput =>
      'Zadanu riječ treba objasniti pantomimom. Traje 75 sekundi.';

  @override
  String get rezultatUput =>
      'Rezultat se zbraja kroz runde, tim s najviše bodova je pobjednički.';

  @override
  String get odustajanjeUput =>
      'Ako ne možete objasniti riječ, možete odustati od objašnjavanja i prenijeti dosad osvojene bodove.';

  @override
  String get napomena => 'Napomena';

  @override
  String get napomenaTekst =>
      'U novu rundu se ne prelazi dok se ne pogode sve riječi iz trenutne runde!';

  @override
  String get unesiteImeIgraca => 'Unesite ime igrača!';

  @override
  String get daLiSteSigurniIzlaz =>
      'Jeste li sigurni da želite izaći? Morat ćete krenuti igru ispočetka!';

  @override
  String get poeni => 'Bodovi';

  @override
  String get odustani => 'Odustani';

  @override
  String get odustajete => 'Odustajete?';

  @override
  String get odustaniAlertContent =>
      'Ako odustanete, prenosite bodove i na redu je sljedeći tim.';

  @override
  String get sledecaRec => 'Sljedeća riječ';

  @override
  String get sledeciTim => 'Sljedeći tim';

  @override
  String get start => 'Start';

  @override
  String get da => 'Da';

  @override
  String get ne => 'Ne';

  @override
  String get rezultat => 'Rezultat';

  @override
  String get sledeciIgraTim => 'Sljedeći igraju';

  @override
  String get krajIgre => 'Kraj igre';

  @override
  String get pobednikJeTim => 'Pobjednici su';

  @override
  String get novaIgra => 'Nova igra';

  @override
  String get pogodjeneSveReci =>
      'Pogodili ste sve riječi!\n Prijeđite na sljedeću rundu';

  @override
  String get izaberiMod => 'Odaberi mod igre';

  @override
  String get normalan => 'Normalan';

  @override
  String get brzi => 'Brzi';

  @override
  String get dupliPoeni => 'Dupli bodovi';

  @override
  String get dvaPoena => '2 boda';

  @override
  String get objasni => 'Objasni';

  @override
  String get dupliPoeniObjasnjenje =>
      'Riječi pogođene u posljednjih nekoliko sekundi runde donose 2 boda umjesto 1!\n\nNormalan mod:\n• Normalna i Jedna riječ runda: posljednjih 10 sekundi\n• Pantomima runda: posljednjih 15 sekundi\n\nBrzi mod:\n• Normalna i Jedna riječ runda: posljednjih 7 sekundi\n• Pantomima runda: posljednjih 10 sekundi';

  @override
  String get imeTima => 'Ime tima';

  @override
  String get unesiteImeTima => 'Unesite ime tima!';

  @override
  String get prikupiReci => 'Prikupi riječi';

  @override
  String get skenirajDaDodas => 'Skeniraj da dodaš riječi';

  @override
  String get kodSesije => 'Kod sesije';

  @override
  String get dodatoReci => 'Dodano riječi';

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
  String get cekanjeNaReci => 'ČEKANJE NA RIJEČI...';

  @override
  String potrebnoJosReci(Object count) {
    return 'Potrebno još $count riječi';
  }

  @override
  String get greskaKreiranjaSesije => 'Greška pri kreiranju sesije';

  @override
  String get koristiSvojeReci => 'Koristi svoje riječi';

  @override
  String get izaberiReci => 'Odaberi riječi';

  @override
  String get kakoZeliteDaIgrate => 'Kako želiš igrati?';

  @override
  String get koristiReciIzAplikacije => 'Koristi riječi iz aplikacije';

  @override
  String get viseOdReciSpremno => 'Više od 1500 unaprijed pripremljenih riječi';

  @override
  String get svakiIgracDodaje =>
      'Svaki igrač dodaje 8 riječi skeniranjem QR koda';

  @override
  String get dodajMojeReci => 'Dodaj moje riječi';

  @override
  String get jedanNaJedan => '1v1';

  @override
  String get jedanNaJedanOpis => 'Dva igrača, jedan objašnjava, drugi pogađa';

  @override
  String get imeIgraca1 => 'Ime prvog igrača';

  @override
  String get imeIgraca2 => 'Ime drugog igrača';

  @override
  String objasnjava(String name) {
    return '$name objašnjava';
  }

  @override
  String pobednik(String name) {
    return '$name pobjeđuje!';
  }

  @override
  String get nereseno => 'Neriješeno!';

  @override
  String pobedaZaReci(int count) {
    return 'Pobjeda za $count riječi';
  }

  @override
  String igraciPoeni(String name, int points) {
    return '$name: $points bodova';
  }

  @override
  String get sledeciIgrac => 'Sljedeći igrač';

  @override
  String get jedanNaJedanUput =>
      'Dva igrača natječu se jedan protiv drugoga. Igrači naizmjence objašnjavaju riječi dok protivnik pogađa. Pobjednik je igrač koji objasni više riječi.';

  @override
  String get igrajPonovo => 'Igraj ponovno';

  @override
  String get proNaslov => 'Asocijacije Pro';

  @override
  String get proPodnaslov => 'Jednokratna kupnja - tvoje zauvijek';

  @override
  String get proPogodnostSvojeReci => 'Igraj sa svojim riječima';

  @override
  String get proPogodnostQr =>
      'Svatko dodaje riječi sa svog telefona preko QR koda';

  @override
  String get proPogodnostBuduce => 'Sve buduće Pro opcije uključene';

  @override
  String otkljucajZa(String price) {
    return 'Otključaj za $price';
  }

  @override
  String get otkljucaj => 'Otključaj';

  @override
  String get vratiKupovinu => 'Vrati kupnju';

  @override
  String get kupovinaVracena => 'Kupnja je vraćena!';

  @override
  String get kupovinaNijeNadjena => 'Prethodna kupnja nije pronađena.';

  @override
  String get kupovinaNeuspesna => 'Kupnja nije uspjela. Pokušaj ponovno.';

  @override
  String get prodavnicaNijeDostupna =>
      'Trgovina trenutno nije dostupna. Pokušaj kasnije.';
}
