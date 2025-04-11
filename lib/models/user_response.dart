import 'package:equatable/equatable.dart';
import 'package:sof_app/models/user_model.dart';

class UserResponse extends Equatable {
  final List<UserModel>? items;
  final bool? hasMore;
  final int? quotaMax;
  final int? quotaRemaining;

  const UserResponse({
    this.items,
    this.hasMore,
    this.quotaMax,
    this.quotaRemaining,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
    items:
        json['items'] != null
            ? (json['items'] as List).map((v) => UserModel.fromJson(v)).toList()
            : null,
    hasMore: json['has_more'],
    quotaMax: json['quota_max'],
    quotaRemaining: json['quota_remaining'],
  );

  Map<String, dynamic> toJson() => {
    'items': items?.map((v) => v.toJson()).toList(),
    'has_more': hasMore,
    'quota_max': quotaMax,
    'quota_remaining': quotaRemaining,
  };

  @override
  List<Object?> get props => [items, hasMore, quotaMax, quotaRemaining];
}
