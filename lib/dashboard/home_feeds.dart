import 'package:arre_music/values/images.dart';
import 'package:flutter/material.dart';

class HomeFeeds extends StatefulWidget {
  final Function(int index) playSelected;

  const HomeFeeds({required this.playSelected, super.key});

  @override
  State<HomeFeeds> createState() => _HomeFeedsState();
}

class _HomeFeedsState extends State<HomeFeeds> {
  @override
  Widget build(BuildContext context) {
    return buildItems();
  }

  Widget buildItems() => SliverToBoxAdapter(
        child: ListView.builder(
          primary: false,
          shrinkWrap: true,
          itemCount: 20,
          itemBuilder: (context, index) => Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                height: 150,
                width: double.infinity,
                child: Card(
                  child: Image.network(
                    'https://serendipitycreative.com/wp-content/uploads/2021/07/ux-of-print-design.webp',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: IconButton(
                  icon: Image.asset(imgPlayButtonGrey),
                  onPressed: () => widget.playSelected.call(index),
                ),
              ),
            ],
          ),
        ),
      );
}
