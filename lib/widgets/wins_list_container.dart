import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_wins_today/entities/win.dart';
import 'package:my_wins_today/states/viewer_state.dart';
import 'package:my_wins_today/use_cases/toggle_like.dart';
import 'package:my_wins_today/widgets/wins_list.dart';

class WinsListContainer extends StatefulWidget {
  final List<Win> wins;
  final bool isLoading;
  final bool isReversed;

  WinsListContainer({
    Key? key,
    required this.wins,
    required this.isLoading,
    this.isReversed = false,
  }) : super(key: key);

  @override
  _WinsListContainerState createState() => _WinsListContainerState();
}

class _WinsListContainerState extends State<WinsListContainer> {
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
