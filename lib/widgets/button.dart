import 'package:flutter/material.dart';
import 'package:podcast_awesome/palette.dart';

class Button extends StatelessWidget {
  const Button(
      {Key? key,
      required this.tapHandler,
      required this.useLightTheme,
      required this.title,
      required this.fullWidth})
      : super(key: key);

  final VoidCallback tapHandler;
  final bool useLightTheme;
  final String title;
  final bool fullWidth;

  @override
  Widget build(BuildContext context) {
    return fullWidth
        ? Container(
            width: double.infinity,
            height: 100,
            padding: const EdgeInsets.all(20),
            child: ElevatedButton(
              onPressed: tapHandler,
              child: Text(
                title,
                style: TextStyle(color: useLightTheme ? color1 : Colors.white),
              ),
              style: ButtonStyle(
                  backgroundColor: useLightTheme
                      ? MaterialStateProperty.all<Color>(Colors.grey.shade100)
                      : MaterialStateProperty.all<Color>(color1),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ))),
            ),
          )
        : Container(
            height: 100,
            padding: const EdgeInsets.all(20),
            child: ElevatedButton(
              onPressed: tapHandler,
              child: Text(
                title,
                style: TextStyle(color: useLightTheme ? color1 : Colors.white),
              ),
              style: ButtonStyle(
                  backgroundColor: useLightTheme
                      ? MaterialStateProperty.all<Color>(Colors.grey.shade100)
                      : MaterialStateProperty.all<Color>(color1),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ))),
            ),
          );
  }
}
