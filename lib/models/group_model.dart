class GroupModel {
  final Map<String, dynamic> _originalJson;
  final String id;
  final String name;

  GroupModel(this._originalJson, {required this.id, required this.name});

  factory GroupModel.fromJson(Map<String, dynamic> json) {
    return GroupModel(
      json,
      id: json['_id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson(){
    return _originalJson;
  }
}
