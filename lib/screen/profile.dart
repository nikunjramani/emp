import 'package:emp/model/employee.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({Key key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Employee employee;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          buildUserInfoDisplay(employee.employeeName, "Name"),
          buildUserInfoDisplay(employee.email, "Email"),
          buildUserInfoDisplay(employee.dateOfBirth, "DOB"),
          buildUserInfoDisplay(employee.dateOfHire, "DOH"),
        ],
      ),
    );
  }
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
            width: 350,
            height: 40,
            decoration: const BoxDecoration(
                border: Border(
                    bottom: BorderSide(
              color: Colors.grey,
              width: 1,
            ))),
            child: Row(children: [
              Expanded(
                  child: TextButton(
                      onPressed: () {},
                      child: Text(
                        getValue,
                        style: const TextStyle(fontSize: 16, height: 1.4),
                      ))),
              const Icon(
                Icons.keyboard_arrow_right,
                color: Colors.grey,
                size: 40.0,
              )
            ]))
      ],
    ));
