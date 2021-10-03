import 'package:flutter/material.dart';

TextFormField inputField({
  required String hintText,
  String? Function(String?)? validator,
  TextEditingController? controller,
  Color? borderColor,
  Widget? suffixIcon,
  bool? obscureText,
  TextInputType? keyboardType,
}) {
  return TextFormField(
    controller: controller,
    validator: validator,
    cursorColor: Colors.lightBlueAccent,
    cursorHeight: 24,
    style: TextStyle(
      fontSize: 20,
      color: Colors.black,
      fontFamily: 'Ubuntu',
    ),
    keyboardType: keyboardType,
    obscureText: obscureText ?? false,
    decoration: InputDecoration(
      hintText: hintText,
      suffixIcon: suffixIcon,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide:
            BorderSide(color: Colors.lightBlueAccent, width: 1.0),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
      ),
      errorStyle: TextStyle(
        color: Colors.red[400],
        fontSize: 16,
      ),
      errorBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.red,
        ),
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
      ),
      focusedErrorBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red, width: 2.0),
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
      ),
      errorMaxLines: 4,
      fillColor: Colors.white,
      filled: true,
    ),
  );
}



void showProgress({
  required BuildContext context,
  String? text,
  required bool willPop,
}) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return WillPopScope(
        onWillPop: () async => willPop,
        child: AlertDialog(
          backgroundColor: Colors.white,
          content: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(
                backgroundColor: Colors.transparent,
              ),
              SizedBox(
                height: 8,
              ),
              text != null
                  ? Text(
                      '$text',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    )
                  : SizedBox(),
            ],
          ),
        ),
      );
    },
  );
}


Future showConfirmationDialog({
  required BuildContext context,
  String? titleText,
  String? contentText,
  required String trueLabel,
  required String falseLabel,
  required VoidCallback onTrue,
  required VoidCallback onFalse,
}) async {
  return showDialog(
    context: context,
    builder: (context) => new AlertDialog(
      title: titleText != null
          ? Text(titleText,
              style: TextStyle(
                fontSize: 26,
              ))
          : null,
      content: contentText != null
          ? Text(contentText,
              style: TextStyle(
                fontSize: 19,
              ))
          : null,
      actions: <Widget>[
        new GestureDetector(
          onTap: onFalse,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(falseLabel,
                style: TextStyle(fontSize: 17, color: Colors.indigoAccent)),
          ),
        ),
        new GestureDetector(
          onTap: onTrue,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(trueLabel,
              style: TextStyle(fontSize: 17, color: Colors.redAccent)
            ),
          ),
        ),
      ],
    ),
  );
}

void showSnackBar(
    {required String text, required BuildContext context, Color? color}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      action: SnackBarAction(
        onPressed: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
        label: 'Dismiss',
      ),
      content: Text(
        text,
        style: TextStyle(fontSize: 16),
      ),
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      backgroundColor: color,
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      duration: Duration(seconds: 200000),
    ),
  );
}
