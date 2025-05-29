import 'package:flutter/material.dart';

class LabeledCheckbox extends StatefulWidget {
  final String label;
  final bool initialValue;
  final ValueChanged<bool> onChanged;

  const LabeledCheckbox({
    Key? key,
    required this.label,
    this.initialValue = false,
    required this.onChanged,
  }) : super(key: key);

  @override
  _LabeledCheckboxState createState() => _LabeledCheckboxState();
}

class _LabeledCheckboxState extends State<LabeledCheckbox> {
  late bool _checked;

  @override
  void initState() {
    super.initState();
    _checked = widget.initialValue;
  }

  void _handleCheckboxChanged(bool? value) {
    if (value == null) return;
    setState(() {
      _checked = value;
    });
    widget.onChanged(value);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: _checked,
          onChanged: _handleCheckboxChanged,
        ),
        GestureDetector(

          onTap: () => _handleCheckboxChanged(!_checked),
          child: Text(widget.label),
        ),
      ],
    );
  }
}
