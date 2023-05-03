import 'package:flutter/material.dart';
import 'package:sorfwms/utilities/constants.dart';


class TokenExpiredScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: double.infinity,
          child: Center(
            child: Container(
              width: 200,
              height: 200,
              child: Column(
                children: [
                  Text('El token expiro'),
                  SizedBox(height: 20,),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Primarycolor
                    ),
                    child: TextButton(child: Text('Salir', style: TextStyle(color: Colors.white),),
                     onPressed: () =>  Navigator.pushReplacementNamed(context, '/login'),),
                  )
                ],
              ),
              
            ),
          ),
        ),
      ),
   );
  }
}