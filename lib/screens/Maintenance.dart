import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Maintenance extends StatefulWidget {
  String erorr;

  Maintenance({this.erorr});

  @override
  _MaintenanceState createState() => _MaintenanceState();
}

class _MaintenanceState extends State<Maintenance> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        //  backgroundColor: themeColor.getColor(),
        title: Text(
          "عطل فنى",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        actions: [
          InkWell(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.login_outlined,
                size: 25,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
            child: Center(
                child: Column(
          children: [
            Icon(
              Icons.settings_ethernet_outlined,
              size: 100,
            ),
            Center(
                child: Text(
              "${widget.erorr == null ? ' ' : widget.erorr}",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ))
          ],
        ))),
      ),
    );
  }
}
