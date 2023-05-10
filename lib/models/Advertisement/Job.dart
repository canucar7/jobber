class Job {
  int id;
  String name;
  String description;
  int priority;
  int isActive;
  DateTime? deletedAt;
  DateTime createdAt;
  DateTime updatedAt;

  Job({
    required this.id,
    required this.name,
    required this.description,
    required this.priority,
    required this.isActive,
    this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  Job.fromJson(Map<String, dynamic> json) :
      id= json['id'],
      name= json['name'],
      description= json['description'],
      priority= json['priority'],
      isActive= json['is_active'],
      deletedAt= json['deleted_at'] != null ? DateTime.parse(json['deleted_at']) : null,
      createdAt= DateTime.parse(json['created_at']),
      updatedAt= DateTime.parse(json['updated_at']);

}
