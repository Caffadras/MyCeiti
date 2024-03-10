class UriConstants{
  static const String groupUri = "https://orar-api.ceiti.md/v1/grupe";
  static String getScheduleUri(String id) {
    return "https://orar-api.ceiti.md/v1/orar?_id=$id&tip=class";
  }
}