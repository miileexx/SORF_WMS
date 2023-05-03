import 'package:flutter/material.dart';
import 'package:sorfwms/utilities/constants.dart';

class CardBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
            final size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: size.height *0.25,
      decoration: _buildBoxDecoration(),
      child: Opacity(
        opacity: 0.8,
        child: Stack(
          children: [
            Positioned(child: _Bubble(), top: -75, left: -75),
            Positioned(child: _bubbleFondo(),top: -50, left: -50),
            Positioned(child: _Bubble(),top: 100, right: -75),
            Positioned(child: _bubbleFondo(),top: 125, right: -50)
          ],
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => BoxDecoration(
        color: Primarycolor,
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: Offset(0, 5))
        ],
      );
}

class _bubbleFondo extends StatelessWidget {
  const _bubbleFondo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(100),
    color: Primarycolor
          ),
        );
  }
}

class _Bubble extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: bubblecolor
      ),
    );
  }
}
