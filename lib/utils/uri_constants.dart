class UriConstants{
  static const String groupUri = "https://orar-api.ceiti.md/v1/grupe";
  static const String loginUri = "https://api.ceiti.md/date/login";
  static String getGradesUri(String idnp) {
    return "https://api.ceiti.md/index.php/date/info/$idnp";
  }
  static String getScheduleUri(String id) {
    return "https://orar-api.ceiti.md/v1/orar?_id=$id&tip=class";
  }
}