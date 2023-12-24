import 'package:flutter/material.dart';

navigateWithPush({BuildContext? context, Widget? pageName}) {
  Navigator.push(context!, MaterialPageRoute(builder: (_) => pageName!));
}
