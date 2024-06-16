import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_ceiti/models/example_response.dart';
import 'package:my_ceiti/models/grades/semester_model.dart';
import 'package:my_ceiti/models/group_model.dart';
import 'package:my_ceiti/services/parser_service.dart';
import 'package:my_ceiti/utils/uri_constants.dart';

class GradesService {
  final ParserService parserService = ParserService();
  List<GroupModel>? _cachedGroups;

  Future<void> performLogin(String idnp) async {
    print("###performing login");
    final Map<String, String> requestBody = {"idnp": idnp};
    http.Response response = await http
        .post(
          Uri.parse(UriConstants.loginUri),
          body: requestBody,
          //headers: {"Content-Type":"application/json; charset=UTF-8"},
        )
        .timeout(const Duration(seconds: 10));

    print(response.body);
    try {
      print("###grades reqeust");

      var setCookieKey = "set-cookie";
      String? setCookieHeader = response.headers[setCookieKey];
      print(setCookieHeader);
      print(response.headers);
      if (setCookieHeader != null){
        // Cookie cookie = Cookie("ci_session", parseSetCookieHeader(setCookieHeader));
        // cookie.httpOnly = false;
        // http.CookieJar();
        // print("*** ${cookie.toString()}");
        response = await http.get(
          Uri.parse(UriConstants.getGradesUri(idnp)),
          headers: {"cookie" :parseSetCookieHeader(setCookieHeader)},
          // headers: {"cookie" : cookie.toString()},
        ).timeout(const Duration(seconds: 10));

        print("##########");
        print(response.body.length);

      }
    } on Error catch(e){
      print(e);
    }
  }

  Future<SemesterModel> parse() async{
    return await parserService.parseResponse(ExampleResponse.exampleResponse2, false);
  }

  
  String parseSetCookieHeader(String setCookieHeader){
    print("actual coockie ${setCookieHeader}");
    var result = setCookieHeader.substring(setCookieHeader.indexOf("ci_session", 1));
    print("actual result ${result}");

    return result;
  }

  Future<List<GroupModel>> fetchGroups() async {
    print("### fetching groups");
    if (_cachedGroups != null) {
      return _cachedGroups!;
    }
    List<GroupModel> allGroups = [];
    final response = await http
        .get(Uri.parse(UriConstants.groupUri))
        .timeout(const Duration(seconds: 2));

    // print("### finished getting the response");
    // print(response.body);
    var jsonResponse = jsonDecode(response.body);
    // print("#### finished json");
    var i = 0;
    for (var group in jsonResponse) {
      ++i;
      allGroups.add(GroupModel.fromJson(group));
    }
    print("##### GROUP COUNT: $i");
    _cachedGroups = allGroups;
    return allGroups;
  }
}
