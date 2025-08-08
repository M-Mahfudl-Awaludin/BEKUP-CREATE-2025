import 'package:flutter/material.dart';
import 'package:cekfilm/constants.dart';
import 'package:cekfilm/screens/home/components/body.dart';
import 'components/about_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: buildAppBar(context),
      body: Body(),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: bgColor,
      elevation: 0,
      titleSpacing: 0,
      title: Row(
        children: [
          SizedBox(width: kDefaultPadding),
          Image.asset(
            "assets/images/logo_cekfilm.png",
            height: 50,
          ),
          SizedBox(width: 10),
          Text(
            "CEKFILM",
            style: TextStyle(
              fontFamily: 'BebasNeue',
              color: Colors.deepOrange,
              fontWeight: FontWeight.bold,
              fontSize: 40,
              letterSpacing: 1.2,
            ),
          ),
        ],
      ),
      actions: <Widget>[
        IconButton(
          padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
          icon: Icon(Icons.info_outline, color: textColor),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AboutScreen()),
            );
          },
        ),
      ],
    );
  }
}
