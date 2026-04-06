// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'HyperFocus';

  @override
  String get whatsOverwhelming => 'Qu\'est-ce qui vous submerge ?';

  @override
  String get homeSubtitle => 'Choisissez une tâche et nous la décomposerons en petites étapes.';

  @override
  String get searchHint => 'Rechercher des tâches...';

  @override
  String get pickCategory => 'Choisir une catégorie';

  @override
  String get tasks => 'tâches';

  @override
  String get steps => 'étapes';

  @override
  String get categoryCleaning => 'Ménage';

  @override
  String get categorySelfCare => 'Bien-être';

  @override
  String get categoryAdmin => 'Admin';

  @override
  String get categoryWork => 'Travail';

  @override
  String get categoryCooking => 'Cuisine';

  @override
  String get categorySocial => 'Social';

  @override
  String get createCustomTask => 'Créer votre propre tâche';

  @override
  String get noResultsFound => 'Aucun résultat trouvé';

  @override
  String get errorLoading => 'Une erreur s\'est produite';

  @override
  String stepOf(int current, int total) {
    return 'Étape $current sur $total';
  }

  @override
  String get done => 'TERMINÉ';

  @override
  String get skipThisStep => 'Passer cette étape';

  @override
  String get abandonTask => 'Quitter la tâche ?';

  @override
  String get abandonTaskConfirm =>
      'Pas de souci — vous pourrez toujours y revenir plus tard.';

  @override
  String get keepGoing => 'Continuer';

  @override
  String get yesAbandon => 'Oui, quitter';

  @override
  String get letsDoThis => 'C\'est parti !';

  @override
  String get readyToStart => 'Une étape à la fois. Vous pouvez le faire.';

  @override
  String estimatedTime(int minutes) {
    return '~$minutes min';
  }

  @override
  String get youDidIt => 'Vous l\'avez fait !';

  @override
  String completedStepsCount(int count) {
    return '$count étapes terminées';
  }

  @override
  String timeTaken(int minutes) {
    return '$minutes minutes';
  }

  @override
  String get backToHome => 'Retour à l\'accueil';

  @override
  String get encouragement1 => 'Chaque petit pas compte. Vous avez fait l\'effort aujourd\'hui.';

  @override
  String get encouragement2 => 'Regardez-vous, vous accomplissez des choses !';

  @override
  String get encouragement3 => 'Ce n\'était pas si terrible, non ?';

  @override
  String get encouragement4 => 'Une tâche à la fois. Vous vous en sortez très bien.';

  @override
  String get encouragement5 => 'Le progrès, pas la perfection. Bien joué !';

  @override
  String get history => 'Historique';

  @override
  String get noHistory => 'Aucune tâche terminée pour l\'instant';

  @override
  String get clearAll => 'Tout effacer';

  @override
  String get clearAllHistory => 'Effacer tout l\'historique ?';

  @override
  String get clearAllHistoryConfirm =>
      'Cela supprimera tous vos enregistrements de tâches terminées. Cette action est irréversible.';

  @override
  String get cancel => 'Annuler';

  @override
  String get historyPremiumOnly => 'L\'historique est une fonctionnalité premium';

  @override
  String get settings => 'Paramètres';

  @override
  String get timerSettings => 'Minuteur';

  @override
  String get enableTimer => 'Minuteur d\'étape';

  @override
  String get enableTimerDescription => 'Afficher un compte à rebours pour chaque étape';

  @override
  String get defaultStepDuration => 'Durée par défaut de l\'étape';

  @override
  String get minutes => 'minutes';

  @override
  String get timeBlindness => 'Cécité temporelle';

  @override
  String get timeBlindnessChime => 'Signal de conscience du temps';

  @override
  String get chimeEvery => 'Me rappeler toutes les';

  @override
  String minutesShort(int minutes) {
    return '$minutes min';
  }

  @override
  String get chimePremiumOnly => 'Les signaux de cécité temporelle sont une fonctionnalité premium';

  @override
  String get soundSettings => 'Son';

  @override
  String get enableSound => 'Effets sonores';

  @override
  String get enableSoundDescription => 'Signaux et sons de célébration';

  @override
  String get premium => 'Premium';

  @override
  String get premiumActive => 'Premium actif';

  @override
  String get upgradePremium => 'Passer à Premium';

  @override
  String get premiumRequired => 'Premium requis';

  @override
  String get premiumDescription =>
      'Débloquez plus de 300 modèles de tâches, l\'audio de cécité temporelle et l\'historique des tâches.';

  @override
  String get premiumFeatures =>
      'Plus de 300 modèles, signaux de cécité temporelle, historique des tâches et sans publicité.';

  @override
  String buyPremium(double price) {
    final intl.NumberFormat priceNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String priceString = priceNumberFormat.format(price);

    return 'Obtenir Premium — \$$priceString';
  }

  @override
  String get restorePurchases => 'Restaurer les achats';

  @override
  String get maybeLater => 'Peut-être plus tard';

  @override
  String get about => 'À propos';

  @override
  String get version => 'Version';

  @override
  String get publisher => 'Éditeur';

  @override
  String get contact => 'Contact';

  @override
  String get taskTitle => 'Titre de la tâche';

  @override
  String get taskTitleHint => 'ex. Nettoyer la salle de bain';

  @override
  String get category => 'Catégorie';

  @override
  String get microSteps => 'Micro-étapes';

  @override
  String get microStepsHint => 'Décomposez en étapes les plus petites possibles';

  @override
  String get addStep => 'Ajouter une étape';

  @override
  String get stepHint => 'ex. Se lever';

  @override
  String get save => 'Enregistrer';

  @override
  String get pleaseEnterTitle => 'Veuillez entrer un titre de tâche';

  @override
  String get pleaseAddSteps => 'Veuillez ajouter au moins une étape';

  @override
  String get noTemplatesInCategory => 'Aucun modèle dans cette catégorie pour l\'instant';

  @override
  String get pauseTimer => 'Pause';

  @override
  String get resumeTimer => 'Reprendre';

  @override
  String get quickStart => 'Démarrage rapide';

  @override
  String get quickStartDescription => 'Utilisez notre modèle de démarrage en 3 étapes';

  @override
  String get orAddYourOwn => 'Ou ajoutez vos propres étapes ci-dessous';
}
