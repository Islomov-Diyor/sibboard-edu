class UserTask {
  final String id;
  final DateTime created;
  final Map<String, String> fields;

  const UserTask({
    required this.id,
    required this.created,
    required this.fields,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'created': created.toIso8601String(),
        'fields': fields,
      };

  factory UserTask.fromJson(Map<String, dynamic> json) {
    return UserTask(
      id: json['id'] as String,
      created: DateTime.parse(json['created'] as String),
      fields: Map<String, String>.from(json['fields'] as Map),
    );
  }
}
