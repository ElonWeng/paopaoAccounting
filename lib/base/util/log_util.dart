class LogUtil {

  // 日志级别（示例）
  static const int VERBOSE = 0;
  static const int DEBUG = 1;
  static const int INFO = 2;
  static const int WARNING = 3;
  static const int ERROR = 4;

  // 静态方法，用于打印日志
  static void log(int level, String tag, String message) {
    String prefix = '';
    switch (level) {
      case VERBOSE:
        prefix = 'V/';
        break;
      case DEBUG:
        prefix = 'D/';
        break;
      case INFO:
        prefix = 'I/';
        break;
      case WARNING:
        prefix = 'W/';
        break;
      case ERROR:
        prefix = 'E/';
        break;
      default:
        prefix = 'U/'; // 未知级别
    }
    print('${prefix}${tag}: ${message}');
  }

  // 快捷方法，用于不同级别的日志
  static void verbose(String tag, String message) => log(VERBOSE, tag, message);
  static void debug(String tag, String message) => log(DEBUG, tag, message);
  static void info(String tag, String message) => log(INFO, tag, message);
  static void warning(String tag, String message) => log(WARNING, tag, message);
  static void error(String tag, String message) => log(ERROR, tag, message);
}

