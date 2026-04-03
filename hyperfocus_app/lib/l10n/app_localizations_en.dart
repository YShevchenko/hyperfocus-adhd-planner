// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'HyperFocus';

  @override
  String get whatsOverwhelming => 'What\'s overwhelming you?';

  @override
  String get homeSubtitle => 'Pick a task and we\'ll break it into tiny steps.';

  @override
  String get searchHint => 'Search tasks...';

  @override
  String get pickCategory => 'Pick a category';

  @override
  String get tasks => 'tasks';

  @override
  String get steps => 'steps';

  @override
  String get categoryCleaning => 'Cleaning';

  @override
  String get categorySelfCare => 'Self Care';

  @override
  String get categoryAdmin => 'Admin';

  @override
  String get categoryWork => 'Work';

  @override
  String get categoryCooking => 'Cooking';

  @override
  String get categorySocial => 'Social';

  @override
  String get createCustomTask => 'Create your own task';

  @override
  String get noResultsFound => 'No results found';

  @override
  String get errorLoading => 'Something went wrong';

  @override
  String stepOf(int current, int total) {
    return 'Step $current of $total';
  }

  @override
  String get done => 'DONE';

  @override
  String get skipThisStep => 'Skip this step';

  @override
  String get abandonTask => 'Leave task?';

  @override
  String get abandonTaskConfirm =>
      'No worries — you can always come back to it later.';

  @override
  String get keepGoing => 'Keep going';

  @override
  String get yesAbandon => 'Yes, leave';

  @override
  String get letsDoThis => 'Let\'s do this!';

  @override
  String get readyToStart => 'One step at a time. You\'ve got this.';

  @override
  String estimatedTime(int minutes) {
    return '~$minutes min';
  }

  @override
  String get youDidIt => 'You did it!';

  @override
  String completedStepsCount(int count) {
    return '$count steps completed';
  }

  @override
  String timeTaken(int minutes) {
    return '$minutes minutes';
  }

  @override
  String get backToHome => 'Back to home';

  @override
  String get encouragement1 => 'Every small step counts. You showed up today.';

  @override
  String get encouragement2 => 'Look at you, getting things done!';

  @override
  String get encouragement3 => 'That wasn\'t so bad, was it?';

  @override
  String get encouragement4 => 'One task at a time. You\'re doing great.';

  @override
  String get encouragement5 => 'Progress, not perfection. Well done!';

  @override
  String get history => 'History';

  @override
  String get noHistory => 'No completed tasks yet';

  @override
  String get clearAll => 'Clear all';

  @override
  String get clearAllHistory => 'Clear all history?';

  @override
  String get clearAllHistoryConfirm =>
      'This will remove all your completed task records. This cannot be undone.';

  @override
  String get cancel => 'Cancel';

  @override
  String get historyPremiumOnly => 'History is a premium feature';

  @override
  String get settings => 'Settings';

  @override
  String get timerSettings => 'Timer';

  @override
  String get enableTimer => 'Step timer';

  @override
  String get enableTimerDescription => 'Show a countdown timer for each step';

  @override
  String get defaultStepDuration => 'Default step duration';

  @override
  String get minutes => 'minutes';

  @override
  String get timeBlindness => 'Time-blindness';

  @override
  String get timeBlindnessChime => 'Time awareness chime';

  @override
  String get chimeEvery => 'Remind me every';

  @override
  String minutesShort(int minutes) {
    return '$minutes min';
  }

  @override
  String get chimePremiumOnly => 'Time-blindness chimes are a premium feature';

  @override
  String get soundSettings => 'Sound';

  @override
  String get enableSound => 'Sound effects';

  @override
  String get enableSoundDescription => 'Chimes and celebration sounds';

  @override
  String get premium => 'Premium';

  @override
  String get premiumActive => 'Premium active';

  @override
  String get upgradePremium => 'Upgrade to Premium';

  @override
  String get premiumRequired => 'Premium required';

  @override
  String get premiumDescription =>
      'Unlock 300+ task templates, time-blindness audio, and task history.';

  @override
  String get premiumFeatures =>
      '300+ templates, time-blindness chimes, task history, and no ads.';

  @override
  String buyPremium(double price) {
    final intl.NumberFormat priceNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String priceString = priceNumberFormat.format(price);

    return 'Get Premium — \$$priceString';
  }

  @override
  String get restorePurchases => 'Restore purchases';

  @override
  String get maybeLater => 'Maybe later';

  @override
  String get about => 'About';

  @override
  String get version => 'Version';

  @override
  String get publisher => 'Publisher';

  @override
  String get contact => 'Contact';

  @override
  String get taskTitle => 'Task title';

  @override
  String get taskTitleHint => 'e.g., Clean the bathroom';

  @override
  String get category => 'Category';

  @override
  String get microSteps => 'Micro-steps';

  @override
  String get microStepsHint => 'Break it down into the smallest possible steps';

  @override
  String get addStep => 'Add step';

  @override
  String get stepHint => 'e.g., Stand up';

  @override
  String get save => 'Save';

  @override
  String get pleaseEnterTitle => 'Please enter a task title';

  @override
  String get pleaseAddSteps => 'Please add at least one step';

  @override
  String get noTemplatesInCategory => 'No templates in this category yet';

  @override
  String get pauseTimer => 'Pause';

  @override
  String get resumeTimer => 'Resume';

  @override
  String get quickStart => 'Quick Start';

  @override
  String get quickStartDescription => 'Use our 3-step Getting Started template';

  @override
  String get orAddYourOwn => 'Or add your own steps below';
}
