import 'package:built_collection/built_collection.dart';
import 'package:equatable/equatable.dart';
import 'package:familiarise/config.dart';

class AvailableAvatars extends Equatable {
  final BuiltList<StockAvatar> stockAvatars;

  @override
  List<Object> get props => [stockAvatars];

  static AvailableAvatars fromJson(Map<String, dynamic> jsonMap) {
    return AvailableAvatars(
      BuiltList.of(
        (jsonMap['stockAvatars'] as List<dynamic>).map(
          (dynamic stockAvatar) =>
              StockAvatar.fromJson(stockAvatar as Map<String, dynamic>),
        ),
      ),
    );
  }

  const AvailableAvatars(this.stockAvatars);
}

class StockAvatar extends Equatable {
  final String avatarName;
  final String _avatarUrl;

  @override
  List<Object> get props => [avatarName, _avatarUrl];

  static StockAvatar fromJson(Map<String, dynamic> jsonMap) {
    return StockAvatar(
      jsonMap['avatarName'] as String,
      jsonMap['avatarUrl'] as String,
    );
  }

  const StockAvatar(this.avatarName, this._avatarUrl);

  String get avatarUrl {
    return _avatarUrl == null ? null : Config().backendUrl + _avatarUrl;
  }
}
