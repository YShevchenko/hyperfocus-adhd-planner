import 'package:equatable/equatable.dart';

/// An individual step within a task breakdown.
class MicroStep extends Equatable {
  final String text;
  final int? durationSeconds;

  const MicroStep({
    required this.text,
    this.durationSeconds,
  });

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      if (durationSeconds != null) 'durationSeconds': durationSeconds,
    };
  }

  factory MicroStep.fromMap(Map<String, dynamic> map) {
    return MicroStep(
      text: map['text'] as String,
      durationSeconds: map['durationSeconds'] as int?,
    );
  }

  /// Create from a simple string (used by template JSON).
  factory MicroStep.fromText(String text) {
    return MicroStep(text: text);
  }

  Map<String, dynamic> toJson() => toMap();

  factory MicroStep.fromJson(Map<String, dynamic> json) =>
      MicroStep.fromMap(json);

  @override
  List<Object?> get props => [text, durationSeconds];
}
