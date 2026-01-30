import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_sr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('sr'),
  ];

  /// No description provided for @language.
  ///
  /// In sr, this message translates to:
  /// **'Srpski'**
  String get language;

  /// No description provided for @asocijacije.
  ///
  /// In sr, this message translates to:
  /// **'Asocijacije'**
  String get asocijacije;

  /// No description provided for @saPapiricaUApp.
  ///
  /// In sr, this message translates to:
  /// **'sa papirića u aplikaciju!'**
  String get saPapiricaUApp;

  /// No description provided for @pocniIgru.
  ///
  /// In sr, this message translates to:
  /// **'Počni igru'**
  String get pocniIgru;

  /// No description provided for @uputstvaZaIgru.
  ///
  /// In sr, this message translates to:
  /// **'Uputstva za igru'**
  String get uputstvaZaIgru;

  /// No description provided for @izlaz.
  ///
  /// In sr, this message translates to:
  /// **'Izlaz'**
  String get izlaz;

  /// No description provided for @ime1Igraca.
  ///
  /// In sr, this message translates to:
  /// **'Ime 1.igrača'**
  String get ime1Igraca;

  /// No description provided for @ime2Igraca.
  ///
  /// In sr, this message translates to:
  /// **'Ime 2.igrača'**
  String get ime2Igraca;

  /// No description provided for @igraca.
  ///
  /// In sr, this message translates to:
  /// **'igrača'**
  String get igraca;

  /// No description provided for @dalje.
  ///
  /// In sr, this message translates to:
  /// **'Dalje'**
  String get dalje;

  /// No description provided for @nazad.
  ///
  /// In sr, this message translates to:
  /// **'Nazad'**
  String get nazad;

  /// No description provided for @tim.
  ///
  /// In sr, this message translates to:
  /// **'Tim'**
  String get tim;

  /// No description provided for @normalnaRunda.
  ///
  /// In sr, this message translates to:
  /// **'Normalna Runda'**
  String get normalnaRunda;

  /// No description provided for @normalnaRundaUput.
  ///
  /// In sr, this message translates to:
  /// **'Treba objasniti zadatu reč bez korišćenja iste, ili korena iste. Traje 45 sekundi.'**
  String get normalnaRundaUput;

  /// No description provided for @jednaRecRunda.
  ///
  /// In sr, this message translates to:
  /// **'Jedna reč Runda'**
  String get jednaRecRunda;

  /// No description provided for @jednaRecRundaUput.
  ///
  /// In sr, this message translates to:
  /// **'Treba objasniti zadatu reč korišćenjem samo jedne reči koja je slična zadatoj, ili će asocirati na zadatu reč. Traje 45 sekundi.'**
  String get jednaRecRundaUput;

  /// No description provided for @pantomimaRunda.
  ///
  /// In sr, this message translates to:
  /// **'Pantomima Runda'**
  String get pantomimaRunda;

  /// No description provided for @pantomimaRundaUput.
  ///
  /// In sr, this message translates to:
  /// **'Treba objasniti zadatu reč pantomimom. Traje 60 sekundi.'**
  String get pantomimaRundaUput;

  /// No description provided for @rezultatUput.
  ///
  /// In sr, this message translates to:
  /// **'Rezultat se sabira kroz runde, tim sa najviše poena je pobednički.'**
  String get rezultatUput;

  /// No description provided for @odustajanjeUput.
  ///
  /// In sr, this message translates to:
  /// **'Ukoliko ne možete da objasnite reč, možete odustati od objašnjavanja i preneti do sad osvojene bodove.'**
  String get odustajanjeUput;

  /// No description provided for @napomena.
  ///
  /// In sr, this message translates to:
  /// **'Napomena'**
  String get napomena;

  /// No description provided for @napomenaTekst.
  ///
  /// In sr, this message translates to:
  /// **'U novu rundu se ne prelazi dok se ne pogode sve reči iz trenutne runde!'**
  String get napomenaTekst;

  /// No description provided for @unesiteImeIgraca.
  ///
  /// In sr, this message translates to:
  /// **'Unesite ime igrača!'**
  String get unesiteImeIgraca;

  /// No description provided for @daLiSteSigurniIzlaz.
  ///
  /// In sr, this message translates to:
  /// **'Da li ste sigurni da želite da izađete? Moraćete da krenete igru iz početka!'**
  String get daLiSteSigurniIzlaz;

  /// No description provided for @poeni.
  ///
  /// In sr, this message translates to:
  /// **'Poeni'**
  String get poeni;

  /// No description provided for @odustani.
  ///
  /// In sr, this message translates to:
  /// **'Odustani'**
  String get odustani;

  /// No description provided for @odustajete.
  ///
  /// In sr, this message translates to:
  /// **'Odustajete?'**
  String get odustajete;

  /// No description provided for @odustaniAlertContent.
  ///
  /// In sr, this message translates to:
  /// **'Ako odustanete, prenosite bodove i na redu je sledeći tim.'**
  String get odustaniAlertContent;

  /// No description provided for @sledecaRec.
  ///
  /// In sr, this message translates to:
  /// **'Sledeća reč'**
  String get sledecaRec;

  /// No description provided for @sledeciTim.
  ///
  /// In sr, this message translates to:
  /// **'Sledeći tim'**
  String get sledeciTim;

  /// No description provided for @start.
  ///
  /// In sr, this message translates to:
  /// **'Start'**
  String get start;

  /// No description provided for @da.
  ///
  /// In sr, this message translates to:
  /// **'Da'**
  String get da;

  /// No description provided for @ne.
  ///
  /// In sr, this message translates to:
  /// **'Ne'**
  String get ne;

  /// No description provided for @rezultat.
  ///
  /// In sr, this message translates to:
  /// **'Rezultat'**
  String get rezultat;

  /// No description provided for @sledeciIgraTim.
  ///
  /// In sr, this message translates to:
  /// **'Sledeći igraju'**
  String get sledeciIgraTim;

  /// No description provided for @krajIgre.
  ///
  /// In sr, this message translates to:
  /// **'Kraj igre'**
  String get krajIgre;

  /// No description provided for @pobednikJeTim.
  ///
  /// In sr, this message translates to:
  /// **'Pobednici su'**
  String get pobednikJeTim;

  /// No description provided for @novaIgra.
  ///
  /// In sr, this message translates to:
  /// **'Nova igra'**
  String get novaIgra;

  /// No description provided for @pogodjeneSveReci.
  ///
  /// In sr, this message translates to:
  /// **'Pogodili ste sve reči!\n Pređite na sledeću rundu'**
  String get pogodjeneSveReci;

  /// No description provided for @izaberiMod.
  ///
  /// In sr, this message translates to:
  /// **'Izaberi mod igre'**
  String get izaberiMod;

  /// No description provided for @normalan.
  ///
  /// In sr, this message translates to:
  /// **'Normalan'**
  String get normalan;

  /// No description provided for @brzi.
  ///
  /// In sr, this message translates to:
  /// **'Brzi'**
  String get brzi;

  /// No description provided for @dupliPoeni.
  ///
  /// In sr, this message translates to:
  /// **'Dupli poeni'**
  String get dupliPoeni;

  /// No description provided for @dvaPoena.
  ///
  /// In sr, this message translates to:
  /// **'2 poena'**
  String get dvaPoena;

  /// No description provided for @dupliPoeniObjasnjenje.
  ///
  /// In sr, this message translates to:
  /// **'Reči pogođene u poslednjih nekoliko sekundi runde donose 2 poena umesto 1!\n\nNormalan mod:\n• Normalna i Jedna reč runda: poslednjih 10 sekundi\n• Pantomima runda: poslednjih 15 sekundi\n\nBrzi mod:\n• Normalna i Jedna reč runda: poslednjih 7 sekundi\n• Pantomima runda: poslednjih 10 sekundi'**
  String get dupliPoeniObjasnjenje;

  /// No description provided for @imeTima.
  ///
  /// In sr, this message translates to:
  /// **'Ime tima'**
  String get imeTima;

  /// No description provided for @unesiteImeTima.
  ///
  /// In sr, this message translates to:
  /// **'Unesite ime tima!'**
  String get unesiteImeTima;

  /// No description provided for @prikupiReci.
  ///
  /// In sr, this message translates to:
  /// **'Prikupi reči'**
  String get prikupiReci;

  /// No description provided for @skenirajDaDodas.
  ///
  /// In sr, this message translates to:
  /// **'Skeniraj da dodaš reči'**
  String get skenirajDaDodas;

  /// No description provided for @kodSesije.
  ///
  /// In sr, this message translates to:
  /// **'Kod sesije'**
  String get kodSesije;

  /// No description provided for @napredak.
  ///
  /// In sr, this message translates to:
  /// **'Napredak'**
  String get napredak;

  /// No description provided for @igracaSpremo.
  ///
  /// In sr, this message translates to:
  /// **'{ready} od {total} igrača spremno'**
  String igracaSpremo(Object ready, Object total);

  /// No description provided for @igraci.
  ///
  /// In sr, this message translates to:
  /// **'Igrači'**
  String get igraci;

  /// No description provided for @igrac.
  ///
  /// In sr, this message translates to:
  /// **'Igrač'**
  String get igrac;

  /// No description provided for @pocniIgruBtn.
  ///
  /// In sr, this message translates to:
  /// **'POČNI IGRU ✓'**
  String get pocniIgruBtn;

  /// No description provided for @cekanjeNaReci.
  ///
  /// In sr, this message translates to:
  /// **'ČEKANJE NA REČI...'**
  String get cekanjeNaReci;

  /// No description provided for @potrebnoJosReci.
  ///
  /// In sr, this message translates to:
  /// **'Potrebno još {count} reči'**
  String potrebnoJosReci(Object count);

  /// No description provided for @greskaKreiranjaSesije.
  ///
  /// In sr, this message translates to:
  /// **'Greška pri kreiranju sesije'**
  String get greskaKreiranjaSesije;

  /// No description provided for @koristiSvojeReci.
  ///
  /// In sr, this message translates to:
  /// **'Koristi svoje reči'**
  String get koristiSvojeReci;

  /// No description provided for @izaberiReci.
  ///
  /// In sr, this message translates to:
  /// **'Izaberi reči'**
  String get izaberiReci;

  /// No description provided for @kakoZeliteDaIgrate.
  ///
  /// In sr, this message translates to:
  /// **'Kako želiš da igraš?'**
  String get kakoZeliteDaIgrate;

  /// No description provided for @koristiReciIzAplikacije.
  ///
  /// In sr, this message translates to:
  /// **'Koristi reči iz aplikacije'**
  String get koristiReciIzAplikacije;

  /// No description provided for @viseOdReciSpremno.
  ///
  /// In sr, this message translates to:
  /// **'Više od 1500 unapred pripremljenih reči'**
  String get viseOdReciSpremno;

  /// No description provided for @svakiIgracDodaje.
  ///
  /// In sr, this message translates to:
  /// **'Svaki igrač dodaje 8 reči skeniranjem QR koda'**
  String get svakiIgracDodaje;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'sr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'sr':
      return AppLocalizationsSr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
