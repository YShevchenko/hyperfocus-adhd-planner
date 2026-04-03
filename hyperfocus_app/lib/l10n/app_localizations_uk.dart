// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Ukrainian (`uk`).
class AppLocalizationsUk extends AppLocalizations {
  AppLocalizationsUk([String locale = 'uk']) : super(locale);

  @override
  String get appTitle => 'HyperFocus';

  @override
  String get whatsOverwhelming => 'Shcho tebe zaraз pereповнює?';

  @override
  String get homeSubtitle =>
      'Обери завдання і ми розіб\'ємо його на маленькі кроки.';

  @override
  String get searchHint => 'Шукати завдання...';

  @override
  String get pickCategory => 'Обери категорію';

  @override
  String get tasks => 'завдань';

  @override
  String get steps => 'кроків';

  @override
  String get categoryCleaning => 'Прибирання';

  @override
  String get categorySelfCare => 'Самодогляд';

  @override
  String get categoryAdmin => 'Адміністрація';

  @override
  String get categoryWork => 'Робота';

  @override
  String get categoryCooking => 'Готування';

  @override
  String get categorySocial => 'Соціальне';

  @override
  String get createCustomTask => 'Створити власне завдання';

  @override
  String get noResultsFound => 'Нічого не знайдено';

  @override
  String get errorLoading => 'Щось пішло не так';

  @override
  String stepOf(int current, int total) {
    return 'Крок $current з $total';
  }

  @override
  String get done => 'ГОТОВО';

  @override
  String get skipThisStep => 'Пропустити цей крок';

  @override
  String get abandonTask => 'Залишити завдання?';

  @override
  String get abandonTaskConfirm =>
      'Нічого страшного — завжди можна повернутися пізніше.';

  @override
  String get keepGoing => 'Продовжити';

  @override
  String get yesAbandon => 'Так, залишити';

  @override
  String get letsDoThis => 'Починаємо!';

  @override
  String get readyToStart => 'Крок за кроком. Ти зможеш.';

  @override
  String estimatedTime(int minutes) {
    return '~$minutes хв';
  }

  @override
  String get youDidIt => 'Ти це зробив!';

  @override
  String completedStepsCount(int count) {
    return '$count кроків виконано';
  }

  @override
  String timeTaken(int minutes) {
    return '$minutes хвилин';
  }

  @override
  String get backToHome => 'На головну';

  @override
  String get encouragement1 => 'Кожен крок має значення. Ти сьогодні старався.';

  @override
  String get encouragement2 => 'Подивись на себе, ти робиш справи!';

  @override
  String get encouragement3 => 'Було не так вже й страшно, правда?';

  @override
  String get encouragement4 => 'Одне завдання за раз. Ти молодець.';

  @override
  String get encouragement5 => 'Прогрес, не досконалість. Чудова робота!';

  @override
  String get history => 'Історія';

  @override
  String get noHistory => 'Ще немає виконаних завдань';

  @override
  String get clearAll => 'Очистити все';

  @override
  String get clearAllHistory => 'Очистити всю історію?';

  @override
  String get clearAllHistoryConfirm =>
      'Всі записи про виконані завдання будуть видалені. Це не можна скасувати.';

  @override
  String get cancel => 'Скасувати';

  @override
  String get historyPremiumOnly => 'Історія — преміум функція';

  @override
  String get settings => 'Налаштування';

  @override
  String get timerSettings => 'Таймер';

  @override
  String get enableTimer => 'Таймер кроку';

  @override
  String get enableTimerDescription =>
      'Показувати таймер зворотного відліку для кожного кроку';

  @override
  String get defaultStepDuration => 'Тривалість кроку за замовчуванням';

  @override
  String get minutes => 'хвилин';

  @override
  String get timeBlindness => 'Часова сліпота';

  @override
  String get timeBlindnessChime => 'Сигнал часової обізнаності';

  @override
  String get chimeEvery => 'Нагадувати кожні';

  @override
  String minutesShort(int minutes) {
    return '$minutes хв';
  }

  @override
  String get chimePremiumOnly => 'Сигнали часової сліпоти — преміум функція';

  @override
  String get soundSettings => 'Звук';

  @override
  String get enableSound => 'Звукові ефекти';

  @override
  String get enableSoundDescription => 'Сигнали та звуки святкування';

  @override
  String get premium => 'Преміум';

  @override
  String get premiumActive => 'Преміум активний';

  @override
  String get upgradePremium => 'Оновити до Преміум';

  @override
  String get premiumRequired => 'Потрібен Преміум';

  @override
  String get premiumDescription =>
      'Відкрийте 300+ шаблонів, аудіо часової сліпоти та історію завдань.';

  @override
  String get premiumFeatures =>
      '300+ шаблонів, сигнали часу, історія та без реклами.';

  @override
  String buyPremium(double price) {
    final intl.NumberFormat priceNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String priceString = priceNumberFormat.format(price);

    return 'Отримати Преміум — \$$priceString';
  }

  @override
  String get restorePurchases => 'Відновити покупки';

  @override
  String get maybeLater => 'Можливо пізніше';

  @override
  String get about => 'Про додаток';

  @override
  String get version => 'Версія';

  @override
  String get publisher => 'Видавець';

  @override
  String get contact => 'Контакт';

  @override
  String get taskTitle => 'Назва завдання';

  @override
  String get taskTitleHint => 'напр., Прибрати ванну';

  @override
  String get category => 'Категорія';

  @override
  String get microSteps => 'Мікро-кроки';

  @override
  String get microStepsHint => 'Розбий на якнайменші можливі кроки';

  @override
  String get addStep => 'Додати крок';

  @override
  String get stepHint => 'напр., Встати';

  @override
  String get save => 'Зберегти';

  @override
  String get pleaseEnterTitle => 'Будь ласка, введіть назву завдання';

  @override
  String get pleaseAddSteps => 'Будь ласка, додайте хоча б один крок';

  @override
  String get noTemplatesInCategory => 'Ще немає шаблонів у цій категорії';

  @override
  String get pauseTimer => 'Пауза';

  @override
  String get resumeTimer => 'Продовжити';

  @override
  String get quickStart => 'Швидкий старт';

  @override
  String get quickStartDescription => 'Використати шаблон з 3 кроків';

  @override
  String get orAddYourOwn => 'Або додай свої кроки нижче';
}
