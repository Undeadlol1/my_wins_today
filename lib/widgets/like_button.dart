import 'package:flutter/material.dart';
import 'package:tap_debouncer/tap_debouncer.dart';
import 'package:like_button/like_button.dart' as LikeButtonPackage;

class LikeButton extends StatelessWidget {
  const LikeButton({
    Key? key,
    this.isDisabled = false,
    required this.isLiked,
    required this.onTap,
  }) : super(key: key);

  final bool isLiked;
  final bool isDisabled;
  final Future Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return TapDebouncer(
      onTap: isDisabled ? null : onTap,
      cooldown: const Duration(milliseconds: 1500),
      builder: (BuildContext context, TapDebouncerFunc? onTap) {
        return LikeButtonPackage.LikeButton(
          isLiked: isLiked,
          onTap: (isButtonCurrentlyLiked) async {
            if (isDisabled) return isButtonCurrentlyLiked;

            if (onTap != null) onTap();
            return !isButtonCurrentlyLiked;
          },
        );
      },
    );
  }
}
