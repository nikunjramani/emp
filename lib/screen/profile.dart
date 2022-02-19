import 'dart:convert';

import 'package:emp/model/employee.dart';
import 'package:emp/utils/constant.dart';
import 'package:emp/utils/prefs.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../main.dart';

class Profile extends StatefulWidget {
  const Profile({Key key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Employee employee;

  @override
  void initState() {
    getUserProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange[400],
        title: Text("Profile"),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: employee != null
                ? Column(
                    children: [
                      buildUserInfoDisplay(employee.employeeName ?? '', "Name"),
                      buildUserInfoDisplay(employee.email ?? '', "Email"),
                      buildUserInfoDisplay(employee.dateOfBirth ?? '', "DOB"),
                      buildUserInfoDisplay(
                          employee.startDate ?? '', "Start Date"),
                      buildUserInfoDisplay(employee.dateOfHire ?? '', "DOH"),
                      buildUserInfoDisplay(employee.socialInsuranceNumber ?? '',
                          "Social Insurance Number"),
                      buildUserInfoDisplay(employee.employeeContactForm ?? '',
                          "Employee Contact Form"),
                      buildUserInfoDisplay(employee.employeeCourseName ?? '',
                          "Employee Course Name"),
                      buildUserInfoDisplay(employee.employeeCourseDate ?? '',
                          "Employee Course Date"),
                      buildUserInfoDisplay(
                          employee.employeeCertificateOfCourse ?? '',
                          "Employee Certificate Of   Course"),
                      buildUserInfoDisplay(employee.diciplinaryActionNote ?? '',
                          "Disciplinary Action Note"),
                      buildUserInfoDisplay(
                          employee.diciplinaryForm ?? '', "Disciplinary Form"),
                      buildUserInfoDisplay(
                          employee.assetOnHand ?? '', "Asset On Hand"),
                      TextButton(
                          onPressed: () async {
                            await PrefsService.saveBool(prefIsUserLogin, false);
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => MyApp()),
                            );
                          },
                          child: Container(
                            height: 50,
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.only(left: 10),
                            child: Text(
                              "Logout",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 217, 113, 11),
                              borderRadius: BorderRadius.circular(5),
                            ),
                          )),
                    ],
                  )
                : Container(),
          ),
        ),
      ),
    );
  }

  Widget buildUserInfoDisplay(String getValue, String title) => Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.black54,
            ),
          ),
          const SizedBox(
            height: 1,
          ),
          Container(
              padding: EdgeInsets.only(left: 10),
              alignment: Alignment.centerLeft,
              width: MediaQuery.of(context).size.width,
              height: 40,
              decoration: BoxDecoration(
                color: const Color.fromARGB(100, 211, 211, 211),
                border: Border.all(
                  color: const Color.fromARGB(100, 211, 211, 211),
                ),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                getValue,
                style: const TextStyle(fontSize: 16, height: 1.4),
              )),
        ],
      ));

  Future<void> getUserProfile() async {
    var orderUrl = Uri.parse(url + 'getProfile');
    var response = await http.get(orderUrl, headers: {
      'Authorization': "Bearer " + await PrefsService.getStringl(prefTokenKey),
    });
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    var data = await jsonDecode(response.body);
    setState(() {
      employee = Employee.fromJson(data['data']);
    });
  }
}
