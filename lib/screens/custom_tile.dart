import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTile extends StatelessWidget {
  final String title;
  final String content;
  final Color backgroundColor;
  final double textSize;

  CustomTile({
    this.title,
    this.content,
    this.backgroundColor,
    this.textSize,
  });

  @override
  Widget build(BuildContext context) {
    return GridTile(
      child: Card(
        color: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        elevation: 8,
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            FittedBox(
              fit: BoxFit.contain,
              child: Text(
                content,
                style: GoogleFonts.abel(
                  textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: textSize ?? 30,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
