import 'package:built_collection/built_collection.dart';
import 'package:equatable/equatable.dart';

class AvailableAvatars extends Equatable {
  final BuiltList<String> stockAvatars;

  @override
  List<Object> get props => [stockAvatars];

  static AvailableAvatars fromJson(Map<String, dynamic> jsonMap) {
    return AvailableAvatars(
      BuiltList.of(
        (jsonMap['stockAvatars'] as List<dynamic>).map(
          (dynamic stockAvatar) => stockAvatar as String,
        ),
      ),
    );
  }

  const AvailableAvatars(this.stockAvatars);
}
