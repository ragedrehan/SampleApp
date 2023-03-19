class GeneralReputationModel{
  List<ReputationModel> items = [];
  bool? hasMore;
  int? quotaMax;
  int? quotaRemaining;

  GeneralReputationModel({this.items =const [], this.hasMore, this.quotaMax, this.quotaRemaining});

  GeneralReputationModel.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <ReputationModel>[];
      json['items'].forEach((v) {
        items!.add(ReputationModel.fromJson(v));
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

class ReputationModel {
  String? reputationHistoryType;
  int? reputationChange;
  int? postId;
  int? creationDate;
  int? userId;

  ReputationModel(
      {this.reputationHistoryType,
        this.reputationChange,
        this.postId,
        this.creationDate,
        this.userId});

  ReputationModel.fromJson(Map<String, dynamic> json) {
    reputationHistoryType = json['reputation_history_type'];
    reputationChange = json['reputation_change'];
    postId = json['post_id'];
    creationDate = json['creation_date'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['reputation_history_type'] = reputationHistoryType;
    data['reputation_change'] = reputationChange;
    data['post_id'] = postId;
    data['creation_date'] = creationDate;
    data['user_id'] = userId;
    return data;
  }
}