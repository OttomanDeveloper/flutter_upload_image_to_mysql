import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:uploadimagetosql/functions.dart';

void main() {
  runApp(
    MyApp(),
  );
}

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

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
          title: Text(
            'Upload image By OttomanCoder',
          ),
        ),
        body: SafeArea(
          child: Container(
            height: double.infinity,
            width: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(height: 5),
                  localmage.isNotEmpty
                      ? CircleAvatar(
                          radius: 60,
                          backgroundImage: MemoryImage(
                            base64Decode(localmage),
                          ),
                        )
                      : CircleAvatar(
                          radius: 60,
                        ),
                  SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        TextField(
                          controller: username,
                          decoration: InputDecoration(
                            hintText: 'Enter Username',
                          ),
                        ),
                        TextField(
                          controller: fullName,
                          decoration: InputDecoration(
                            hintText: 'Enter fullName',
                          ),
                        ),
                        TextField(
                          controller: password,
                          decoration: InputDecoration(
                            hintText: 'Enter passsword',
                          ),
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    color: Colors.green,
                    onPressed: () => chooseImage(),
                    child: Text('Register'),
                  ),
                  MaterialButton(
                    color: Colors.red,
                    onPressed: () async {
                      var profileData =
                          await getUserProfile(username: username.text);

                      print(profileData);
                      onlineImage = profileData[0]['image'];
                      user = profileData[0]['username'];
                      name = profileData[0]['fullName'];
                      pass = profileData[0]['password'];

                      setState(() {});
                    },
                    child: Text('Get User Profile Data'),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  onlineImage.isNotEmpty
                      ? Image.memory(base64Decode(onlineImage))
                      : CircleAvatar(
                          radius: 60,
                        ),
                  SizedBox(
                    height: 20,
                  ),
                  Text('$user'),
                  SizedBox(
                    height: 20,
                  ),
                  Text('$name'),
                  SizedBox(
                    height: 20,
                  ),
                  Text('$pass'),
                  SizedBox(
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

  chooseImage() async {
    localmage = await pickImage();
    setState(() {});
    if (localmage != 'Error') {
      String status = await registration(
        image: localmage,
        password: password.text,
        fullname: fullName.text,
        username: username.text,
      );
      print(status);
    }
  }
}
