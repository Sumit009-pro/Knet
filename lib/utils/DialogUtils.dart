import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'StringUtils.dart';

class DialogUtils {
  static AlertDialog _progress;

  static void showProgress(context, show, {String msg = "Please wait"}) {
    if (context == null) {
      return;
    }
    if (_progress == null) {
      var bodyProgress = new Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          new CircularProgressIndicator(
            backgroundColor: parseHexColor(StringUtils.themeColor),
            value: null,
            valueColor: new AlwaysStoppedAnimation<Color>(
                parseHexColor(StringUtils.themeColor)),
            strokeWidth: 2.0,
          ),
          Visibility(
            visible: show,
            child: Container(
              margin: const EdgeInsets.only(left: 25.0),
              child: new Text(
                msg,
                style: new TextStyle(color: Colors.grey),
              ),
            ),
          ),
        ],
      );
      _progress = new AlertDialog(
        backgroundColor: Colors.transparent,
        content: bodyProgress,
      );
    }
    showDialog(
        context: context,
        builder: (BuildContext context) => _progress,
        barrierDismissible: false);
  }

  static void hideProgress(context) {
    if (context == null) {
      return;
    }
    if (_progress != null) {
      Navigator.pop(context);
      _progress = null;
    }
  }

  static void showMessageDialog(BuildContext context, String msg) {
    AlertDialog dialog = new AlertDialog(
      content: new Text(
        msg,
        style: new TextStyle(color: Colors.blue),
      ),
      actions: <Widget>[
        new FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: new Text("OK", style: new TextStyle(color: Colors.blue)))
      ],
    );
    showDialog(context: context, builder: (BuildContext context) => dialog);
  }
}
