library ffmpeg_kit_extended_flutter;

typedef FFmpegStatisticsCallback = void Function(FFmpegStatistics statistics);
typedef FFmpegCompleteCallback = void Function(FFmpegSession session);

class FFmpegKitExtended {
  static void initialize() {}
}

class FFmpegKit {
  static FFmpegSession createSession(String command) {
    return FFmpegSession(command);
  }

  static void cancel(FFmpegSession? session) {
    session?.cancel();
  }
}

class FFmpegSession {
  FFmpegSession(this.command);

  final String command;
  FFmpegStatisticsCallback? _statisticsCallback;
  FFmpegCompleteCallback? _completeCallback;
  bool _cancelled = false;

  int getSessionId() => command.hashCode;

  void setStatisticsCallback(FFmpegStatisticsCallback callback) {
    _statisticsCallback = callback;
  }

  void setCompleteCallback(FFmpegCompleteCallback callback) {
    _completeCallback = callback;
  }

  Future<void> executeAsync() async {
    _statisticsCallback?.call(const FFmpegStatistics());
    _completeCallback?.call(this);
  }

  int getReturnCode() => _cancelled ? 255 : -1;

  String? getLogs() => 'FFmpeg is disabled in this iOS build.';

  void cancel() {
    _cancelled = true;
  }
}

class FFmpegStatistics {
  const FFmpegStatistics({
    this.time = 0,
    this.size = 0,
    this.bitrate = 0,
    this.speed = 0,
    this.videoFps = 0,
  });

  final int time;
  final int size;
  final double bitrate;
  final double speed;
  final double videoFps;
}
