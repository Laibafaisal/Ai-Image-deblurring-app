import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyButton extends StatefulWidget {
  const MyButton({
    Key? key,
    this.onTap,
    required this.text,
    this.width,
    this.height,
    this.font,
    this.imageAsset,
  }) : super(key: key);

  final void Function()? onTap;
  final String text;
  final double? width;
  final double? height;
  final double? font;
  final String? imageAsset;

  @override
  _MyButtonState createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  Color _buttonColor = const Color(0xFF2196F3); // Initial color

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() {
        _buttonColor = Colors.blue; // Color on hover
      }),
      onExit: (_) => setState(() {
        _buttonColor = Colors.black; // Color when not hovering
      }),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(color: Colors.blue, offset: Offset(0, 8), blurRadius: 5)
            ],
            color: _buttonColor,
            borderRadius: BorderRadius.circular(10),
          ),
          width: widget.width,
          height: widget.height ?? 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.imageAsset != null)
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: SvgPicture.asset(
                    widget.imageAsset!,
                    width: 30,
                    height: 30,
                  ),
                ),
              Text(
                widget.text,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: widget.font,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
