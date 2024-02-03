/// Get the ordinal suffix of a number.
String getOrdinalSuffix(int number) {
  if (number >= 11 && number <= 13) {
    return 'th';
  }
  switch (number % 10) {
    case 1:
      return 'st';
    case 2:
      return 'nd';
    case 3:
      return 'rd';
    default:
      return 'th';
  }
}
