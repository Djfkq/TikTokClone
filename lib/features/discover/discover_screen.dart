import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktokclonepractice/constants/breakpoints.dart';
import 'package:tiktokclonepractice/constants/gaps.dart';
import 'package:tiktokclonepractice/constants/sizes.dart';
import 'package:tiktokclonepractice/features/discover/widgets/custom_search_textfield.dart';
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

class _DiscoverScreenState extends State<DiscoverScreen>
    with SingleTickerProviderStateMixin {
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _textEditingController =
      TextEditingController(text: "Initial Text");
  late final TabController _tabController;

  bool _indexIsChanging = false;

  void _onSearchChanged(String value) {
    print("Searching for $value");
  }

  void _onSearchSubmitted(String value) {
    print("Submitted $value");
  }

  void _onTap() {
    _focusNode.unfocus();
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);

    _tabController.addListener(
      () {
        if (_tabController.indexIsChanging) {
          _onTap();
          _textEditingController.text = "";
          _indexIsChanging = true;
          setState(() {});
        }
      },
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: _onTap,
      child: DefaultTabController(
        length: tabs.length,
        child: Scaffold(
          appBar: AppBar(
            elevation: 1,
            title:
                ///////////////////////////////////////////////////////////////////
                ///ConstrainedBox 대신 Container도 사용 가능
                ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: Breakpoints.md,
              ),
              child: CustomSearchTextField(
                textEditingController: _textEditingController,
                indexIsChanging: _indexIsChanging,
                focusNode: _focusNode,
              ),
            ),
            ///////////////////////////////////////////////////////////////////
            ///////////////////////////////////////////////////////////////////
            //     CupertinoSearchTextField(
            //   controller: _textEditingController,
            //   focusNode: _focusNode,
            //   onChanged: _onSearchChanged,
            //   onSubmitted: _onSearchSubmitted,
            //   style: TextStyle(
            //     color: isDarkMode(context) ? Colors.white : Colors.black,
            //   ),
            // ),
            ///////////////////////////////////////////////////////////////////
            bottom: TabBar(
              controller: _tabController,
              splashFactory: NoSplash.splashFactory,
              padding: const EdgeInsets.symmetric(
                horizontal: Sizes.size6,
              ),
              isScrollable: true,
              labelStyle: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: Sizes.size16,
              ),
              indicatorColor: Theme.of(context).tabBarTheme.indicatorColor,
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
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: width > Breakpoints.lg ? 5 : 2,
                  crossAxisSpacing: Sizes.size10,
                  mainAxisSpacing: Sizes.size10,
                  childAspectRatio: 9 / 15,
                ),
                itemBuilder: (context, index) => Scrollbar(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: Sizes.size10,
                      horizontal: Sizes.size20,
                    ),
                    child: LayoutBuilder(
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
                          if (constraints.maxWidth < 300 ||
                              constraints.maxWidth > 350)
                            DefaultTextStyle(
                              style: TextStyle(
                                color: isDarkMode(context)
                                    ? Colors.grey.shade300
                                    : Colors.grey.shade600,
                                fontWeight: FontWeight.w600,
                              ),
                              child: Row(
                                children: [
                                  const CircleAvatar(
                                    radius: 12,
                                    foregroundImage: NetworkImage(
                                      "https://avatars.githubusercontent.com/u/87645151?v=4",
                                    ),
                                  ),
                                  Gaps.h4,
                                  Expanded(
                                    child: Text(
                                      "$width My avatar is going to be very long",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Gaps.h4,
                                  const FaIcon(
                                    FontAwesomeIcons.heart,
                                    size: Sizes.size16,
                                  ),
                                  Gaps.h2,
                                  const Text(
                                    "2.5M",
                                  )
                                ],
                              ),
                            )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              for (var tab in tabs.skip(1))
                Center(
                  child: Text(
                    tab,
                    style: const TextStyle(
                      fontSize: Sizes.size32,
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
