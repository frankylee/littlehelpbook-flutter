/// Convert a text array into a proper string list.
List<String> convertTextToList(String? text) {
  if (text == null || text.substring(1, text.length - 1).isEmpty) {
    return List.empty(growable: false);
  }
  return text
      .substring(1, text.length - 1)
      .replaceAll(RegExp(r'"'), '')
      .split(',')
      .toList(growable: false);
}
