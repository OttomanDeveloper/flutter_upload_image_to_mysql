import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:uploadimagetosql/functions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String localmage = '';

  TextEditingController username = TextEditingController();
  TextEditingController fullName = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            'Upload image By OttomanCoder',
          ),
        ),
        body: SafeArea(
          child: SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const SizedBox(height: 5),
                  localmage.isNotEmpty
                      ? CircleAvatar(
                          radius: 60,
                          backgroundImage: MemoryImage(base64Decode(localmage)),
                        )
                      : const CircleAvatar(
                          radius: 60,
                        ),
                  const SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        TextField(
                          controller: username,
                          decoration: const InputDecoration(
                            hintText: 'Enter Username',
                          ),
                        ),
                        TextField(
                          controller: fullName,
                          decoration: const InputDecoration(
                            hintText: 'Enter fullName',
                          ),
                        ),
                        TextField(
                          controller: password,
                          decoration: const InputDecoration(
                            hintText: 'Enter passsword',
                          ),
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    color: Colors.green,
                    onPressed: () => chooseImage(),
                    child: const Text('Register'),
                  ),
                  MaterialButton(
                    color: Colors.red,
                    onPressed: () async {
                      var profileData =
                          await getUserProfile(username: username.text);
                      if (kDebugMode) {
                        print(profileData);
                      }
                      onlineImage = profileData[0]['image'];
                      user = profileData[0]['username'];
                      name = profileData[0]['fullName'];
                      pass = profileData[0]['password'];

                      setState(() {});
                    },
                    child: const Text('Get User Profile Data'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  onlineImage.isNotEmpty
                      ? Image.memory(base64Decode(onlineImage))
                      : const CircleAvatar(
                          radius: 60,
                        ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(user),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(name),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(pass),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String onlineImage = '';
  String user = '';
  String name = '';
  String pass = '';

  void chooseImage() async {
    localmage = await pickImage();
    setState(() {});
    // if (localmage != 'Error') {
    //   String status = await registration(
    //     image: localmage,
    //     password: password.text,
    //     fullname: fullName.text,
    //     username: username.text,
    //   );
    //   print(status);
    // }
  }
}
