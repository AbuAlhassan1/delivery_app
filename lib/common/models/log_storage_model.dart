class LogStorage {
  static final List<String> _logs = [];

  static void addLog(String message) {
    _logs.add(message);
  }

  static List<String> getLogs() {
    return _logs;
  }

  static void clearLogs() {
    _logs.clear();
  }
}