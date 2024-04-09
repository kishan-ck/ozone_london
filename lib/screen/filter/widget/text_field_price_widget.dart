// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:ozone_london/constant/colors.dart';
import 'package:ozone_london/constant/dynamic_size.dart';

class TextFieldPriceWidget extends StatefulWidget {
  const TextFieldPriceWidget({Key? key, this.textController, this.suffix})
      : super(key: key);

  final TextEditingController? textController;
  final String? suffix;

  @override
  State<TextFieldPriceWidget> createState() => _TextFieldPriceWidgetState();
}

class _TextFieldPriceWidgetState extends State<TextFieldPriceWidget> {
  bool _isHovering = false;
  bool _isFocused = false;

  FocusNode textFocus = FocusNode();

  @override
  void initState() {
    textFocus.addListener(() {
      setState(() {
        _isFocused = textFocus.hasFocus;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: MouseRegion(
        onEnter: (event) {
          setState(() {
            _isHovering = true;
          });
        },
        onExit: (event) {
          setState(() {
            _isHovering = false;
          });
        },
        child: GestureDetector(
          onTap: () {
            textFocus.requestFocus();
          },
          child: InputDecorator(
            expands: false,
            isFocused: _isFocused,
            isHovering: _isHovering,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 0),
              constraints: BoxConstraints(minWidth: 20, maxWidth: 30),
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: shadowColor)),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: shadowColor)),
              disabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: shadowColor)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Flexible(
                  child: IntrinsicWidth(
                    child: TextFormField(
                      focusNode: textFocus,
                      controller: widget.textController,
                      decoration: const InputDecoration(
                        // constraints: BoxConstraints(minWidth: 20),
                        isCollapsed: true,
                        border:
                            UnderlineInputBorder(borderSide: BorderSide.none),
                        focusedBorder:
                            UnderlineInputBorder(borderSide: BorderSide.none),
                        enabledBorder:
                            UnderlineInputBorder(borderSide: BorderSide.none),
                        disabledBorder:
                            UnderlineInputBorder(borderSide: BorderSide.none),
                      ),
                      style: TextStyle(fontSize: 16, color: primaryBlackColor),
                    ),
                  ),
                ),
                size.WidthSpace(8),
                (widget.suffix != null)
                    ? Text('INR',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18))
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
