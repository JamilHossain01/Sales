import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContainerIcon extends StatefulWidget {
  final String assetPath;
  final String tappedAssetPath; // ✅ new image path after tap
  final Color backgroundColor;
  final Color? borderColor;
  final double size;
  final double padding;
  final double? containerHeight;
  final double? containerWidth;

  const ContainerIcon({
    Key? key,
    required this.assetPath,
    required this.tappedAssetPath, // required second image
    this.backgroundColor = Colors.white,
    this.size = 20,
    this.padding = 8,
    this.containerHeight,
    this.containerWidth,
    this.borderColor,
  }) : super(key: key);

  @override
  State<ContainerIcon> createState() => _ContainerIconState();
}

class _ContainerIconState extends State<ContainerIcon> {
  bool _isTapped = false;

  void _toggleImage() {
    setState(() {
      _isTapped = !_isTapped;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double diameter = (widget.containerHeight ?? 35).h;

    return GestureDetector(
      onTap: _toggleImage,
      child: Container(
        height: diameter,
        width: diameter,
        decoration: BoxDecoration(
          color: widget.backgroundColor,
          shape: BoxShape.circle,
          border: widget.borderColor != null
              ? Border.all(color: widget.borderColor!)
              : null,
        ),
        padding: EdgeInsets.all(widget.padding.w),
        child: Image.asset(
          _isTapped ? widget.tappedAssetPath : widget.assetPath,
          height: widget.size.sp,
          width: widget.size.sp,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
