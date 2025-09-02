import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../services/accessibility_service.dart';

class AccessibleButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final String? semanticLabel;
  final String? semanticHint;
  final ButtonVariant variant;
  
  const AccessibleButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.semanticLabel,
    this.semanticHint,
    this.variant = ButtonVariant.primary,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: semanticLabel ?? text,
      hint: semanticHint ?? 'Double tap to activate',
      button: true,
      enabled: onPressed != null && !isLoading,
      child: SizedBox(
        width: double.infinity,
        height: 56,
        child: ElevatedButton(
          onPressed: isLoading ? null : () {
            HapticFeedback.lightImpact();
            AccessibilityService.announce('Pressed: $text');
            onPressed?.call();
          },
          style: variant == ButtonVariant.primary
              ? null
              : ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  foregroundColor: const Color(0xFF00D4AA),
                  side: const BorderSide(color: Color(0xFF00D4AA)),
                ),
          child: isLoading
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                  ),
                )
              : Text(
                  text,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
        ),
      ),
    );
  }
}

enum ButtonVariant { primary, secondary }
