// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'HyperFocus';

  @override
  String get whatsOverwhelming => 'Was ueberwaeltigt dich?';

  @override
  String get homeSubtitle =>
      'Waehle eine Aufgabe und wir zerlegen sie in kleine Schritte.';

  @override
  String get searchHint => 'Aufgaben suchen...';

  @override
  String get pickCategory => 'Waehle eine Kategorie';

  @override
  String get tasks => 'Aufgaben';

  @override
  String get steps => 'Schritte';

  @override
  String get categoryCleaning => 'Putzen';

  @override
  String get categorySelfCare => 'Selbstfuersorge';

  @override
  String get categoryAdmin => 'Verwaltung';

  @override
  String get categoryWork => 'Arbeit';

  @override
  String get categoryCooking => 'Kochen';

  @override
  String get categorySocial => 'Soziales';

  @override
  String get createCustomTask => 'Eigene Aufgabe erstellen';

  @override
  String get noResultsFound => 'Keine Ergebnisse gefunden';

  @override
  String get errorLoading => 'Etwas ist schiefgelaufen';

  @override
  String stepOf(int current, int total) {
    return 'Schritt $current von $total';
  }

  @override
  String get done => 'FERTIG';

  @override
  String get skipThisStep => 'Diesen Schritt ueberspringen';

  @override
  String get abandonTask => 'Aufgabe verlassen?';

  @override
  String get abandonTaskConfirm =>
      'Kein Problem — du kannst jederzeit zurueckkommen.';

  @override
  String get keepGoing => 'Weitermachen';

  @override
  String get yesAbandon => 'Ja, verlassen';

  @override
  String get letsDoThis => 'Los geht\'s!';

  @override
  String get readyToStart => 'Schritt fuer Schritt. Du schaffst das.';

  @override
  String estimatedTime(int minutes) {
    return '~$minutes Min.';
  }

  @override
  String get youDidIt => 'Geschafft!';

  @override
  String completedStepsCount(int count) {
    return '$count Schritte erledigt';
  }

  @override
  String timeTaken(int minutes) {
    return '$minutes Minuten';
  }

  @override
  String get backToHome => 'Zurueck zur Startseite';

  @override
  String get encouragement1 =>
      'Jeder kleine Schritt zaehlt. Du hast heute etwas geschafft.';

  @override
  String get encouragement2 => 'Schau dich an, du erledigst Sachen!';

  @override
  String get encouragement3 => 'War doch gar nicht so schlimm, oder?';

  @override
  String get encouragement4 =>
      'Eine Aufgabe nach der anderen. Du machst das toll.';

  @override
  String get encouragement5 => 'Fortschritt, nicht Perfektion. Gut gemacht!';

  @override
  String get history => 'Verlauf';

  @override
  String get noHistory => 'Noch keine erledigten Aufgaben';

  @override
  String get clearAll => 'Alles loeschen';

  @override
  String get clearAllHistory => 'Gesamten Verlauf loeschen?';

  @override
  String get clearAllHistoryConfirm =>
      'Alle erledigten Aufgaben werden entfernt. Das kann nicht rueckgaengig gemacht werden.';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get historyPremiumOnly => 'Verlauf ist eine Premium-Funktion';

  @override
  String get settings => 'Einstellungen';

  @override
  String get timerSettings => 'Timer';

  @override
  String get enableTimer => 'Schritt-Timer';

  @override
  String get enableTimerDescription =>
      'Countdown-Timer fuer jeden Schritt anzeigen';

  @override
  String get defaultStepDuration => 'Standard-Schrittdauer';

  @override
  String get minutes => 'Minuten';

  @override
  String get timeBlindness => 'Zeitblindheit';

  @override
  String get timeBlindnessChime => 'Zeitbewusstseins-Signal';

  @override
  String get chimeEvery => 'Erinnere mich alle';

  @override
  String minutesShort(int minutes) {
    return '$minutes Min.';
  }

  @override
  String get chimePremiumOnly =>
      'Zeitblindheits-Signale sind eine Premium-Funktion';

  @override
  String get soundSettings => 'Ton';

  @override
  String get enableSound => 'Soundeffekte';

  @override
  String get enableSoundDescription => 'Signaltoene und Feier-Sounds';

  @override
  String get premium => 'Premium';

  @override
  String get premiumActive => 'Premium aktiv';

  @override
  String get upgradePremium => 'Auf Premium upgraden';

  @override
  String get premiumRequired => 'Premium erforderlich';

  @override
  String get premiumDescription =>
      'Schalte 300+ Aufgabenvorlagen, Zeitblindheits-Audio und Aufgabenverlauf frei.';

  @override
  String get premiumFeatures =>
      '300+ Vorlagen, Zeitblindheits-Signale, Aufgabenverlauf und keine Werbung.';

  @override
  String buyPremium(double price) {
    final intl.NumberFormat priceNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String priceString = priceNumberFormat.format(price);

    return 'Premium holen — $priceString EUR';
  }

  @override
  String get restorePurchases => 'Kaeufe wiederherstellen';

  @override
  String get maybeLater => 'Vielleicht spaeter';

  @override
  String get about => 'Ueber';

  @override
  String get version => 'Version';

  @override
  String get publisher => 'Herausgeber';

  @override
  String get contact => 'Kontakt';

  @override
  String get taskTitle => 'Aufgabentitel';

  @override
  String get taskTitleHint => 'z.B. Badezimmer putzen';

  @override
  String get category => 'Kategorie';

  @override
  String get microSteps => 'Mini-Schritte';

  @override
  String get microStepsHint => 'Zerlege es in die kleinstmoeglichen Schritte';

  @override
  String get addStep => 'Schritt hinzufuegen';

  @override
  String get stepHint => 'z.B. Aufstehen';

  @override
  String get save => 'Speichern';

  @override
  String get pleaseEnterTitle => 'Bitte gib einen Aufgabentitel ein';

  @override
  String get pleaseAddSteps => 'Bitte fuege mindestens einen Schritt hinzu';

  @override
  String get noTemplatesInCategory => 'Noch keine Vorlagen in dieser Kategorie';

  @override
  String get pauseTimer => 'Pause';

  @override
  String get resumeTimer => 'Fortfahren';

  @override
  String get quickStart => 'Schnellstart';

  @override
  String get quickStartDescription => 'Nutze unsere 3-Schritte-Vorlage';

  @override
  String get orAddYourOwn => 'Oder fuege eigene Schritte hinzu';
}
