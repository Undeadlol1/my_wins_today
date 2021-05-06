import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_wins_today/entities/Win.dart';
import 'package:my_wins_today/states/viewer_state.dart';
import 'package:my_wins_today/use_cases/toggle_like.dart';
import 'package:my_wins_today/widgets/wins_list.dart';

class WinsListConntainer extends StatefulWidget {
  final List<Win> wins;
  final bool isLoading;
  final bool isReversed;

  WinsListConntainer({
    Key? key,
    required this.wins,
    required this.isLoading,
    this.isReversed = false,
  }) : super(key: key);

  @override
  _WinsListConntainerState createState() => _WinsListConntainerState();
}

class _WinsListConntainerState extends State<WinsListConntainer> {
  @override
  Widget build(BuildContext context) {
    String viewerId = Get.find<ViewerState>().userId ?? '';
    bool doesListBelongToViewer = widget.wins.every(
      (win) => win.userId == viewerId,
    );

    return WinsList(
      wins: widget.wins,
      viewerId: viewerId,
      isLoading: widget.isLoading,
      isReversed: widget.isReversed,
      onLikeButtonTap: doesListBelongToViewer ? null : toggleLike,
    );
  }
}
