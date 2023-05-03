import 'package:flutter/material.dart';

class CardContainer extends StatelessWidget {
  final Widget child;
  final bool full;
  const CardContainer({Key? key, required this.child, bool this.full = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: full ? size.height * 0.83 : size.height * 0.75,
      decoration: _createCardShape(),
      child: child,
    );
  }

  BoxDecoration _createCardShape() => const BoxDecoration(
          color: Colors.white,
          //borderRadius: BorderRadius.circular(25),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25), topRight: Radius.circular(25)),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 15,
              offset: Offset(0, 5),
            )
          ]);
}
