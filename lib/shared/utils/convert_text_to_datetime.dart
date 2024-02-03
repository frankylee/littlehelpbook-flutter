/// Convert text to DateTime.
DateTime? convertTextToDateTime(String? text) {
  if (text == null || text.isEmpty) return null;
  return DateTime.tryParse(text);
}
