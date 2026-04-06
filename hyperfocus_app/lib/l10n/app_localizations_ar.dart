// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'HyperFocus';

  @override
  String get whatsOverwhelming => 'ما الذي يُرهقك الآن؟';

  @override
  String get homeSubtitle => 'اختر مهمة وسنقسّمها إلى خطوات صغيرة.';

  @override
  String get searchHint => 'البحث عن مهام...';

  @override
  String get pickCategory => 'اختر فئة';

  @override
  String get tasks => 'المهام';

  @override
  String get steps => 'الخطوات';

  @override
  String get categoryCleaning => 'تنظيف';

  @override
  String get categorySelfCare => 'العناية الذاتية';

  @override
  String get categoryAdmin => 'إداري';

  @override
  String get categoryWork => 'عمل';

  @override
  String get categoryCooking => 'طبخ';

  @override
  String get categorySocial => 'اجتماعي';

  @override
  String get createCustomTask => 'إنشاء مهمتك الخاصة';

  @override
  String get noResultsFound => 'لم يتم العثور على نتائج';

  @override
  String get errorLoading => 'حدث خطأ ما';

  @override
  String stepOf(int current, int total) {
    return 'الخطوة $current من $total';
  }

  @override
  String get done => 'تم';

  @override
  String get skipThisStep => 'تخطي هذه الخطوة';

  @override
  String get abandonTask => 'مغادرة المهمة؟';

  @override
  String get abandonTaskConfirm =>
      'لا تقلق — يمكنك دائماً العودة إليها لاحقاً.';

  @override
  String get keepGoing => 'استمر';

  @override
  String get yesAbandon => 'نعم، غادر';

  @override
  String get letsDoThis => 'هيا نبدأ!';

  @override
  String get readyToStart => 'خطوة بخطوة. يمكنك فعلها.';

  @override
  String estimatedTime(int minutes) {
    return '~$minutes دقيقة';
  }

  @override
  String get youDidIt => 'لقد فعلتها!';

  @override
  String completedStepsCount(int count) {
    return 'تم إكمال $count خطوة';
  }

  @override
  String timeTaken(int minutes) {
    return '$minutes دقيقة';
  }

  @override
  String get backToHome => 'العودة للرئيسية';

  @override
  String get encouragement1 => 'كل خطوة صغيرة مهمة. لقد حضرت اليوم.';

  @override
  String get encouragement2 => 'انظر إليك، تنجز الأمور!';

  @override
  String get encouragement3 => 'لم يكن الأمر بهذا السوء، أليس كذلك؟';

  @override
  String get encouragement4 => 'مهمة واحدة في كل مرة. أنت تبلي حسناً.';

  @override
  String get encouragement5 => 'التقدم، لا الكمال. أحسنت!';

  @override
  String get history => 'السجل';

  @override
  String get noHistory => 'لا توجد مهام مكتملة بعد';

  @override
  String get clearAll => 'مسح الكل';

  @override
  String get clearAllHistory => 'مسح كل السجل؟';

  @override
  String get clearAllHistoryConfirm =>
      'سيتم حذف جميع سجلات المهام المكتملة. لا يمكن التراجع عن هذا.';

  @override
  String get cancel => 'إلغاء';

  @override
  String get historyPremiumOnly => 'السجل ميزة مميزة';

  @override
  String get settings => 'الإعدادات';

  @override
  String get timerSettings => 'مؤقت';

  @override
  String get enableTimer => 'مؤقت الخطوة';

  @override
  String get enableTimerDescription => 'عرض مؤقت عد تنازلي لكل خطوة';

  @override
  String get defaultStepDuration => 'مدة الخطوة الافتراضية';

  @override
  String get minutes => 'دقائق';

  @override
  String get timeBlindness => 'عمى الزمن';

  @override
  String get timeBlindnessChime => 'تنبيه الوعي بالوقت';

  @override
  String get chimeEvery => 'ذكّرني كل';

  @override
  String minutesShort(int minutes) {
    return '$minutes دقيقة';
  }

  @override
  String get chimePremiumOnly => 'تنبيهات عمى الزمن ميزة مميزة';

  @override
  String get soundSettings => 'الصوت';

  @override
  String get enableSound => 'المؤثرات الصوتية';

  @override
  String get enableSoundDescription => 'أصوات التنبيه والاحتفال';

  @override
  String get premium => 'مميز';

  @override
  String get premiumActive => 'الاشتراك المميز نشط';

  @override
  String get upgradePremium => 'الترقية إلى المميز';

  @override
  String get premiumRequired => 'يتطلب الاشتراك المميز';

  @override
  String get premiumDescription =>
      'افتح أكثر من 300 قالب مهام، وصوت عمى الزمن، وسجل المهام.';

  @override
  String get premiumFeatures =>
      'أكثر من 300 قالب، تنبيهات الوقت، سجل المهام، وبدون إعلانات.';

  @override
  String buyPremium(double price) {
    final intl.NumberFormat priceNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String priceString = priceNumberFormat.format(price);

    return 'احصل على المميز — \$$priceString';
  }

  @override
  String get restorePurchases => 'استعادة المشتريات';

  @override
  String get maybeLater => 'ربما لاحقاً';

  @override
  String get about => 'حول';

  @override
  String get version => 'الإصدار';

  @override
  String get publisher => 'الناشر';

  @override
  String get contact => 'التواصل';

  @override
  String get taskTitle => 'عنوان المهمة';

  @override
  String get taskTitleHint => 'مثال: تنظيف الحمام';

  @override
  String get category => 'الفئة';

  @override
  String get microSteps => 'خطوات صغيرة';

  @override
  String get microStepsHint => 'قسّمها إلى أصغر خطوات ممكنة';

  @override
  String get addStep => 'إضافة خطوة';

  @override
  String get stepHint => 'مثال: قف';

  @override
  String get save => 'حفظ';

  @override
  String get pleaseEnterTitle => 'الرجاء إدخال عنوان المهمة';

  @override
  String get pleaseAddSteps => 'الرجاء إضافة خطوة واحدة على الأقل';

  @override
  String get noTemplatesInCategory => 'لا توجد قوالب في هذه الفئة بعد';

  @override
  String get pauseTimer => 'إيقاف مؤقت';

  @override
  String get resumeTimer => 'استئناف';

  @override
  String get quickStart => 'بداية سريعة';

  @override
  String get quickStartDescription => 'استخدم قالبنا للبدء بـ 3 خطوات';

  @override
  String get orAddYourOwn => 'أو أضف خطواتك الخاصة أدناه';
}
