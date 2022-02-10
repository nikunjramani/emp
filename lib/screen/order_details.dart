import 'package:emp/model/order.dart';
import 'package:flutter/material.dart';

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
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];
  String dropdownvalue = 'Item 1';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildUserInfoDisplay(
                  title: "Service Title", value: data.serviceTitle),
              buildUserInfoDisplay(
                  title: "Service Schedule", value: data.serviceSchedule),
              buildUserInfoDisplay(
                  title: "Manage Of WorkOrder", value: data.manageOfWorkOrder),
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
                  title: "Orientation Keyword", value: data.orientationKeyword),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount:
                      data.customField != null ? data.customField.length : 0,
                  itemBuilder: (context, index) {
                    return buildUserInfoDisplay(
                        title: data.customField[index].title,
                        value: data.customField[index].value);
                  }),
              buildDropDownSelector(value: data.status)
            ],
          ),
        ),
      ),
    );
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
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
          const SizedBox(
            height: 1,
          ),
          DropdownButton(
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
              });
            },
          ),
        ],
      ));

  Widget buildUserInfoDisplay({String title, String value}) => Padding(
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
                value,
                style: const TextStyle(fontSize: 16, height: 1.4),
              )),
        ],
      ));
}
