import 'dart:convert';

import 'package:http/http.dart';
import 'package:my_ceiti/models/group_model.dart';
import 'package:http/http.dart' as http;
import 'package:my_ceiti/utils/uri_constants.dart';

class GroupService {
  List<GroupModel>? _cachedGroups;

  Future<List<GroupModel>> fetchGroups() async {
    print("### fetching groups");
    if (_cachedGroups != null){
      return _cachedGroups!;
    }
    List<GroupModel> allGroups = [];
    final response = await http
        .get(Uri.parse(UriConstants.groupUri))
        .timeout(const Duration(seconds: 2));

    print("### finished getting the response");
    // print(response.body);
    var jsonResponse = jsonDecode(response.body);
    print("#### finished json");
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
