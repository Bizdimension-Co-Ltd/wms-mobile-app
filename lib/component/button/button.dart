import 'package:flutter/material.dart';
import 'package:wms_mobile/constant/style.dart';

enum ButtonVariant { primary, secondary, danger, ghost, outline }

ButtonStyle buttonStyle(ButtonVariant variant) {
  switch (variant) {
    case ButtonVariant.secondary:
      return ButtonStyle();
    case ButtonVariant.ghost:
      return ButtonStyle(
        backgroundColor: WidgetStateProperty.all(Colors.white),
        // textStyle: WidgetStateProperty.all(
        //   TextStyle(
        //     color: Colors.red,
        //     // color: Color.fromARGB(255, 0, 0, 0),
        //   ),
        // ),
      );
    case ButtonVariant.outline:
      return ButtonStyle(
        backgroundColor: WidgetStateProperty.all(Colors.white),
      );
    default:
      return ButtonStyle(
        backgroundColor: WidgetStateProperty.all(
          const Color.fromARGB(255, 17, 18, 48),
        ),
      );
  }
}

class Button extends StatelessWidget {
  const Button({
    super.key,
    this.onPressed,
    this.disabled = false,
    this.loading = false,
    required this.child,
    this.variant = ButtonVariant.primary,
  });

  final Function()? onPressed;
  final bool disabled;
  final bool loading;
  final Widget child;
  final ButtonVariant variant;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: disabled || loading ? 0.85 : 1.0,
      child: SizedBox(
        width: double.infinity,
        height: 47.0,
        child: ElevatedButton(
          onPressed: disabled || loading
              ? null
              : onPressed, // Replace null with your actual callback function
          style: buttonStyle(variant).copyWith(
            shape: WidgetStateProperty.all(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))),
            elevation: WidgetStateProperty.all(0),
          ),
          child: loading
              ? SizedBox(
                  width: size(context).width * 0.055,
                  height: size(context).width * 0.055,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2.5,
                  ),
                )
              : child,
        ),
      ),
    );
  }
}
