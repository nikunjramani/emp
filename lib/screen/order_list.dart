import 'dart:convert';

import 'package:emp/model/order.dart';
import 'package:emp/screen/order_details.dart';
import 'package:emp/utils/constant.dart';
import 'package:emp/utils/prefs.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class OrderList extends StatefulWidget {
  const OrderList({Key key}) : super(key: key);

  @override
  _OrderState createState() => _OrderState();
}

class _OrderState extends State<OrderList> {
  Order order;

  @override
  void initState() {
    super.initState();
    getOrderList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange[400],
        title: Text("Order List"),
      ),
      body: Container(
        child: ListView.builder(
            itemCount: order != null ? order.data.length : 0,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => OrderDetails(order.data[index])),
                  );
                },
                child: Card(
                  child: ListTile(
                    title: Text(order.data[index].serviceTitle),
                    subtitle: Text(order.data[index].manageOfWorkOrder),
                  ),
                ),
              );
            }),
      ),
    );
  }

  Future<void> getOrderList() async {
    var orderUrl = Uri.parse(url + 'orderList');
    var response = await http.get(orderUrl, headers: {
      'Authorization': "Bearer " + await PrefsService.getStringl(prefTokenKey),
    });
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    setState(() {
      order = Order.fromJson(jsonDecode(response.body));
    });
  }
}
