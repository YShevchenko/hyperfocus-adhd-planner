import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';

/// Audio service for time-blindness chime sounds.
class AudioService {
  static final AudioService _instance = AudioService._();
  factory AudioService() => _instance;
  AudioService._();

  final AudioPlayer _player = AudioPlayer();

  /// Play a short satisfying sound on step completion (dopamine hit).
  Future<void> playStepComplete() async {
    try {
      await _player.setVolume(0.6);
      await _player.setReleaseMode(ReleaseMode.stop);
      await _player.play(AssetSource('audio/chime.mp3'));
    } catch (e) {
      debugPrint('Failed to play step complete sound: $e');
    }
  }

  /// Play a gentle chime sound for time-blindness reminders.
  /// Uses a system-like sound since we generate a tone.
  Future<void> playChime() async {
    try {
      // Use a short gentle tone. We generate a simple beep using the audio
      // player's tone capability via a bundled asset or system sound.
      await _player.setVolume(0.3);
      await _player.setReleaseMode(ReleaseMode.stop);
      // Play from bundled asset
      await _player.play(AssetSource('audio/chime.mp3'));
    } catch (e) {
      debugPrint('Failed to play chime: $e');
    }
  }

  /// Play a completion celebration sound.
  Future<void> playCelebration() async {
    try {
      await _player.setVolume(0.5);
      await _player.setReleaseMode(ReleaseMode.stop);
      await _player.play(AssetSource('audio/celebration.mp3'));
    } catch (e) {
      debugPrint('Failed to play celebration: $e');
    }
  }

  void dispose() {
    _player.dispose();
  }
}
