import 'package:flutter/material.dart';

class ButtonComponent extends StatefulWidget {
  const ButtonComponent(
      {super.key,
      required this.onClick,
      required this.label,
      this.radius,
      this.style});

  final Function() onClick;
  final String label;
  final double? radius;
  final ButtonStyle? style;

  @override
  State<ButtonComponent> createState() => _ButtonComponentPadraoState();
}

class _ButtonComponentPadraoState extends State<ButtonComponent> {
  @override
  void initState() {
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onClick,
      style: widget.style ??
          TextButton.styleFrom(
              elevation: 5,
              padding: const EdgeInsets.all(15),
              shape: widget.radius != null
                  ? RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(widget.radius!))
                  : null),
      child: Text(
        widget.label,
        textAlign: TextAlign.center,
      ),
    );
  }
}
