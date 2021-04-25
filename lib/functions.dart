import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

String api = 'http://demo.bingertech.com/';
String uploadAPI = '$api/uploadImage.php';
String getAPI = '$api/getUserProfile.php';

Future<String> pickImage() async {
  PickedFile pickedFile;
  File file;
  ImagePicker imagePicker = ImagePicker();

  await Permission.photos.request();

  var permissionStatus = await Permission.photos.status;

  if (permissionStatus.isGranted) {
    pickedFile = await imagePicker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      file = File(pickedFile.path);

      String image = base64Encode(file.readAsBytesSync());
      return image;
    } else {
      print('Pick Image First');
      return 'Error';
    }
  } else {
    print('Give Permissions First');
    return 'Error';
  }
}

Future registration({
  @required String username,
  @required String fullname,
  @required String password,
  @required String image,
}) async {
  try {
    final response = await http.post(
      Uri.parse(uploadAPI),
      body: {
        'image': '$image',
        'username': '$username',
        'password': '$password',
        'fullName': '$fullname',
      },
    );

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      return result;
    } else {
      print('Error 1');
      return 'Error';
    }
  } catch (e) {
    return 'Error';
  }
}

Future getUserProfile({@required String username}) async {
  try {
    final response =
        await http.post(Uri.parse(getAPI), body: {'username': '$username'});

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      return result;
    } else {
      print('Error 1');
      return 'Error';
    }
  } catch (e) {
    return 'Error';
  }
}
