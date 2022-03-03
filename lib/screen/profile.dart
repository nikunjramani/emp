import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:emp/model/employee.dart';
import 'package:emp/utils/constant.dart';
import 'package:emp/utils/prefs.dart';
import 'package:ext_storage/ext_storage.dart';
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
  String path;
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
        title: const Text("Profile"),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(10),
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
                            download2(Dio(), url + employee.employeeContactForm,
                                path+"/employeeContactForm.pdf");
                          },
                          child: Container(
                            height: 50,
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.only(left: 10),
                            child: const Text(
                              "Download Employee Contact Form",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 217, 113, 11),
                              borderRadius: BorderRadius.circular(5),
                            ),
                          )),
                      TextButton(
                          onPressed: () async {
                            download2(
                                Dio(),
                                url + employee.employeeCertificateOfCourse,
                                path+"/employeeCertificateOfCourse.pdf");
                          },
                          child: Container(
                            height: 50,
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.only(left: 10),
                            child: const Text(
                              "Download Employee Certificate of Course",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 217, 113, 11),
                              borderRadius: BorderRadius.circular(5),
                            ),
                          )),
                      TextButton(
                          onPressed: () async {
                            download2(
                                Dio(), url + employee.diciplinaryForm, path+"/diciplinaryForm.pdf");
                          },
                          child: Container(
                            height: 50,
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.only(left: 10),
                            child: const Text(
                              "Disciplinary Form",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 217, 113, 11),
                              borderRadius: BorderRadius.circular(5),
                            ),
                          )),
                      TextButton(
                          onPressed: () async {
                            await PrefsService.saveBool(prefIsUserLogin, false);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const MyApp()),
                            );
                          },
                          child: Container(
                            height: 50,
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.only(left: 10),
                            child: const Text(
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
              padding: const EdgeInsets.only(left: 10),
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
    path = await ExtStorage.getExternalStoragePublicDirectory(
        ExtStorage.DIRECTORY_DOWNLOADS);
  }

  Future download2(Dio dio, String url, String savePath) async {
    try {
      Response response = await dio.get(
        url,
        options: Options(
            responseType: ResponseType.bytes,
            followRedirects: false,
            validateStatus: (status) {
              return status < 500;
            }),
      );
      print(response.headers);
      File file = File(savePath);
      var raf = file.openSync(mode: FileMode.write);
      // response.data is List<int> type
      raf.writeFromSync(response.data);
      await raf.close();
    } catch (e) {
      print(e);
    }
  }
}
