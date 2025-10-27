import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wolf_pack/app/uitilies/app_colors.dart';

import '../custom text/custom_text_widget.dart';

class SwipeToStartButton extends StatefulWidget {
  final VoidCallback onSwipeComplete;
  final double width;
  final double height;
  final Color backgroundColor;
  final Color iconColor;
  final Color textColor;
  final String label;

  const SwipeToStartButton({
    super.key,
    required this.onSwipeComplete,
    this.width = 320,
    this.height = 60,
    this.backgroundColor = Colors.amber,
    this.iconColor = Colors.orange,
    this.textColor = Colors.white,
    this.label = "Swipe to Get Started",
  });

  @override
  State<SwipeToStartButton> createState() => _SwipeToStartButtonState();
}

class _SwipeToStartButtonState extends State<SwipeToStartButton> {
  double _dragX = 0.0;
  bool _completed = false;

  double get _circleSize => widget.height - 10;
  double get _horizontalPadding => 10;
  double get _maxDrag => widget.width - _circleSize - (_horizontalPadding * 2);

  void _handlePanUpdate(DragUpdateDetails details) {
    if (_completed) return;

    setState(() {
      _dragX += details.delta.dx;
      _dragX = _dragX.clamp(0.0, _maxDrag);
    });
  }

  void _handlePanEnd(DragEndDetails details) {
    if (_completed) return;

    if (_dragX >= _maxDrag - 5) {
      setState(() {
        _dragX = _maxDrag;
        _completed = true;
      });

      Future.delayed(const Duration(milliseconds: 200), () {
        widget.onSwipeComplete();
      });
    } else {
      setState(() {
        _dragX = 0.0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: Stack(
        children: [
          // Background Track
          Container(
            width: widget.width,
            height: widget.height,
            decoration: BoxDecoration(
              color: widget.backgroundColor,
              borderRadius: BorderRadius.circular(100),
            ),
            alignment: Alignment.center,
            child: CustomText(
              text: widget.label,
              fontWeight: FontWeight.w700,
              fontSize: 16.sp,
              color: widget.textColor,
            ),
          ),

          // Draggable Circle
          Positioned(
            left: _dragX,
            top: 5,
            child: GestureDetector(
              onPanUpdate: _handlePanUpdate,
              onPanEnd: _handlePanEnd,
              child: Container(
                width: _circleSize,
                height: _circleSize,
                margin: EdgeInsets.symmetric(horizontal: _horizontalPadding),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      offset: Offset(0, 2),
                      blurRadius: 4,
                    ),
                  ],
                ),
                child: Icon(Icons.arrow_forward, color: widget.iconColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
