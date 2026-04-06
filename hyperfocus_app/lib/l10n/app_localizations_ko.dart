// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get appTitle => 'HyperFocus';

  @override
  String get whatsOverwhelming => '지금 무엇이 부담되나요?';

  @override
  String get homeSubtitle => '할 일을 고르면 작은 단계로 나눠드릴게요.';

  @override
  String get searchHint => '할 일 검색...';

  @override
  String get pickCategory => '카테고리 선택';

  @override
  String get tasks => '작업';

  @override
  String get steps => '단계';

  @override
  String get categoryCleaning => '청소';

  @override
  String get categorySelfCare => '자기 관리';

  @override
  String get categoryAdmin => '행정';

  @override
  String get categoryWork => '업무';

  @override
  String get categoryCooking => '요리';

  @override
  String get categorySocial => '소셜';

  @override
  String get createCustomTask => '나만의 할 일 만들기';

  @override
  String get noResultsFound => '결과를 찾을 수 없습니다';

  @override
  String get errorLoading => '오류가 발생했습니다';

  @override
  String stepOf(int current, int total) {
    return '단계 $current / $total';
  }

  @override
  String get done => '완료';

  @override
  String get skipThisStep => '이 단계 건너뛰기';

  @override
  String get abandonTask => '할 일을 그만둘까요?';

  @override
  String get abandonTaskConfirm =>
      '걱정 마세요 — 나중에 언제든 돌아올 수 있어요.';

  @override
  String get keepGoing => '계속하기';

  @override
  String get yesAbandon => '네, 그만둘게요';

  @override
  String get letsDoThis => '시작해볼까요!';

  @override
  String get readyToStart => '한 걸음씩. 할 수 있어요.';

  @override
  String estimatedTime(int minutes) {
    return '약 $minutes분';
  }

  @override
  String get youDidIt => '해냈어요!';

  @override
  String completedStepsCount(int count) {
    return '$count단계 완료';
  }

  @override
  String timeTaken(int minutes) {
    return '$minutes분';
  }

  @override
  String get backToHome => '홈으로 돌아가기';

  @override
  String get encouragement1 => '작은 한 걸음도 중요해요. 오늘도 잘했어요.';

  @override
  String get encouragement2 => '대단해요, 해내고 있잖아요!';

  @override
  String get encouragement3 => '생각보다 별것 아니었죠?';

  @override
  String get encouragement4 => '하나씩 하나씩. 정말 잘하고 있어요.';

  @override
  String get encouragement5 => '완벽이 아닌 진전. 수고했어요!';

  @override
  String get history => '기록';

  @override
  String get noHistory => '아직 완료된 할 일이 없습니다';

  @override
  String get clearAll => '모두 삭제';

  @override
  String get clearAllHistory => '기록을 모두 삭제할까요?';

  @override
  String get clearAllHistoryConfirm =>
      '완료된 할 일 기록이 모두 삭제됩니다. 이 작업은 되돌릴 수 없습니다.';

  @override
  String get cancel => '취소';

  @override
  String get historyPremiumOnly => '기록은 프리미엄 기능입니다';

  @override
  String get settings => '설정';

  @override
  String get timerSettings => '타이머';

  @override
  String get enableTimer => '단계 타이머';

  @override
  String get enableTimerDescription => '각 단계에 카운트다운 타이머 표시';

  @override
  String get defaultStepDuration => '기본 단계 시간';

  @override
  String get minutes => '분';

  @override
  String get timeBlindness => '시간 감각 상실';

  @override
  String get timeBlindnessChime => '시간 인식 알림';

  @override
  String get chimeEvery => '알림 간격';

  @override
  String minutesShort(int minutes) {
    return '$minutes분';
  }

  @override
  String get chimePremiumOnly => '시간 감각 알림은 프리미엄 기능입니다';

  @override
  String get soundSettings => '사운드';

  @override
  String get enableSound => '효과음';

  @override
  String get enableSoundDescription => '알림음과 축하 소리';

  @override
  String get premium => '프리미엄';

  @override
  String get premiumActive => '프리미엄 활성';

  @override
  String get upgradePremium => '프리미엄으로 업그레이드';

  @override
  String get premiumRequired => '프리미엄이 필요합니다';

  @override
  String get premiumDescription =>
      '300개 이상의 할 일 템플릿, 시간 감각 오디오, 할 일 기록을 잠금 해제하세요.';

  @override
  String get premiumFeatures =>
      '300개 이상의 템플릿, 시간 알림, 할 일 기록, 광고 없음.';

  @override
  String buyPremium(double price) {
    final intl.NumberFormat priceNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String priceString = priceNumberFormat.format(price);

    return '프리미엄 구매 — \$$priceString';
  }

  @override
  String get restorePurchases => '구매 복원';

  @override
  String get maybeLater => '나중에';

  @override
  String get about => '정보';

  @override
  String get version => '버전';

  @override
  String get publisher => '퍼블리셔';

  @override
  String get contact => '연락처';

  @override
  String get taskTitle => '할 일 제목';

  @override
  String get taskTitleHint => '예: 욕실 청소하기';

  @override
  String get category => '카테고리';

  @override
  String get microSteps => '세부 단계';

  @override
  String get microStepsHint => '가능한 가장 작은 단계로 나누세요';

  @override
  String get addStep => '단계 추가';

  @override
  String get stepHint => '예: 일어나기';

  @override
  String get save => '저장';

  @override
  String get pleaseEnterTitle => '할 일 제목을 입력하세요';

  @override
  String get pleaseAddSteps => '최소 하나의 단계를 추가하세요';

  @override
  String get noTemplatesInCategory => '이 카테고리에 아직 템플릿이 없습니다';

  @override
  String get pauseTimer => '일시정지';

  @override
  String get resumeTimer => '계속하기';

  @override
  String get quickStart => '빠른 시작';

  @override
  String get quickStartDescription => '3단계 시작 템플릿 사용';

  @override
  String get orAddYourOwn => '또는 아래에 나만의 단계를 추가하세요';
}
