import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomOtpWidget extends StatefulWidget {
  final Color? pinColor;
  final Color? borderColor;
  final Color? focusedBorderColor;
  final TextStyle? textStyle;
  final String? hintText;
  final double? borderRadius;
  final double? fieldHeight;
  final double? fieldWidth;
  final int? numberOfFields;
  final TextEditingController? controller;

  const CustomOtpWidget({
    super.key,
    this.pinColor,
    this.borderColor,
    this.focusedBorderColor,
    this.textStyle,
    this.hintText,
    this.borderRadius,
    this.fieldHeight,
    this.fieldWidth,
    this.numberOfFields = 4,
    this.controller,
  });

  @override
  State<CustomOtpWidget> createState() => _CustomOtpWidgetState();
}

class _CustomOtpWidgetState extends State<CustomOtpWidget> {
  late List<TextEditingController> _controllers;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
      widget.numberOfFields!,
          (_) => TextEditingController(),
    );
  }

  void _updateMainController() {
    final combinedOtp = _controllers.map((c) => c.text).join();
    widget.controller?.text = combinedOtp;
    // Debugging:
    print('[OTP DEBUG] Combined OTP: $combinedOtp');
  }

  @override
  void dispose() {
    for (var c in _controllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final inputDecoration = InputDecoration(
      hintText: widget.hintText ?? "0",
      hintStyle: const TextStyle(color: Color(0xFF757575)),
      border: authOutlineInputBorder(widget.borderColor ?? Colors.white, widget.borderRadius ?? 12.0),
      enabledBorder: authOutlineInputBorder(widget.borderColor ?? Colors.white, widget.borderRadius ?? 12.0),
      focusedBorder: authOutlineInputBorder(widget.focusedBorderColor ?? const Color(0xFFFF7643), widget.borderRadius ?? 12.0),
    );

    return Form(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(widget.numberOfFields!, (index) {
          return SizedBox(
            height: widget.fieldHeight ?? 64,
            width: widget.fieldWidth ?? 64,
            child: TextFormField(
              controller: _controllers[index],
              onChanged: (pin) {
                if (pin.isNotEmpty) {
                  if (index + 1 < widget.numberOfFields!) {
                    FocusScope.of(context).nextFocus();
                  }
                }
                _updateMainController(); // Update main controller every change
              },
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              inputFormatters: [
                LengthLimitingTextInputFormatter(1),
                FilteringTextInputFormatter.digitsOnly,
              ],
              style: widget.textStyle ?? Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
              decoration: inputDecoration,
            ),
          );
        }),
      ),
    );
  }
}

OutlineInputBorder authOutlineInputBorder(Color color, double borderRadius) {
  return OutlineInputBorder(
    borderSide: BorderSide(color: color),
    borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
  );
}
