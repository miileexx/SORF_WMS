import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'constants.dart';

InputDecoration DecorationFormSettings(FocusNode txtUrl, String _hintText, _labelText) {
    return InputDecoration(
        border: OutlineInputBorder(          
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(width: 2, color: Primarycolor), //4211d0
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(width: 2, color: Primarycolor), //4211d0
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(width: 2, color: Secundarycolor)
            
            ),
        hintText: _hintText,
        labelText: _labelText,
        labelStyle: TextStyle(color: txtUrl.hasFocus ? Primarycolor : Secundarycolor));
  }

  InputDecoration DecorationFormSettingsPartidas(FocusNode txtUrl, String _hintText, _labelText) {
    return InputDecoration(
      isDense: true, 
      contentPadding: EdgeInsets.fromLTRB(15, 15, 15, 15),
        border: OutlineInputBorder(          
          borderRadius: BorderRadius.circular(11),
          borderSide: BorderSide(width: 1, color: Colors.black54), //4211d0
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(11),
          borderSide: BorderSide(width: 1, color: Colors.black), //4211d0
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(11),
            borderSide: BorderSide(width: 1, color: Colors.black54)
            
            ),
        hintText: _hintText,
        labelText: _labelText,
        labelStyle: TextStyle(color: txtUrl.hasFocus ? Colors.black : Colors.black54));
  }

  InputDecoration DecorationFormBorder(FocusNode focus) {
    return InputDecoration(
        counterText: '',
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(width: 2, color: Primarycolor), //4211d0
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(width: 2, color: Secundarycolor)),
        labelStyle: TextStyle(
            fontSize: 20,
            color: focus.hasFocus ? Primarycolor : Secundarycolor));
  }

  InputDecoration DecorationFormPartidas(FocusNode focus) {
    return InputDecoration(
        counterText: '',
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(width: 1.3, color: Primarycolor), //4211d0
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(width: 1.3, color: Secundarycolor)),
        labelStyle: GoogleFonts.barlow(
          textStyle: TextStyle(
            fontSize: 20,
            color: focus.hasFocus ? Primarycolor : Secundarycolor)
        ));
  }

 InputDecoration DecorationDropdownForm() {
    return InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    width: 2, color: Primarycolor), //4211d0
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      width: 2, color: Secundarycolor)),
                            );
  }