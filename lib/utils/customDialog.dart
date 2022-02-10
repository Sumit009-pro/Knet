import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final String title, description, buttonText;
  final Image image;
  final Color color;

  CustomDialog({
    @required this.title,
    @required this.description,
    @required this.buttonText,
    this.image,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
            top: 16,
            //bottom: Consts.padding,
            // left: Consts.padding,
            // right: Consts.padding,
          ),
          margin: EdgeInsets.only(top: 16),
          decoration: new BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: const Offset(0.0, 10.0),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // To make the card compact
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 16.0),
              Padding(
                padding: EdgeInsets.only(
                  left: 16.0,
                  right: 16.0,
                ),
                child: Text(
                  description,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ),
              SizedBox(height: 25.0),
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(16.0),
                        bottomRight: Radius.circular(16.0)),
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      buttonText,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
