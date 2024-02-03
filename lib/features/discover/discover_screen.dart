import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktokclonepractice/constants/gaps.dart';
import 'package:tiktokclonepractice/constants/sizes.dart';
import 'package:tiktokclonepractice/utils.dart';

final tabs = [
  "Top",
  "Users",
  "Videos",
  "Sounds",
  "LIVE",
  "Shopping",
  "Brands",
];

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  final FocusNode textFocus = FocusNode();

  void _onSearchChanged(String value) {
    print("Searching for $value");
  }

  void _onSearchSubmitted(String value) {
    print("Submitted $value");
  }

  void _onTap() {
    textFocus.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: DefaultTabController(
        length: tabs.length,
        child: Scaffold(
          appBar: AppBar(
            title: CupertinoSearchTextField(
              focusNode: textFocus,
              onChanged: _onSearchChanged,
              onSubmitted: _onSearchSubmitted,
              style: TextStyle(
                color: isDarkMode(context) ? Colors.white : Colors.black,
              ),
            ),
            bottom: TabBar(
              padding: const EdgeInsets.symmetric(
                horizontal: Sizes.size6,
              ),
              isScrollable: true,
              labelStyle: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: Sizes.size16,
              ),
              indicatorColor: Theme.of(context).primaryColor,
              tabs: [for (var tab in tabs) Text(tab)],
            ),
          ),
          body: TabBarView(
            children: [
              GridView.builder(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                padding: const EdgeInsets.all(
                  Sizes.size6,
                ),
                itemCount: 10,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: Sizes.size10,
                  mainAxisSpacing: Sizes.size10,
                  childAspectRatio: 9 / 15,
                ),
                itemBuilder: (context, index) => LayoutBuilder(
                  builder: (context, constraints) => Column(
                    children: [
                      Container(
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            Sizes.size4,
                          ),
                        ),
                        child: AspectRatio(
                          aspectRatio: 9 / 10,
                          child: FadeInImage.assetNetwork(
                            fit: BoxFit.fill,
                            placeholder: "assets/images/bag.jpg",
                            image:
                                "https://images.unsplash.com/photo-1581431886281-93ae50c19271?q=80&w=1740&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                          ),
                        ),
                      ),
                      Gaps.v10,
                      Text(
                        "${constraints.maxWidth.toInt()} This is a very long caption for my tiktok that im upload just now currently",
                        style: const TextStyle(
                          fontSize: Sizes.size16 + Sizes.size2,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Gaps.v8,
                      DefaultTextStyle(
                        style: TextStyle(
                          color: isDarkMode(context)
                              ? Colors.grey.shade300
                              : Colors.grey.shade600,
                        ),
                        child: const Row(
                          children: [
                            CircleAvatar(
                              foregroundImage: NetworkImage(
                                "https://avatars.githubusercontent.com/u/87645151?v=4",
                              ),
                            ),
                            Gaps.h4,
                            Expanded(
                              child: Text(
                                "My avatar is going to be very long",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Gaps.h4,
                            FaIcon(
                              FontAwesomeIcons.heart,
                              size: Sizes.size16,
                            ),
                            Gaps.h2,
                            Text(
                              "2.5M",
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              for (var tab in tabs.skip(1))
                Center(
                  child: Text(tab),
                )
            ],
          ),
        ),
      ),
    );
  }
}
