// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'HyperFocus';

  @override
  String get whatsOverwhelming => 'Que te abruma?';

  @override
  String get homeSubtitle =>
      'Elige una tarea y la dividiremos en pasos pequenos.';

  @override
  String get searchHint => 'Buscar tareas...';

  @override
  String get pickCategory => 'Elige una categoria';

  @override
  String get tasks => 'tareas';

  @override
  String get steps => 'pasos';

  @override
  String get categoryCleaning => 'Limpieza';

  @override
  String get categorySelfCare => 'Autocuidado';

  @override
  String get categoryAdmin => 'Administracion';

  @override
  String get categoryWork => 'Trabajo';

  @override
  String get categoryCooking => 'Cocina';

  @override
  String get categorySocial => 'Social';

  @override
  String get createCustomTask => 'Crea tu propia tarea';

  @override
  String get noResultsFound => 'No se encontraron resultados';

  @override
  String get errorLoading => 'Algo salio mal';

  @override
  String stepOf(int current, int total) {
    return 'Paso $current de $total';
  }

  @override
  String get done => 'HECHO';

  @override
  String get skipThisStep => 'Saltar este paso';

  @override
  String get abandonTask => 'Dejar la tarea?';

  @override
  String get abandonTaskConfirm =>
      'No pasa nada, siempre puedes volver despues.';

  @override
  String get keepGoing => 'Seguir';

  @override
  String get yesAbandon => 'Si, salir';

  @override
  String get letsDoThis => 'Vamos alla!';

  @override
  String get readyToStart => 'Un paso a la vez. Tu puedes.';

  @override
  String estimatedTime(int minutes) {
    return '~$minutes min';
  }

  @override
  String get youDidIt => 'Lo lograste!';

  @override
  String completedStepsCount(int count) {
    return '$count pasos completados';
  }

  @override
  String timeTaken(int minutes) {
    return '$minutes minutos';
  }

  @override
  String get backToHome => 'Volver al inicio';

  @override
  String get encouragement1 => 'Cada paso cuenta. Hoy lo intentaste.';

  @override
  String get encouragement2 => 'Mirate, logrando cosas!';

  @override
  String get encouragement3 => 'No estuvo tan mal, verdad?';

  @override
  String get encouragement4 => 'Una tarea a la vez. Lo estas haciendo genial.';

  @override
  String get encouragement5 => 'Progreso, no perfeccion. Bien hecho!';

  @override
  String get history => 'Historial';

  @override
  String get noHistory => 'Aun no hay tareas completadas';

  @override
  String get clearAll => 'Borrar todo';

  @override
  String get clearAllHistory => 'Borrar todo el historial?';

  @override
  String get clearAllHistoryConfirm =>
      'Se eliminaran todos los registros de tareas completadas. Esto no se puede deshacer.';

  @override
  String get cancel => 'Cancelar';

  @override
  String get historyPremiumOnly => 'El historial es una funcion premium';

  @override
  String get settings => 'Ajustes';

  @override
  String get timerSettings => 'Temporizador';

  @override
  String get enableTimer => 'Temporizador por paso';

  @override
  String get enableTimerDescription =>
      'Mostrar cuenta regresiva para cada paso';

  @override
  String get defaultStepDuration => 'Duracion predeterminada del paso';

  @override
  String get minutes => 'minutos';

  @override
  String get timeBlindness => 'Ceguera temporal';

  @override
  String get timeBlindnessChime => 'Campana de conciencia temporal';

  @override
  String get chimeEvery => 'Recordarme cada';

  @override
  String minutesShort(int minutes) {
    return '$minutes min';
  }

  @override
  String get chimePremiumOnly =>
      'Las campanas de ceguera temporal son una funcion premium';

  @override
  String get soundSettings => 'Sonido';

  @override
  String get enableSound => 'Efectos de sonido';

  @override
  String get enableSoundDescription => 'Campanas y sonidos de celebracion';

  @override
  String get premium => 'Premium';

  @override
  String get premiumActive => 'Premium activo';

  @override
  String get upgradePremium => 'Mejorar a Premium';

  @override
  String get premiumRequired => 'Se requiere Premium';

  @override
  String get premiumDescription =>
      'Desbloquea mas de 300 plantillas, audio de ceguera temporal e historial.';

  @override
  String get premiumFeatures =>
      '300+ plantillas, campanas de tiempo, historial y sin anuncios.';

  @override
  String buyPremium(double price) {
    final intl.NumberFormat priceNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String priceString = priceNumberFormat.format(price);

    return 'Obtener Premium — \$$priceString';
  }

  @override
  String get restorePurchases => 'Restaurar compras';

  @override
  String get maybeLater => 'Quiza despues';

  @override
  String get about => 'Acerca de';

  @override
  String get version => 'Version';

  @override
  String get publisher => 'Editor';

  @override
  String get contact => 'Contacto';

  @override
  String get taskTitle => 'Titulo de la tarea';

  @override
  String get taskTitleHint => 'ej., Limpiar el bano';

  @override
  String get category => 'Categoria';

  @override
  String get microSteps => 'Micro-pasos';

  @override
  String get microStepsHint => 'Dividelo en los pasos mas pequenos posibles';

  @override
  String get addStep => 'Agregar paso';

  @override
  String get stepHint => 'ej., Levantarse';

  @override
  String get save => 'Guardar';

  @override
  String get pleaseEnterTitle => 'Por favor ingresa un titulo';

  @override
  String get pleaseAddSteps => 'Por favor agrega al menos un paso';

  @override
  String get noTemplatesInCategory => 'Aun no hay plantillas en esta categoria';

  @override
  String get pauseTimer => 'Pausar';

  @override
  String get resumeTimer => 'Continuar';

  @override
  String get quickStart => 'Inicio rapido';

  @override
  String get quickStartDescription => 'Usa nuestra plantilla de 3 pasos';

  @override
  String get orAddYourOwn => 'O agrega tus propios pasos abajo';
}
