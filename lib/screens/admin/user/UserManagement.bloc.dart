import 'package:cityton_mobile/models/userProfile.dart';
import 'package:cityton_mobile/shared/services/user.service.dart';
import 'package:rxdart/rxdart.dart';

class UserManagementBloc {
  final UserService _userService = UserService();

  final _userProfilesFetcher =
      BehaviorSubject<List<UserProfile>>.seeded(List<UserProfile>());
  Stream<List<UserProfile>> get userProfiles => _userProfilesFetcher.stream;

  closeUserProfilesStream() {
    _userProfilesFetcher.close();
  }

  Future<void> search(String searchText, int selectedRole) async {
    String sanitizedSearchText = searchText?.trim();
    
    var response = await _userService.search(sanitizedSearchText, selectedRole == -1 ? null : selectedRole);
    
    UserProfileList userProfileList = UserProfileList.fromJson(response.value);

    List<UserProfile> userProfiles = userProfileList.userProfiles;

    _userProfilesFetcher.sink.add(userProfiles);
  }
}
