import 'package:flutter/material.dart';
import 'dart:io';
import '../../colors.dart';

class DocCard extends StatelessWidget {
  String title, thumbnail;
  final double cardHeight;
  DocCard({
    @required this.title,
    @required this.thumbnail,
    @required this.cardHeight,
  }) {
    if (title.length > 15) {
      print(title.length);
      title = title.substring(0, 15) + '...';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 10),
            blurRadius: 20,
            color: kShadow.withOpacity(0.3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            clipBehavior: Clip.antiAlias,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
            child: Image.file(
              File(this.thumbnail),
              height: this.cardHeight * 0.6,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Text(
              this.title,
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}
