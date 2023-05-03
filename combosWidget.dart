import 'package:flutter/material.dart';

class CombosWidget extends StatefulWidget {
  final List<String> items;
  final String selection;
  final double width;
  final double height;
  final TextStyle? textStyle;
  final Color? dropdownColor;
  final Color? iconColor;

  const CombosWidget({
    Key? key,
    required this.items,
    required this.selection,
    this.width = 200,
    this.height = 50,
    this.textStyle,
    this.dropdownColor,
    this.iconColor,
  }) : super(key: key);

  @override
  State<CombosWidget> createState() => _CombosWidgetState();
}

class _CombosWidgetState extends State<CombosWidget> {
  late String _selection;

  @override
  void initState() {
    _selection = widget.selection;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dropdownMenuOptions = widget.items
        .map((String item) =>
            DropdownMenuItem<String>(value: item, child: Text(item)))
        .toList();

    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selection,
          icon: Icon(Icons.arrow_drop_down, color: widget.iconColor),
          iconSize: 24,
          elevation: 16,
          style: widget.textStyle,
          dropdownColor: widget.dropdownColor,
          onChanged: (s) {
            setState(() {
              _selection = s!;
            });
          },
          items: dropdownMenuOptions,
        ),
      ),
    );
  }
}
