import 'package:flutter/material.dart';

class CustomBottomAppBar extends StatelessWidget {
  final Color backgroundColor;
  final Color iconColor;
  final VoidCallback menuButtonPressed;
  final VoidCallback searchButtonPressed;

  CustomBottomAppBar({
    required this.backgroundColor,
    required this.iconColor,
    required this.menuButtonPressed,
    required this.searchButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              backgroundColor.withOpacity(0.8),
              backgroundColor.withOpacity(1),
            ],
          ),
        ),
        child: BottomAppBar(
          elevation: 0,
          color: Colors.transparent,
          shape: CircularNotchedRectangle(),
          notchMargin: 4.0,
          child: Container(
            height: 60.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.home, color: iconColor),
                  iconSize: 30.0,
                  onPressed: menuButtonPressed,
                ),
                IconButton(
                  icon: Icon(Icons.save, color: iconColor),
                  onPressed: searchButtonPressed,
                  iconSize: 30.0,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
