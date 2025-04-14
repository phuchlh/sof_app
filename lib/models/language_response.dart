import 'package:sof_app/models/language_model.dart';

class LanguageResponse {
  List<LanguageModel>? items;
  bool? hasMore;
  int? quotaMax;
  int? quotaRemaining;

  LanguageResponse({
    this.items,
    this.hasMore,
    this.quotaMax,
    this.quotaRemaining,
  });

  LanguageResponse.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <LanguageModel>[];
      json['items'].forEach((v) {
        items!.add(LanguageModel.fromJson(v));
      });
    }
    hasMore = json['has_more'];
    quotaMax = json['quota_max'];
    quotaRemaining = json['quota_remaining'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    data['has_more'] = hasMore;
    data['quota_max'] = quotaMax;
    data['quota_remaining'] = quotaRemaining;
    return data;
  }
}
