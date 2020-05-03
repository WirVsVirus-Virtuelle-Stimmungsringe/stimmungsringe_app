import 'package:equatable/equatable.dart';

class UserMinimal extends Equatable {
  final String userId;
  final String displayName;
  final bool hasName;

  @override
  List<Object> get props => [userId, displayName, hasName];

  static UserMinimal fromJson(Map<String, dynamic> jsonMap) {
    return UserMinimal(
      jsonMap['userId'] as String,
      jsonMap['displayName'] as String,
      jsonMap['hasName'] as bool,
    );
  }

  const UserMinimal(this.userId, this.displayName, this.hasName);
}
