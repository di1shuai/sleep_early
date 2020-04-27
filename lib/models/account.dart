import 'dart:convert';

class Account {
  int id;
  String nickname;

  Account({
    this.id,
    this.nickname,
  });

  Account copyWith({
    int id,
    String nickname,
  }) {
    return Account(
      id: id ?? this.id,
      nickname: nickname ?? this.nickname,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nickname': nickname,
    };
  }

  static Account fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return Account(
      id: map['id'],
      nickname: map['nickname'],
    );
  }

  String toJson() => json.encode(toMap());

  static Account fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() => 'Account(id: $id, nickname: $nickname)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is Account &&
      o.id == id &&
      o.nickname == nickname;
  }

  @override
  int get hashCode => id.hashCode ^ nickname.hashCode;
}
