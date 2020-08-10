import 'package:flutter/material.dart';
import 'dart:async';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(new MaterialApp(
    home: new MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _State createState() => new _State();
}

class _State extends State<MyApp> {

  String status;
  Permission permission;


  @override
  void initState() {
    super.initState();
    status = 'Select an item';
    print(Permission.values);
  }

  requestPermission() async {
    //bool res = await SimplePermissions.requestPermission(permission);
    final res = await permission.request().isGranted;
    print('Permission result is ${res.toString()}');

    setState(() {
      status = '${permission.toString()} = ${res.toString()}';
    });
  }

  checkPermission() async {
    //bool res = await SimplePermissions.checkPermission(permission);
    final res = await permission.isGranted;
    print('Permission result is ${res.toString()}');

    setState(() {
      status = '${permission.toString()} = ${res.toString()}';
    });
  }

  getPermissionStatus() async {
    //bool res = await SimplePermissions.getPermissionStatus(permission);
    final res = await permission.status;
    print('Permission result is ${res.toString()}');

    setState(() {
      status = '${permission.toString()} = ${res.toString()}';
    });
  }

  onDropDownChanged(Permission permission) {
    setState(() {
      this.permission = permission;
      status = 'Click a button below';
    });
    print(permission);

  }

  List<DropdownMenuItem<Permission>> _getDropDownItems() {
    List<DropdownMenuItem<Permission>> items = new List<DropdownMenuItem<Permission>>();
    Permission.values.forEach((permission) {
      final name = permission.toString();
      var item = new DropdownMenuItem(child: new Text(name.substring(name.indexOf('.')+1)), value: permission,);
      items.add(item);
    });

    return items;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Name here'),
      ),
      body: new Container(
        padding: new EdgeInsets.all(32.0),
        child: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new Text(status),
              new DropdownButton(items: _getDropDownItems(),value: permission, onChanged: onDropDownChanged),
              new RaisedButton(onPressed: checkPermission, child: new Text('Check Permission'),),
              new RaisedButton(onPressed: requestPermission, child: new Text('Request Permission'),),
              new RaisedButton(onPressed: getPermissionStatus, child: new Text('Get Status'),),
              new RaisedButton(onPressed: openAppSettings, child: new Text('Open Settings'),),
            ],
          ),
        )
      ),
    );
  }
}
