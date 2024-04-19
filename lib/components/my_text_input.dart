import 'package:flutter/material.dart';

class TextInputComponent extends StatefulWidget {
  const TextInputComponent(
      {super.key, required this.controller, required this.hint, this.onChange});

  final String hint;
  final TextEditingController controller;
  final Function(String)? onChange;

  @override
  State<TextInputComponent> createState() => _TextInputComponentPadraoState();
}

class _TextInputComponentPadraoState extends State<TextInputComponent> {
  @override
  void initState() {
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: widget.onChange,
      autofocus: true,
      controller: widget.controller,
      decoration: InputDecoration(
          filled: true,
          hintText: widget.hint,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(10),
          ),
          contentPadding: const EdgeInsets.only(left: 24)),
    );
  }
}
