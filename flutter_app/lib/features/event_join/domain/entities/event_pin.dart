class EventPin {
  const EventPin({required this.value});

  final String value;

  bool get isValid => value.length == 6 && int.tryParse(value) != null;

  String get formatted => value.split('').join('-');
}
