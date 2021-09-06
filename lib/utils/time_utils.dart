String calcTimeDifferenceInWords(DateTime timestamp, DateTime now) {
  final Duration difference = now.difference(timestamp);

  return durationInWords(difference, false);
}

String durationInWords(
  Duration duration,
  bool withSeconds, {
  String preposition = "vor",
}) {
  assert(preposition == "vor" || preposition == "seit");

  if (duration.inMinutes < 1) {
    if (withSeconds) {
      return "$preposition ${duration.inSeconds} Sekunden";
    } else {
      return preposition == "vor" ? "gerade eben" : "seit Kurzem";
    }
  } else if (duration.inHours < 1) {
    return "$preposition ${duration.inMinutes} ${duration.inMinutes == 1 ? "Minute" : "Minuten"}";
  } else if (duration.inDays < 1) {
    return "$preposition ${duration.inHours} ${duration.inHours == 1 ? "Stunde" : "Stunden"}";
  } else {
    return "$preposition ${duration.inDays} ${duration.inDays == 1 ? "Tag" : "Tagen"}";
  }
}
