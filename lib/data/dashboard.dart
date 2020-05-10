import 'package:built_collection/built_collection.dart';
import 'package:equatable/equatable.dart';
import 'package:familiarise/data/group_data.dart';
import 'package:familiarise/data/my_tile.dart';
import 'package:familiarise/data/other_tile.dart';

class Dashboard extends Equatable {
  final MyTile myTile;
  final BuiltList<OtherTile> otherTiles;
  final GroupData groupData;

  @override
  List<Object> get props => [myTile, otherTiles, groupData];

  static Dashboard fromJson(Map<String, dynamic> jsonMap) {
    return Dashboard(
      MyTile.fromJson(jsonMap['myTile'] as Map<String, dynamic>),
      BuiltList.of(
        (jsonMap['otherTiles'] as List<dynamic>).map(
          (dynamic otherTile) =>
              OtherTile.fromJson(otherTile as Map<String, dynamic>),
        ),
      ),
      jsonMap['groupData'] != null
          ? GroupData.fromJson(jsonMap['groupData'] as Map<String, dynamic>)
          : null,
    );
  }

  const Dashboard(this.myTile, this.otherTiles, this.groupData);

  Dashboard copyWith(
      {MyTile myTile, BuiltList<OtherTile> otherTiles, GroupData groupData}) {
    return Dashboard(
      myTile ?? this.myTile,
      otherTiles ?? this.otherTiles,
      groupData ?? this.groupData,
    );
  }
}
