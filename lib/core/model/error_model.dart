class ErrorModel {
  ErrorModel({this.error});

  ErrorModel.fromJson(dynamic json) {
    error = json['error'] != null ? Error.fromJson(json['error']) : null;
  }

  Error error;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (error != null) {
      data['error'] = error.toJson();
    }
    return data;
  }
}

class Error {
  Error({this.type, this.param, this.message});

  Error.fromJson(dynamic json) {
    type = json['type'] as String;
    param = json['param'] as String;
    message = json['message'] as String;
  }

  String type;
  String param;
  String message;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['param'] = param;
    data['message'] = message;
    return data;
  }
}
