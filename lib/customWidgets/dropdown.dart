import 'package:flutter/material.dart';

List<DropdownMenuItem<String>> get dropdownItems {
  List<DropdownMenuItem<String>> menuItems = [
    DropdownMenuItem(child: Text("Calicut"), value: "Calicut"),
    DropdownMenuItem(child: Text("Kannur"), value: "Kannur"),
    DropdownMenuItem(child: Text("Thrissur"), value: "Thrissur"),
    DropdownMenuItem(child: Text("Kollam"), value: "Kollam"),
  ];
  return menuItems;
}
