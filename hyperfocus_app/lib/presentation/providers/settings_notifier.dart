import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsState extends Equatable {
  final bool timerEnabled;
  final int defaultStepDuration; // seconds
  final bool chimeEnabled;
  final int chimeIntervalMinutes;
  final bool soundEnabled;

  const SettingsState({
    this.timerEnabled = false,
    this.defaultStepDuration = 120,
    this.chimeEnabled = false,
    this.chimeIntervalMinutes = 10,
    this.soundEnabled = true,
  });

  SettingsState copyWith({
    bool? timerEnabled,
    int? defaultStepDuration,
    bool? chimeEnabled,
    int? chimeIntervalMinutes,
    bool? soundEnabled,
  }) {
    return SettingsState(
      timerEnabled: timerEnabled ?? this.timerEnabled,
      defaultStepDuration: defaultStepDuration ?? this.defaultStepDuration,
      chimeEnabled: chimeEnabled ?? this.chimeEnabled,
      chimeIntervalMinutes:
          chimeIntervalMinutes ?? this.chimeIntervalMinutes,
      soundEnabled: soundEnabled ?? this.soundEnabled,
    );
  }

  @override
  List<Object?> get props => [
        timerEnabled,
        defaultStepDuration,
        chimeEnabled,
        chimeIntervalMinutes,
        soundEnabled,
      ];
}

class SettingsNotifier extends StateNotifier<SettingsState> {
  SettingsNotifier() : super(const SettingsState()) {
    _loadSettings();
  }

  static const _keyTimerEnabled = 'timer_enabled';
  static const _keyDefaultDuration = 'default_step_duration';
  static const _keyChimeEnabled = 'chime_enabled';
  static const _keyChimeInterval = 'chime_interval_minutes';
  static const _keySoundEnabled = 'sound_enabled';

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    state = SettingsState(
      timerEnabled: prefs.getBool(_keyTimerEnabled) ?? false,
      defaultStepDuration: prefs.getInt(_keyDefaultDuration) ?? 120,
      chimeEnabled: prefs.getBool(_keyChimeEnabled) ?? false,
      chimeIntervalMinutes: prefs.getInt(_keyChimeInterval) ?? 10,
      soundEnabled: prefs.getBool(_keySoundEnabled) ?? true,
    );
  }

  Future<void> setTimerEnabled(bool value) async {
    state = state.copyWith(timerEnabled: value);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyTimerEnabled, value);
  }

  Future<void> setDefaultStepDuration(int seconds) async {
    state = state.copyWith(defaultStepDuration: seconds);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_keyDefaultDuration, seconds);
  }

  Future<void> setChimeEnabled(bool value) async {
    state = state.copyWith(chimeEnabled: value);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyChimeEnabled, value);
  }

  Future<void> setChimeIntervalMinutes(int minutes) async {
    state = state.copyWith(chimeIntervalMinutes: minutes);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_keyChimeInterval, minutes);
  }

  Future<void> setSoundEnabled(bool value) async {
    state = state.copyWith(soundEnabled: value);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keySoundEnabled, value);
  }
}
