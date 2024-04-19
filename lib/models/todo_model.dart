import 'dart:convert';

class TodoModel {
  int id;
  String desc;
  bool complete;
  TodoModel({
    required this.id,
    required this.desc,
    required this.complete,
  });

  TodoModel copyWith({
    int? id,
    String? desc,
    bool? complete,
  }) {
    return TodoModel(
      id: id ?? this.id,
      desc: desc ?? this.desc,
      complete: complete ?? this.complete,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'desc': desc,
      'complete': complete,
    };
  }

  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(
      id: map['id'] as int,
      desc: map['desc'] as String,
      complete: map['complete'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory TodoModel.fromJson(String source) =>
      TodoModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'TodoModel(id: $id, desc: $desc, complete: $complete)';

  @override
  bool operator ==(covariant TodoModel other) {
    if (identical(this, other)) return true;

    return other.id == id && other.desc == desc && other.complete == complete;
  }

  @override
  int get hashCode => id.hashCode ^ desc.hashCode ^ complete.hashCode;
}
