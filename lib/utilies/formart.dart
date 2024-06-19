String splitDate(String date) {
  return date.split("T")[0] ?? "";
}

String replaceStringStatus(String word) {
  return word.split("_")[1].toUpperCase() ?? "";
}
