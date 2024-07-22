import 'package:arre_music/dashboard/home_feeds.dart';
import 'package:arre_music/values/colors.dart';
import 'package:arre_music/values/images.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  double maxHeight = 150;
  double minHeight = 90;
  int index = 0;

  late final ValueNotifier selectedFileIndex = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.transparent,
            expandedHeight: maxHeight,
            collapsedHeight: minHeight,
            floating: false,
            pinned: true,
            flexibleSpace: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
              var expandRatio = constraints.biggest.height / maxHeight;
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(20 * expandRatio),
                  ),
                  gradient: RadialGradient(
                    colors: [
                      const Color(0x00171e26).withOpacity(0.7),
                      const Color(0x0b0b0c33).withOpacity(0.2),
                    ],
                    radius: 20,
                  ),
                ),
                child: FlexibleSpaceBar(
                  titlePadding: EdgeInsets.symmetric(
                      horizontal: 10, vertical: 18 * expandRatio),
                  expandedTitleScale: 1.1,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset(
                              imgLogo,
                              fit: BoxFit.scaleDown,
                              alignment: Alignment.centerLeft,
                              width: 100,
                              height: 30 * (expandRatio),
                            ),
                            const SizedBox(height: 5.0),
                            Image.asset(
                              imgLogoVoice,
                              fit: BoxFit.scaleDown,
                              alignment: Alignment.centerLeft,
                              width: 100,
                              height: 25 * expandRatio,
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            icon: Image.asset(
                              imgNotification,
                              fit: BoxFit.fill,
                              height: 24 + (4 * expandRatio),
                              width: 24 + (4 * expandRatio),
                            ),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: Image.asset(
                              imgMessage,
                              fit: BoxFit.scaleDown,
                              height: 18 + (4 * expandRatio),
                              width: 18 + (4 * expandRatio),
                            ),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
          HomeFeeds(playSelected: playSelected),
        ],
      ),
      bottomNavigationBar: buildBottomBar(),
    );
  }

  Widget buildBottomBar() {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(30.0),
        topRight: Radius.circular(30.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          playerController(),
          BottomNavigationBar(
            iconSize: 25,
            selectedIconTheme:
                const IconThemeData(color: Colors.white, size: 35),
            selectedItemColor: Colors.white,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Theme.of(context).primaryColor,
            unselectedItemColor: const Color(0xff76878f),
            showSelectedLabels: false,
            showUnselectedLabels: false,
            currentIndex: index,
            items: [
              const BottomNavigationBarItem(
                  icon: ImageIcon(
                    AssetImage(imgHome),
                  ),
                  label: "Home"),
              const BottomNavigationBarItem(
                  icon: ImageIcon(
                    AssetImage(imgSearch),
                  ),
                  label: "Search"),
              BottomNavigationBarItem(
                  icon: ClipOval(
                    child: Container(
                        padding: const EdgeInsets.all(5.0),
                        decoration: const BoxDecoration(
                            gradient: LinearGradient(
                          colors: [
                            Color(0xffffa553),
                            Color(0xffee8c34),
                            Color(0xffea5434),
                          ],
                        )),
                        child: const Icon(
                          Icons.mic,
                          color: Colors.white,
                        )),
                  ),
                  label: "Record"),
              const BottomNavigationBarItem(
                  icon: ImageIcon(
                    AssetImage(imgGroupPeople),
                  ),
                  label: "Community"),
              const BottomNavigationBarItem(
                  icon: ImageIcon(
                    AssetImage(imgUserPlaceholder),
                  ),
                  label: "Profile"),
            ],
            onTap: (int index) => setState(() => this.index = index),
          ),
        ],
      ),
    );
  }

  playSelected(int index) {
    selectedFileIndex.value = index + 1;
  }

  Widget playerController() {
    return GestureDetector(
      onVerticalDragEnd: (details) {
        if ((details.primaryVelocity ?? 0) > 0) {
          selectedFileIndex.value = 0;
        }
      },
      child: ValueListenableBuilder(
        valueListenable: selectedFileIndex,
        builder: (context, value, child) {
          return Offstage(
              offstage: value == 0,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "$value. How to make your business grow faster and boost",
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                "@user",
                                style: TextStyle(color: colorProgressIndicator),
                              )
                            ],
                          ),
                        ),
                        child!,
                      ],
                    ),
                    const LinearProgressIndicator(
                      value: 0.5,
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Color(0x88888888)),
                    )
                  ],
                ),
              ));
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
                padding: EdgeInsets.zero,
                visualDensity: VisualDensity.compact,
                onPressed: () {},
                icon: const ImageIcon(
                  AssetImage(imgLike),
                )),
            IconButton(
              padding: EdgeInsets.zero,
              visualDensity: VisualDensity.compact,
              onPressed: () {},
              icon: Image.asset(imgPlayButton),
            ),
            IconButton(
                padding: EdgeInsets.zero,
                visualDensity: VisualDensity.compact,
                onPressed: () {},
                icon: const ImageIcon(
                  AssetImage(imgPlaylist),
                ))
          ],
        ),
      ),
    );
  }
}
