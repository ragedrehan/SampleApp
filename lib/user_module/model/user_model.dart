
class GeneralUserModel {
  List<UserModel>? userList;
  bool? hasMore;
  int? quotaMax;
  int? quotaRemaining;

  GeneralUserModel.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      userList = <UserModel>[];
      json['items'].forEach((v) {
        userList!.add(UserModel.fromJson(v));
      });
    }
    hasMore = json['has_more'];
    quotaMax = json['quota_max'];
    quotaRemaining = json['quota_remaining'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (userList != null) {
      data['items'] = userList!.map((v) => v.toJson()).toList();
    }
    data['has_more'] = hasMore;
    data['quota_max'] = quotaMax;
    data['quota_remaining'] = quotaRemaining;
    return data;
  }
}

class UserModel {
  int? id;
  String? name;
  String? avatar;
  String? location;
  bool isBookmark = false;

  UserModel(this.id, this.name, this.avatar, this.location,
      {this.isBookmark = false});

  UserModel.copyWith(UserModel user) {
    UserModel(
      user.id ?? id,
      user.name ?? name,
      user.avatar ?? avatar,
      user.location ?? location,
      isBookmark: user.isBookmark,
    );
  }

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['user_id'] ?? 0;
    name = json['display_name'] ?? "";
    avatar = json['profile_image'] ?? "";
    location = json['location'] ?? "";
  }

  UserModel.fromDBJson(Map<String, dynamic> json) {
    id = json['user_id'] ?? 0;
    name = json['display_name'] ?? "";
    avatar = json['profile_image'] ?? "";
    location = json['location'] ?? "";
    isBookmark = true;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = id;
    data['display_name'] = name;
    data['profile_image'] = avatar;
    data['location'] = location;
    return data;
  }
}
