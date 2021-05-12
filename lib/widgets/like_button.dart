import 'package:flutter/material.dart';
import 'package:tap_debouncer/tap_debouncer.dart';

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
      onTap: onTap,
      cooldown: const Duration(milliseconds: 1500),
      builder: (BuildContext context, TapDebouncerFunc? onTap) {
        return InkWell(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.all(2.5),
            child: Icon(
              isLiked ? Icons.favorite : Icons.favorite_outline,
            ),
          ),
        );
      },
    );
  }
}
