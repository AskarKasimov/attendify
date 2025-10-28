/// События для BLoC сканирования
sealed class ScanningEvent {
  const ScanningEvent();
}

/// Начать сканирование
class StartScanningEvent extends ScanningEvent {
  const StartScanningEvent();
}

/// Очистить результаты
class ClearResultsEvent extends ScanningEvent {
  const ClearResultsEvent();
}
