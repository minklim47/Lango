import 'package:flutter/material.dart';
import 'package:lango_application/theme/color_theme.dart';

class InputField extends StatelessWidget {
  final String? placeholder;
  final Icon? icon;
  final double? pb;

  const InputField({super.key, this.placeholder, this.icon, this.pb});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(bottom: pb ?? 0),
        child: TextFormField(
          style: const TextStyle(fontSize: 20),
          decoration: InputDecoration(
            hintText: placeholder,
            filled: true,
            prefixIcon: icon,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
            fillColor: AppColors.white,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide.none),
          ),
        ));
  }
}
