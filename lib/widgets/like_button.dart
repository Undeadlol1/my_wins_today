import 'package:flutter/material.dart';
import 'package:tap_debouncer/tap_debouncer.dart';
import 'package:like_button/like_button.dart' as LikeButtonPackage;

class LikeButton extends StatelessWidget {
  const LikeButton({
    Key? key,
    required this.onTap,
    required this.isLiked,
    this.isDisabled = false,
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
          likeBuilder: (bool isLiked) {
            return Icon(
              isLiked ? Icons.favorite : Icons.favorite_outline,
            );
          },
          circleColor: LikeButtonPackage.CircleColor(
            end: const Color(0xff33b5e5),
            start: const Color(0xff0099cc),
          ),
          bubblesColor: LikeButtonPackage.BubblesColor(
            dotPrimaryColor: const Color(0xff33b5e5),
            dotSecondaryColor: const Color(0xff0099cc),
          ),
        );
      },
    );
  }
}
