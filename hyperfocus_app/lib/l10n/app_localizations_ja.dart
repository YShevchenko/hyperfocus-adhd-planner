// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appTitle => 'HyperFocus';

  @override
  String get whatsOverwhelming => '今、何に圧倒されていますか？';

  @override
  String get homeSubtitle => 'タスクを選んで、小さなステップに分解しましょう。';

  @override
  String get searchHint => 'タスクを検索...';

  @override
  String get pickCategory => 'カテゴリを選択';

  @override
  String get tasks => 'タスク';

  @override
  String get steps => 'ステップ';

  @override
  String get categoryCleaning => '掃除';

  @override
  String get categorySelfCare => 'セルフケア';

  @override
  String get categoryAdmin => '事務';

  @override
  String get categoryWork => '仕事';

  @override
  String get categoryCooking => '料理';

  @override
  String get categorySocial => '社交';

  @override
  String get createCustomTask => 'オリジナルタスクを作成';

  @override
  String get noResultsFound => '結果が見つかりません';

  @override
  String get errorLoading => 'エラーが発生しました';

  @override
  String stepOf(int current, int total) {
    return 'ステップ $current / $total';
  }

  @override
  String get done => '完了';

  @override
  String get skipThisStep => 'このステップをスキップ';

  @override
  String get abandonTask => 'タスクを離れますか？';

  @override
  String get abandonTaskConfirm =>
      '大丈夫 — いつでも戻ってこられます。';

  @override
  String get keepGoing => '続ける';

  @override
  String get yesAbandon => 'はい、離れる';

  @override
  String get letsDoThis => 'さあ始めよう！';

  @override
  String get readyToStart => '一歩ずつ。あなたならできます。';

  @override
  String estimatedTime(int minutes) {
    return '約$minutes分';
  }

  @override
  String get youDidIt => 'やったね！';

  @override
  String completedStepsCount(int count) {
    return '$countステップ完了';
  }

  @override
  String timeTaken(int minutes) {
    return '$minutes分';
  }

  @override
  String get backToHome => 'ホームに戻る';

  @override
  String get encouragement1 => '小さな一歩が大事。今日も頑張りました。';

  @override
  String get encouragement2 => 'すごい、ちゃんとやり遂げてる！';

  @override
  String get encouragement3 => 'そんなに大変じゃなかったでしょ？';

  @override
  String get encouragement4 => '一つずつ。よくやってます。';

  @override
  String get encouragement5 => '完璧じゃなくて進歩。お疲れさま！';

  @override
  String get history => '履歴';

  @override
  String get noHistory => 'まだ完了したタスクはありません';

  @override
  String get clearAll => 'すべて消去';

  @override
  String get clearAllHistory => '履歴をすべて消去しますか？';

  @override
  String get clearAllHistoryConfirm =>
      '完了したタスクの記録がすべて削除されます。この操作は取り消せません。';

  @override
  String get cancel => 'キャンセル';

  @override
  String get historyPremiumOnly => '履歴はプレミアム機能です';

  @override
  String get settings => '設定';

  @override
  String get timerSettings => 'タイマー';

  @override
  String get enableTimer => 'ステップタイマー';

  @override
  String get enableTimerDescription => '各ステップにカウントダウンタイマーを表示';

  @override
  String get defaultStepDuration => 'デフォルトのステップ時間';

  @override
  String get minutes => '分';

  @override
  String get timeBlindness => '時間感覚の喪失';

  @override
  String get timeBlindnessChime => '時間認識チャイム';

  @override
  String get chimeEvery => 'リマインド間隔';

  @override
  String minutesShort(int minutes) {
    return '$minutes分';
  }

  @override
  String get chimePremiumOnly => '時間感覚チャイムはプレミアム機能です';

  @override
  String get soundSettings => 'サウンド';

  @override
  String get enableSound => '効果音';

  @override
  String get enableSoundDescription => 'チャイムとお祝いの音';

  @override
  String get premium => 'プレミアム';

  @override
  String get premiumActive => 'プレミアム有効';

  @override
  String get upgradePremium => 'プレミアムにアップグレード';

  @override
  String get premiumRequired => 'プレミアムが必要です';

  @override
  String get premiumDescription =>
      '300以上のタスクテンプレート、時間感覚オーディオ、タスク履歴をアンロック。';

  @override
  String get premiumFeatures =>
      '300以上のテンプレート、時間チャイム、タスク履歴、広告なし。';

  @override
  String buyPremium(double price) {
    final intl.NumberFormat priceNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String priceString = priceNumberFormat.format(price);

    return 'プレミアムを取得 — \$$priceString';
  }

  @override
  String get restorePurchases => '購入を復元';

  @override
  String get maybeLater => 'また今度';

  @override
  String get about => 'アプリについて';

  @override
  String get version => 'バージョン';

  @override
  String get publisher => 'パブリッシャー';

  @override
  String get contact => '連絡先';

  @override
  String get taskTitle => 'タスク名';

  @override
  String get taskTitleHint => '例：お風呂を掃除する';

  @override
  String get category => 'カテゴリ';

  @override
  String get microSteps => 'マイクロステップ';

  @override
  String get microStepsHint => 'できるだけ小さなステップに分けましょう';

  @override
  String get addStep => 'ステップを追加';

  @override
  String get stepHint => '例：立ち上がる';

  @override
  String get save => '保存';

  @override
  String get pleaseEnterTitle => 'タスク名を入力してください';

  @override
  String get pleaseAddSteps => '少なくとも1つのステップを追加してください';

  @override
  String get noTemplatesInCategory => 'このカテゴリにはまだテンプレートがありません';

  @override
  String get pauseTimer => '一時停止';

  @override
  String get resumeTimer => '再開';

  @override
  String get quickStart => 'クイックスタート';

  @override
  String get quickStartDescription => '3ステップのスタートテンプレートを使用';

  @override
  String get orAddYourOwn => 'または下に自分のステップを追加';
}
