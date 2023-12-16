/// Convert a text array into a proper string list.
List<String> convertTextToList(String? text) {
  if (text == null) return List.empty(growable: false);
  return text
      .substring(1, text.length - 1)
      .replaceAll(RegExp(r'"'), '')
      .split(',')
      .toList(growable: false);
}
