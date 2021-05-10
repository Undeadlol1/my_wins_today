import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';

class AnimatedListPlaceHolder extends StatelessWidget {
  final int itemCount;
  const AnimatedListPlaceHolder({
    Key? key,
    this.itemCount = 5,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: Shimmer.fromColors(
        enabled: true,
        baseColor: Theme.of(context).backgroundColor,
        highlightColor: Theme.of(context).highlightColor,
        child: Column(
          children: <Widget>[
            for (var i = 0; i < itemCount; i++)
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 48.0,
                      height: 48.0,
                      color: Colors.white,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: double.infinity,
                            height: 8.0,
                            color: Colors.white,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 2.0),
                          ),
                          Container(
                            height: 8.0,
                            color: Colors.white,
                            width: double.infinity,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 2.0),
                          ),
                          Container(
                            height: 8.0,
                            color: Colors.white,
                            width: double.infinity,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 2.0),
                          ),
                          Container(
                            height: 8.0,
                            color: Colors.white,
                            width: double.infinity,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }
}
