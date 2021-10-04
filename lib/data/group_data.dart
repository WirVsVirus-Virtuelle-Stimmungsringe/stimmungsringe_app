import 'package:equatable/equatable.dart';

class GroupData extends Equatable {
  final String groupId;
  final String groupName;
  final String groupCode;

  @override
  List<Object> get props => [groupId, groupName, groupCode];

  static GroupData fromJson(Map<String, dynamic> jsonMap) {
    return GroupData(
      jsonMap['groupId'] as String,
      jsonMap['groupName'] as String,
      jsonMap['groupCode'] as String,
    );
  }

  const GroupData(this.groupId, this.groupName, this.groupCode);
}
