import 'dart:convert';

class APIResponse {

  int code;

  dynamic data;

  Error error;

  APIResponse({
    this.code,
    this.data,
    this.error,
  });
  
  APIResponse copyWith({
    int code,
    dynamic data,
    Error error,
  }) {
    return APIResponse(
      code: code ?? this.code,
      data: data ?? this.data,
      error: error ?? this.error,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'code': code,
      'data': data,
      'error': error.toMap(),
    };
  }

  static APIResponse fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return APIResponse(
      code: map['code'],
      data: map['data'],
      error: Error.fromMap(map['error']),
    );
  }

  String toJson() => json.encode(toMap());

  static APIResponse fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() => 'APIResponse(code: $code, data: $data, error: $error)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is APIResponse &&
      o.code == code &&
      o.data == data &&
      o.error == error;
  }

  @override
  int get hashCode => code.hashCode ^ data.hashCode ^ error.hashCode;
}


class Error {

  String code;

  String message;
  
  Error({
    this.code,
    this.message,
  });


  Error copyWith({
    String code,
    String message,
  }) {
    return Error(
      code: code ?? this.code,
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'code': code,
      'message': message,
    };
  }

  static Error fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return Error(
      code: map['code'],
      message: map['message'],
    );
  }

  String toJson() => json.encode(toMap());

  static Error fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() => 'Error(code: $code, message: $message)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is Error &&
      o.code == code &&
      o.message == message;
  }

  @override
  int get hashCode => code.hashCode ^ message.hashCode;
}
