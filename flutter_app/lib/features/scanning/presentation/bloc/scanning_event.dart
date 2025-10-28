sealed class ScanningEvent {
  const ScanningEvent();
}

class StartScanningEvent extends ScanningEvent {
  const StartScanningEvent({
    required this.eventId,
    required this.eventPin,
    this.timeout,
  });
  final String eventId;
  final String eventPin;
  final Duration? timeout;
}

class ClearResultsEvent extends ScanningEvent {
  const ClearResultsEvent();
}
