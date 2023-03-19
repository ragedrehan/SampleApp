import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sample/globle_files/network/network_requests.dart';
import 'package:sample/user_module/repository/user_repository.dart';
import 'unit_test.mocks.dart';

@GenerateMocks([NetworkRequests])
main() {
  group('UserRepository', () {
    late UserRepository userRepository;
    late NetworkRequests mockNetworkRequests;

    setUp(() {
      mockNetworkRequests = MockNetworkRequests();
      userRepository = UserRepository(mockNetworkRequests);
    });

    test('fetchUsers returns a empty list of users', () async {
      final response = Response('{}', 200);
      when(mockNetworkRequests.getRequest(endPointUrl: '/2.2/users?page=1&pagesize=30&site=stackoverflow'))
          .thenAnswer((_) async => response);
      final users = await userRepository.fetchUsers({'page_no': 1});
      expect(users.isEmpty, true);
    });



    test('fetchUsers returns a empty list of users', () async {
      final response = Response(
        json.encode({
          'items': [
            {
              'user_id': 123,
              'display_name': 'John Doe',
              'profile_image': 'https://example.com/johndoe.jpg',
              'location': 'New York',
            },
            {
              'user_id': 456,
              'display_name': 'Jane Smith',
              'profile_image': 'https://example.com/janesmith.jpg',
              'location': 'Los Angeles',
            },
          ],
          'has_more': true,
          'quota_max': 10000,
          'quota_remaining': 9999,
        }),
        200,
      );

      when(mockNetworkRequests.getRequest(endPointUrl: '/2.2/users?page=1&pagesize=30&site=stackoverflow'))
          .thenAnswer((_) async => response);
      final users = await userRepository.fetchUsers({'page_no': 1});
      expect(users.isEmpty, false);
    });

  });
}