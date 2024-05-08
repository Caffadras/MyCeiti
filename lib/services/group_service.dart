import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_ceiti/models/group_model.dart';
import 'package:my_ceiti/utils/uri_constants.dart';

class GroupService {
  final List<GroupModel> _cachedGroups = [];
  List<GroupModel> get cachedGroups => _cachedGroups;

  Future<List<GroupModel>> fetchGroups() async {
    if (_cachedGroups.isNotEmpty){
      return _cachedGroups;
    }
    List<GroupModel> allGroups = [];
    final response = await http
        .get(Uri.parse(UriConstants.groupUri))
        .timeout(const Duration(seconds: 2));

    var jsonResponse = jsonDecode(response.body);
    for (var group in jsonResponse) {
      allGroups.add(GroupModel.fromJson(group));
    }

    _cachedGroups.clear();
    _cachedGroups.addAll(allGroups);

    return _cachedGroups;
  }
}
