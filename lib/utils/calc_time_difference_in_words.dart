String calcTimeDifferenceInWords(DateTime timestamp, DateTime now) {
  final Duration difference = now.difference(timestamp);

  if (difference.inMinutes < 1) {
    return "gerade eben";
  } else if (difference.inHours < 1) {
    return "vor ${difference.inMinutes} ${difference.inMinutes == 1 ? "Minute" : "Minuten"}";
  } else if (difference.inDays < 1) {
    return "vor ${difference.inHours} ${difference.inHours == 1 ? "Stunde" : "Stunden"}";
  } else {
    return "vor ${difference.inDays} ${difference.inDays == 1 ? "Tag" : "Tagen"}";
  }
}
