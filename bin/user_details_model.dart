// import 'package:freezed_annotation/freezed_annotation.dart';
//
// part 'user_details_model.freezed.dart';
// part 'user_details_model.g.dart';
//
// @freezed
// class UserDetails with _$UserDetails {
//   const factory UserDetails({
//     required int? id,
//     required String? firstName,
//     required String? lastName,
//     required int? age,
//     required String? birthYear,
//     required String? nationality,
//   }) = _UserDetails;
//
//   factory UserDetails.fromJson(Map<String, dynamic> json) =>
//       _$UserDetailsFromJson(json);
// }
//
// extension UserDetailsApi on UserDetails {
//   Map<String, dynamic> toApiJson() {
//     return {
//       "name": "${firstName ?? ''} ${lastName ?? ''}".trim(),
//       "data": toJson()
//     };
//   }
// }

import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_details_model.freezed.dart';
part 'user_details_model.g.dart';

@freezed
class UserDetails with _$UserDetails {
  const factory UserDetails({
    String? id,
    String? name,
    String createdAt,
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
