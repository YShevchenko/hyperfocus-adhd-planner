import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';

/// Top-level entry point required by flutter_foreground_task.
/// Must be a top-level (not class) function annotated with @pragma.
@pragma('vm:entry-point')
void startCallback() {
  FlutterForegroundTask.setTaskHandler(_ChimeTaskHandler());
}

/// Handles the periodic chime while the foreground service is running.
class _ChimeTaskHandler extends TaskHandler {
  final AudioPlayer _player = AudioPlayer();

  @override
  Future<void> onStart(DateTime timestamp, TaskStarter starter) async {
    // Nothing to set up — chimes are driven by onRepeatEvent.
  }

  @override
  Future<void> onRepeatEvent(DateTime timestamp) async {
    try {
      await _player.setVolume(0.3);
      await _player.setReleaseMode(ReleaseMode.stop);
      await _player.play(AssetSource('audio/chime.mp3'));
    } catch (_) {
      // Silently ignore audio failures in background.
    }
  }

  @override
  Future<void> onDestroy(DateTime timestamp) async {
    await _player.dispose();
  }
}

/// Manages start/stop of the chime foreground service.
class ChimeForegroundService {
  ChimeForegroundService._();

  /// Call once from main() before runApp.
  static void init() {
    FlutterForegroundTask.initCommunicationPort();
  }

  /// Start the foreground service chiming every [intervalMinutes].
  static Future<void> start(int intervalMinutes) async {
    FlutterForegroundTask.init(
      androidNotificationOptions: AndroidNotificationOptions(
        channelId: 'hyperfocus_chime',
        channelName: 'Time Awareness Chime',
        channelDescription: 'Plays a gentle chime at regular intervals.',
        onlyAlertOnce: true,
      ),
      iosNotificationOptions: const IOSNotificationOptions(
        showNotification: false,
      ),
      foregroundTaskOptions: ForegroundTaskOptions(
        eventAction: ForegroundTaskEventAction.repeat(
          intervalMinutes * 60 * 1000, // milliseconds
        ),
        autoRunOnBoot: false,
        allowWakeLock: true,
      ),
    );

    final isRunning = await FlutterForegroundTask.isRunningService;
    if (isRunning) {
      await FlutterForegroundTask.restartService();
    } else {
      await FlutterForegroundTask.startService(
        serviceId: 1001,
        notificationTitle: 'HyperFocus',
        notificationText: 'Time awareness active',
        callback: startCallback,
      );
    }
  }

  /// Stop the foreground service.
  static Future<void> stop() async {
    final isRunning = await FlutterForegroundTask.isRunningService;
    if (isRunning) {
      await FlutterForegroundTask.stopService();
    }
  }
}
