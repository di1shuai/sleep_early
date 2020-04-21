import 'dart:convert';

class Account {
  int id;

  Account({
    this.id,
  });

  Account copyWith({
    int id,
  }) {
    return Account(
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
    };
  }

  static Account fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return Account(
      id: map['id'],
    );
  }

  String toJson() => json.encode(toMap());

  static Account fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() => 'Account(id: $id)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Account && o.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
