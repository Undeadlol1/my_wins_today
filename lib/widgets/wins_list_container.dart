import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_wins_today/entities/Win.dart';
import 'package:my_wins_today/states/viewer_state.dart';
import 'package:my_wins_today/use_cases/toggle_like.dart';
import 'package:my_wins_today/widgets/wins_list.dart';

class WinsListConntainer extends StatefulWidget {
  final List<Win> wins;
  final bool isLoading;

  WinsListConntainer({
    Key? key,
    required this.wins,
    required this.isLoading,
  }) : super(key: key);

  @override
  _WinsListConntainerState createState() => _WinsListConntainerState();
}

class _WinsListConntainerState extends State<WinsListConntainer> {
  @override
  Widget build(BuildContext context) {
    ViewerState viewerState = Get.find<ViewerState>();
    return WinsList(
      wins: widget.wins,
      onLikeButtonTap: toggleLike,
      viewerId: viewerState.userId ?? '',
    );
  }
}
