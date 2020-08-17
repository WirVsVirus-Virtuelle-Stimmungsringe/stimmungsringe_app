String formatLastUpdateTimestamp(DateTime timestamp, DateTime now) {
  if (timestamp.isAfter(now.add(const Duration(seconds: -120)))) {
    return "gerade eben";
  } else if (timestamp.isAfter(now.add(const Duration(hours: -2)))) {
    final minutes = now.difference(timestamp).inMinutes;
    return "$minutes Minuten";
  } else if (timestamp.isAfter(now.add(const Duration(hours: -48)))) {
    final hours = now.difference(timestamp).inHours;
    return "$hours Stunden";
  } else {
    final days = now.difference(timestamp).inDays;
    return "$days Tage";
  }
}
