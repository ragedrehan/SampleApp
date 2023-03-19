import 'dart:convert';
import 'package:http/http.dart';
import 'package:sample/globle_files/network/network_requests.dart';
import 'package:sample/user_module/model/repuation_model.dart';
import 'package:sample/user_module/model/user_model.dart';

class UserRepository {
  final NetworkRequests networkRequests;
  List<UserModel> users = [];
  var hasMore = true;

  UserRepository(this.networkRequests);

  Future<List<UserModel>> fetchUsers(Map<String, dynamic> params) async {
    try {
      String tag = "fetchUsers";
      Response? response = await networkRequests.getRequest(
          endPointUrl: '/2.2/users?page=${params["page_no"]}&pagesize=30&site=stackoverflow');
      if (response.statusCode == 200) {
        GeneralUserModel data = GeneralUserModel.fromJson(
            json.decode(response.body));
        if (users.isEmpty) {
          users = data.userList ?? [];
        } else {
          users.addAll(data.userList ?? []);
        }
        hasMore = data.hasMore ?? false;
        return users;
      } else {
        throw Exception("${response.reasonPhrase}");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<ReputationModel>> fetchUserReputation(Map<String, dynamic> params) async {
    try {
    String tag = "fetchUserReputation";
    Response? response = await NetworkRequests().getRequest(endPointUrl: '/2.2/users/22656/reputation-history?page=1&pagesize=30&site=stackoverflow');
    if (response.statusCode == 200) {
      GeneralReputationModel data = GeneralReputationModel.fromJson(json.decode(response.body));
      List<ReputationModel> reputation = data.items;
      return reputation;
    } else {
      throw Exception("${response.reasonPhrase}");
    }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
