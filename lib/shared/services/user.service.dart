import 'dart:io';

import 'package:cityton_mobile/http/ApiResponse.dart';
import 'package:cityton_mobile/http/http.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

var http = Http();

class UserService {
  Future<ApiResponse> getCurrentUser() async {
    var res = await http.get("authentication");

    return res;
  }

  Future<ApiResponse> changePassword(
      String oldPassword, String newPassword) async {
    var res = await http.post("user/changePassword", data: {
      "oldPassword": oldPassword,
      "newPassword": newPassword,
    });

    return res;
  }

  Future<ApiResponse> getProfile(int userId) async {
    var res = await http.get("user/getProfile/" + userId.toString());

    return res;
  }

  Future<ApiResponse> search(String search, int selectedRole) async {
    var res = await http.get("user/search", {
      "searchText": search,
      "selectedRole": selectedRole,
    });

    return res;
  }

  Future<ApiResponse> delete(int id) async {
    var res = await http.delete("user/delete/" + id.toString());

    return res;
  }

  Future<ApiResponse> changePictureProfile(File newProfilePicture) async {
    String fileName = newProfilePicture.path.split('/').last;

    FormData formdata = new FormData.fromMap({
      "file": await MultipartFile.fromFile(newProfilePicture.path,
          filename: fileName)
    });

    var res = await http.put("user/changeProfilePicture", data: formdata,
        onSendProgress: (int sent, int total) {
      print((sent / total * 100).toString() + "%");
    });
    return res;
  }
}