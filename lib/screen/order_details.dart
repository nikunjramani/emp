import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:emp/model/order.dart';
import 'package:emp/utils/constant.dart';
import 'package:emp/utils/prefs.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class OrderDetails extends StatefulWidget {
  Data data;
  OrderDetails(this.data, {Key key}) : super(key: key);

  @override
  _OrderDetailsState createState() => _OrderDetailsState(this.data);
}

class _OrderDetailsState extends State<OrderDetails> {
  Data data;
  _OrderDetailsState(this.data);
  var items = [
    'On The Way',
    'Check In',
    'Complete',
  ];
  String dropdownvalue = 'On The Way';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange[400],
        title: Text("Order Details"),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildUserInfoDisplay(
                    title: "Service Title", value: data.serviceTitle),
                buildUserInfoDisplay(
                    title: "Service Schedule", value: data.serviceSchedule),
                buildUserInfoDisplay(
                    title: "Manage Of WorkOrder",
                    value: data.manageOfWorkOrder),
                buildUserInfoDisplay(
                    title: "Assigned Provider", value: data.assignedProvider),
                buildUserInfoDisplay(
                    title: "Service Location", value: data.serviceLocation),
                buildUserInfoDisplay(title: "Order Id", value: data.orderId),
                buildUserInfoDisplay(
                    title: "Traning Link", value: data.traningLink),
                buildUserInfoDisplay(
                    title: "Help Desk Contact", value: data.helpDeskContact),
                buildUserInfoDisplay(
                    title: "Manager On Duty", value: data.managerOnDuty),
                buildUserInfoDisplay(
                    title: "Orientation Keyword",
                    value: data.orientationKeyword),
                ListView.builder(
                    shrinkWrap: true,
                    itemCount:
                        data.customField != null ? data.customField.length : 0,
                    itemBuilder: (context, index) {
                      return buildUserInfoDisplay(
                          title: data.customField[index].title,
                          value: data.customField[index].value);
                    }),
                buildDropDownSelector(value: getStatus(data.status)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Upload File",
                      style: TextStyle(
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
                      child: TextButton(
                          onPressed: () {
                            uploadFile();
                          },
                          child: Container(child: Text("Upload File"))),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  String getStatus(String status) {
    if (status == "on_the_way") {
      return "On The Way";
    } else if (status == "check_in") {
      return "Check In";
    } else {
      return "Complete";
    }
  }

  String getHttpStatus(String status) {
    if (status == "On The Way") {
      return "on_the_way";
    } else if (status == "Check In") {
      return "check_in";
    } else {
      return "complate";
    }
  }

  Future<void> uploadFile() async {
    final ImagePicker _picker = ImagePicker();
    FilePickerResult result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File file = File(result.files.single.path);
      var formData = FormData.fromMap({
        'order_id': data.id.toString(),
        'type': 'image',
        'file': await MultipartFile.fromFile(file.path,
            filename: file.path.split('/').last),
      });
      Response<Map> response = await Dio().post(url + 'orderDocument',
          data: formData,
          options: Options(headers: {
            'Authorization':
                "Bearer " + await PrefsService.getStringl(prefTokenKey),
          }));
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.data}');
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(response.data["message"])));
    } else {
      // User canceled the picker
    }
    final XFile image = await _picker.pickImage(source: ImageSource.gallery);
  }

  Widget buildDropDownSelector({String value}) => Container(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Status",
            style: TextStyle(
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
            decoration: BoxDecoration(
              color: const Color.fromARGB(100, 211, 211, 211),
              border: Border.all(
                color: const Color.fromARGB(100, 211, 211, 211),
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            child: DropdownButton(
              value: dropdownvalue,
              icon: const Icon(Icons.keyboard_arrow_down),
              items: items.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
              onChanged: (String newValue) {
                setState(() {
                  dropdownvalue = newValue;
                  data.status = getHttpStatus(newValue);
                });
                changeOrderStatus();
              },
            ),
          ),
        ],
      ));

  Future<void> changeOrderStatus() async {
    String status = getHttpStatus(dropdownvalue);

    Map body;
    if (status == "complate") {
      body = {'order_id': data.id.toString(), 'status': status, 'note': ''};
    } else {
      body = {'order_id': data.id.toString(), 'status': status};
    }
    var orderUrl = Uri.parse(url + 'orderStatusChange');
    var response = await http.post(orderUrl,
        headers: {
          'Authorization':
              "Bearer " + await PrefsService.getStringl(prefTokenKey),
        },
        body: body);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    Map parsed = json.decode(response.body);

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(parsed["message"])));
  }

  Widget buildUserInfoDisplay({String title, String value}) => Padding(
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
                value,
                style: const TextStyle(fontSize: 16, height: 1.4),
              )),
        ],
      ));
}
