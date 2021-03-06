import 'package:cityton_mobile/http/ApiResponse.dart';
import 'package:cityton_mobile/shared/blocs/auth.bloc.dart';
import 'package:cityton_mobile/shared/services/group.service.dart';
import 'package:cityton_mobile/shared/services/user.service.dart';
import 'package:cityton_mobile/models/user.dart';

class CreateGroupBloc {
  final GroupService _groupService = GroupService();
  final UserService _userService = UserService();
  final AuthBloc _authBloc = AuthBloc();

  Future<ApiResponse> add(String name) async {
    String sanitizedName = name.trim();

    var response = await _groupService.add(sanitizedName);

    return response;
  }
}
