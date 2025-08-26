import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_details_model.freezed.dart';
part 'user_details_model.g.dart';

@freezed
class UserDetails with _$UserDetails {
  const factory UserDetails({
    String? id,
    String? name,
    String? createdAt,
    UserData? data,
  }) = _UserDetails;

  factory UserDetails.fromJson(Map<String, dynamic> json) =>
      _$UserDetailsFromJson(json);
}

@freezed
class UserData with _$UserData {
  const factory UserData({
    String? userId,
    String? firstName,
    String? lastName,
    int? age,
    String? birthYear,
    String? nationality,
  }) = _UserData;

  factory UserData.fromJson(Map<String, dynamic> json) =>
      _$UserDataFromJson(json);
}
