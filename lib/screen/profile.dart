import 'dart:convert';

import 'package:emp/model/employee.dart';
import 'package:emp/utils/constant.dart';
import 'package:emp/utils/prefs.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Profile extends StatefulWidget {
  const Profile({Key key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Employee employee;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            buildUserInfoDisplay(employee.employeeName, "Name"),
            buildUserInfoDisplay(employee.email, "Email"),
            buildUserInfoDisplay(employee.dateOfBirth, "DOB"),
            buildUserInfoDisplay(employee.startDate, "Start Date"),
            buildUserInfoDisplay(employee.dateOfHire, "DOH"),
            buildUserInfoDisplay(
                employee.socialInsuranceNumber, "Social Insurance Number"),
            buildUserInfoDisplay(
                employee.employeeContactForm, "Employee Contact Form"),
            buildUserInfoDisplay(
                employee.employeeCourseName, "Employee Course Name"),
            buildUserInfoDisplay(
                employee.employeeCourseDate, "Employee Course Date"),
            buildUserInfoDisplay(employee.employeeCertificateOfCourse,
                "Employee Certificate Of   Course"),
            buildUserInfoDisplay(
                employee.diciplinaryActionNote, "Disciplinary Action Note"),
            buildUserInfoDisplay(employee.diciplinaryForm, "Disciplinary Form"),
            buildUserInfoDisplay(employee.assetOnHand, "Asset On Hand"),
          ],
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
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
          const SizedBox(
            height: 1,
          ),
          Container(
              width: MediaQuery.of(context).size.width,
              height: 40,
              decoration: const BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                color: Colors.grey,
                width: 1,
              ))),
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
    setState(() {
      employee = Employee.fromJson(jsonDecode(response.body));
    });
  }
}
