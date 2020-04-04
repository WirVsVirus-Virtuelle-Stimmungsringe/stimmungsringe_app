import 'package:equatable/equatable.dart';

class UserMinimal extends Equatable {
  String userId;
  String displayName;

  UserMinimal.fromJson(Map<String, dynamic> jsonMap) {
    this.userId = jsonMap['userId'];
    this.displayName = jsonMap['displayName'];
  }

  @override
  List<Object> get props => [userId, displayName];
}
