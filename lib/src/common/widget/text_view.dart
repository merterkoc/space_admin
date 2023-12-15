import 'package:flutter/material.dart';

class TextView extends StatefulWidget {
  final TextEditingController textEditingController;
  final FocusNode focusNode;
  final String? labelText;
  final String? hintText;
  final String? initialValue;
  final bool? enabled;
  final bool? obscureText;
  final TextInputType? textInputType;
  final String? Function(String?)? validator;
  final String? Function(String?)? onSaved;
  final void Function(String?)? onChanged;
  final void Function()? onEditingComplete;
  final EdgeInsetsGeometry? padding;

  const TextView({
    super.key,
    required this.textEditingController,
    required this.focusNode,
    this.labelText,
    this.hintText,
    this.initialValue,
    this.enabled,
    this.obscureText,
    this.validator,
    this.onSaved,
    this.onChanged,
    this.onEditingComplete,
    this.textInputType,
    this.padding,
  });

  @override
  State<TextView> createState() => _TextViewState();
}

class _TextViewState extends State<TextView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding ?? EdgeInsets.zero,
      child: TextFormField(
        controller: widget.textEditingController,
        focusNode: widget.focusNode,
        style: const TextStyle(fontSize: 20),
        decoration: InputDecoration(
          labelText: widget.labelText,
          border: const OutlineInputBorder(),
          contentPadding: const EdgeInsets.all(10),
          constraints: const BoxConstraints(minHeight: 50),
          helperText: widget.hintText,
          disabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
          ),
          suffixIcon: widget.textEditingController.text.isNotEmpty
              ? IconButton(
                  onPressed: () {
                    widget.textEditingController.clear();
                  },
                  icon: const Icon(Icons.clear),
                )
              : null,
        ),
        keyboardType: widget.textInputType,
        initialValue: widget.initialValue,
        enabled: widget.enabled,
        validator: widget.validator,
        onSaved: widget.onSaved,
        onChanged: widget.onChanged,
        obscureText: widget.obscureText ?? false,
        onEditingComplete: widget.onEditingComplete,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    widget.textEditingController.addListener(() {
      setState(() {});
    });
  }
}
