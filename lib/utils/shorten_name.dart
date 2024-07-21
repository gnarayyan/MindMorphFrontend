String shortenName(String name) {
  List<String> parts = name.split(' ');

  if (parts.length == 2) {
    // Case for names like "John Doe"
    return "${parts[0]} ${parts[1][0]}.";
  } else if (parts.length == 3) {
    // Case for names like "Mahesh Kumar Yadav"
    return "${parts[0]} ${parts[1][0]}.${parts[2][0]}.";
  } else if (parts.length == 4) {
    // Case for names like "Shyam B. Shrestha"
    return "${parts[0]} ${parts[1]} ${parts[2][0]}.";
  } else {
    // If the format is not recognized, return the name as is
    return name;
  }
}
