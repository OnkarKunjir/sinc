import 'package:flutter/material.dart';
import '../../colors.dart';

class SearchBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
        elevation: 0,
        floating: true,
        snap: true,
        pinned: true,
        title: Text('Sinc'),
        leading: IconButton(icon: Icon(Icons.menu), onPressed: () => null),
        expandedHeight: 160,
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(100),
            bottomRight: Radius.circular(100),
          ),
        ),
        flexibleSpace: FlexibleSpaceBar(
          background: Stack(
            children: <Widget>[
              Positioned(
                left: 0,
                right: 0,
                bottom: 10,
                child: Container(
                  height: 50,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(40)),
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 10),
                          blurRadius: 50,
                          color: kShadow.withOpacity(0.1))
                    ],
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                        hintText: 'Search',
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        icon: Icon(Icons.search)),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
