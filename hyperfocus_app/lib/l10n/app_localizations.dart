import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_uk.dart';

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
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('uk'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'HyperFocus'**
  String get appTitle;

  /// No description provided for @whatsOverwhelming.
  ///
  /// In en, this message translates to:
  /// **'What\'s overwhelming you?'**
  String get whatsOverwhelming;

  /// No description provided for @homeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Pick a task and we\'ll break it into tiny steps.'**
  String get homeSubtitle;

  /// No description provided for @searchHint.
  ///
  /// In en, this message translates to:
  /// **'Search tasks...'**
  String get searchHint;

  /// No description provided for @pickCategory.
  ///
  /// In en, this message translates to:
  /// **'Pick a category'**
  String get pickCategory;

  /// No description provided for @tasks.
  ///
  /// In en, this message translates to:
  /// **'tasks'**
  String get tasks;

  /// No description provided for @steps.
  ///
  /// In en, this message translates to:
  /// **'steps'**
  String get steps;

  /// No description provided for @categoryCleaning.
  ///
  /// In en, this message translates to:
  /// **'Cleaning'**
  String get categoryCleaning;

  /// No description provided for @categorySelfCare.
  ///
  /// In en, this message translates to:
  /// **'Self Care'**
  String get categorySelfCare;

  /// No description provided for @categoryAdmin.
  ///
  /// In en, this message translates to:
  /// **'Admin'**
  String get categoryAdmin;

  /// No description provided for @categoryWork.
  ///
  /// In en, this message translates to:
  /// **'Work'**
  String get categoryWork;

  /// No description provided for @categoryCooking.
  ///
  /// In en, this message translates to:
  /// **'Cooking'**
  String get categoryCooking;

  /// No description provided for @categorySocial.
  ///
  /// In en, this message translates to:
  /// **'Social'**
  String get categorySocial;

  /// No description provided for @createCustomTask.
  ///
  /// In en, this message translates to:
  /// **'Create your own task'**
  String get createCustomTask;

  /// No description provided for @noResultsFound.
  ///
  /// In en, this message translates to:
  /// **'No results found'**
  String get noResultsFound;

  /// No description provided for @errorLoading.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get errorLoading;

  /// No description provided for @stepOf.
  ///
  /// In en, this message translates to:
  /// **'Step {current} of {total}'**
  String stepOf(int current, int total);

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'DONE'**
  String get done;

  /// No description provided for @skipThisStep.
  ///
  /// In en, this message translates to:
  /// **'Skip this step'**
  String get skipThisStep;

  /// No description provided for @abandonTask.
  ///
  /// In en, this message translates to:
  /// **'Leave task?'**
  String get abandonTask;

  /// No description provided for @abandonTaskConfirm.
  ///
  /// In en, this message translates to:
  /// **'No worries — you can always come back to it later.'**
  String get abandonTaskConfirm;

  /// No description provided for @keepGoing.
  ///
  /// In en, this message translates to:
  /// **'Keep going'**
  String get keepGoing;

  /// No description provided for @yesAbandon.
  ///
  /// In en, this message translates to:
  /// **'Yes, leave'**
  String get yesAbandon;

  /// No description provided for @letsDoThis.
  ///
  /// In en, this message translates to:
  /// **'Let\'s do this!'**
  String get letsDoThis;

  /// No description provided for @readyToStart.
  ///
  /// In en, this message translates to:
  /// **'One step at a time. You\'ve got this.'**
  String get readyToStart;

  /// No description provided for @estimatedTime.
  ///
  /// In en, this message translates to:
  /// **'~{minutes} min'**
  String estimatedTime(int minutes);

  /// No description provided for @youDidIt.
  ///
  /// In en, this message translates to:
  /// **'You did it!'**
  String get youDidIt;

  /// No description provided for @completedStepsCount.
  ///
  /// In en, this message translates to:
  /// **'{count} steps completed'**
  String completedStepsCount(int count);

  /// No description provided for @timeTaken.
  ///
  /// In en, this message translates to:
  /// **'{minutes} minutes'**
  String timeTaken(int minutes);

  /// No description provided for @backToHome.
  ///
  /// In en, this message translates to:
  /// **'Back to home'**
  String get backToHome;

  /// No description provided for @encouragement1.
  ///
  /// In en, this message translates to:
  /// **'Every small step counts. You showed up today.'**
  String get encouragement1;

  /// No description provided for @encouragement2.
  ///
  /// In en, this message translates to:
  /// **'Look at you, getting things done!'**
  String get encouragement2;

  /// No description provided for @encouragement3.
  ///
  /// In en, this message translates to:
  /// **'That wasn\'t so bad, was it?'**
  String get encouragement3;

  /// No description provided for @encouragement4.
  ///
  /// In en, this message translates to:
  /// **'One task at a time. You\'re doing great.'**
  String get encouragement4;

  /// No description provided for @encouragement5.
  ///
  /// In en, this message translates to:
  /// **'Progress, not perfection. Well done!'**
  String get encouragement5;

  /// No description provided for @history.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get history;

  /// No description provided for @noHistory.
  ///
  /// In en, this message translates to:
  /// **'No completed tasks yet'**
  String get noHistory;

  /// No description provided for @clearAll.
  ///
  /// In en, this message translates to:
  /// **'Clear all'**
  String get clearAll;

  /// No description provided for @clearAllHistory.
  ///
  /// In en, this message translates to:
  /// **'Clear all history?'**
  String get clearAllHistory;

  /// No description provided for @clearAllHistoryConfirm.
  ///
  /// In en, this message translates to:
  /// **'This will remove all your completed task records. This cannot be undone.'**
  String get clearAllHistoryConfirm;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @historyPremiumOnly.
  ///
  /// In en, this message translates to:
  /// **'History is a premium feature'**
  String get historyPremiumOnly;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @timerSettings.
  ///
  /// In en, this message translates to:
  /// **'Timer'**
  String get timerSettings;

  /// No description provided for @enableTimer.
  ///
  /// In en, this message translates to:
  /// **'Step timer'**
  String get enableTimer;

  /// No description provided for @enableTimerDescription.
  ///
  /// In en, this message translates to:
  /// **'Show a countdown timer for each step'**
  String get enableTimerDescription;

  /// No description provided for @defaultStepDuration.
  ///
  /// In en, this message translates to:
  /// **'Default step duration'**
  String get defaultStepDuration;

  /// No description provided for @minutes.
  ///
  /// In en, this message translates to:
  /// **'minutes'**
  String get minutes;

  /// No description provided for @timeBlindness.
  ///
  /// In en, this message translates to:
  /// **'Time-blindness'**
  String get timeBlindness;

  /// No description provided for @timeBlindnessChime.
  ///
  /// In en, this message translates to:
  /// **'Time awareness chime'**
  String get timeBlindnessChime;

  /// No description provided for @chimeEvery.
  ///
  /// In en, this message translates to:
  /// **'Remind me every'**
  String get chimeEvery;

  /// No description provided for @minutesShort.
  ///
  /// In en, this message translates to:
  /// **'{minutes} min'**
  String minutesShort(int minutes);

  /// No description provided for @chimePremiumOnly.
  ///
  /// In en, this message translates to:
  /// **'Time-blindness chimes are a premium feature'**
  String get chimePremiumOnly;

  /// No description provided for @soundSettings.
  ///
  /// In en, this message translates to:
  /// **'Sound'**
  String get soundSettings;

  /// No description provided for @enableSound.
  ///
  /// In en, this message translates to:
  /// **'Sound effects'**
  String get enableSound;

  /// No description provided for @enableSoundDescription.
  ///
  /// In en, this message translates to:
  /// **'Chimes and celebration sounds'**
  String get enableSoundDescription;

  /// No description provided for @premium.
  ///
  /// In en, this message translates to:
  /// **'Premium'**
  String get premium;

  /// No description provided for @premiumActive.
  ///
  /// In en, this message translates to:
  /// **'Premium active'**
  String get premiumActive;

  /// No description provided for @upgradePremium.
  ///
  /// In en, this message translates to:
  /// **'Upgrade to Premium'**
  String get upgradePremium;

  /// No description provided for @premiumRequired.
  ///
  /// In en, this message translates to:
  /// **'Premium required'**
  String get premiumRequired;

  /// No description provided for @premiumDescription.
  ///
  /// In en, this message translates to:
  /// **'Unlock 300+ task templates, time-blindness audio, and task history.'**
  String get premiumDescription;

  /// No description provided for @premiumFeatures.
  ///
  /// In en, this message translates to:
  /// **'300+ templates, time-blindness chimes, task history, and no ads.'**
  String get premiumFeatures;

  /// No description provided for @buyPremium.
  ///
  /// In en, this message translates to:
  /// **'Get Premium — \${price}'**
  String buyPremium(double price);

  /// No description provided for @restorePurchases.
  ///
  /// In en, this message translates to:
  /// **'Restore purchases'**
  String get restorePurchases;

  /// No description provided for @maybeLater.
  ///
  /// In en, this message translates to:
  /// **'Maybe later'**
  String get maybeLater;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// No description provided for @version.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get version;

  /// No description provided for @publisher.
  ///
  /// In en, this message translates to:
  /// **'Publisher'**
  String get publisher;

  /// No description provided for @contact.
  ///
  /// In en, this message translates to:
  /// **'Contact'**
  String get contact;

  /// No description provided for @taskTitle.
  ///
  /// In en, this message translates to:
  /// **'Task title'**
  String get taskTitle;

  /// No description provided for @taskTitleHint.
  ///
  /// In en, this message translates to:
  /// **'e.g., Clean the bathroom'**
  String get taskTitleHint;

  /// No description provided for @category.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get category;

  /// No description provided for @microSteps.
  ///
  /// In en, this message translates to:
  /// **'Micro-steps'**
  String get microSteps;

  /// No description provided for @microStepsHint.
  ///
  /// In en, this message translates to:
  /// **'Break it down into the smallest possible steps'**
  String get microStepsHint;

  /// No description provided for @addStep.
  ///
  /// In en, this message translates to:
  /// **'Add step'**
  String get addStep;

  /// No description provided for @stepHint.
  ///
  /// In en, this message translates to:
  /// **'e.g., Stand up'**
  String get stepHint;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @pleaseEnterTitle.
  ///
  /// In en, this message translates to:
  /// **'Please enter a task title'**
  String get pleaseEnterTitle;

  /// No description provided for @pleaseAddSteps.
  ///
  /// In en, this message translates to:
  /// **'Please add at least one step'**
  String get pleaseAddSteps;

  /// No description provided for @noTemplatesInCategory.
  ///
  /// In en, this message translates to:
  /// **'No templates in this category yet'**
  String get noTemplatesInCategory;

  /// No description provided for @pauseTimer.
  ///
  /// In en, this message translates to:
  /// **'Pause'**
  String get pauseTimer;

  /// No description provided for @resumeTimer.
  ///
  /// In en, this message translates to:
  /// **'Resume'**
  String get resumeTimer;

  /// No description provided for @quickStart.
  ///
  /// In en, this message translates to:
  /// **'Quick Start'**
  String get quickStart;

  /// No description provided for @quickStartDescription.
  ///
  /// In en, this message translates to:
  /// **'Use our 3-step Getting Started template'**
  String get quickStartDescription;

  /// No description provided for @orAddYourOwn.
  ///
  /// In en, this message translates to:
  /// **'Or add your own steps below'**
  String get orAddYourOwn;
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
      <String>['de', 'en', 'es', 'uk'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'uk':
      return AppLocalizationsUk();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
