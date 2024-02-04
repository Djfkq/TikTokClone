import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktokclonepractice/constants/gaps.dart';
import 'package:tiktokclonepractice/constants/sizes.dart';
import 'package:tiktokclonepractice/utils.dart';

class ChatDetailScreen extends StatefulWidget {
  final String chatId;
  const ChatDetailScreen({
    super.key,
    required this.chatId,
  });

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  bool _isWriting = false;
  void _onTextChange(String value) {
    if (value != "") {
      _isWriting = true;
    } else {
      _isWriting = false;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ListTile(
          contentPadding: EdgeInsets.zero,
          horizontalTitleGap: Sizes.size8,
          leading: Stack(
            children: [
              const CircleAvatar(
                radius: Sizes.size20,
                foregroundImage: NetworkImage(
                    "https://avatars.githubusercontent.com/u/87645151?v=4"),
                child: Text(
                  "니꼬",
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: Sizes.size20,
                  height: Sizes.size20,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white,
                      width: Sizes.size3,
                    ),
                    shape: BoxShape.circle,
                    color: Colors.green,
                  ),
                ),
              )
            ],
          ),
          title: Text(
            "xxxxmm967 [${widget.chatId}]",
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: const Text(
            "Active now",
          ),
          trailing: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              FaIcon(
                FontAwesomeIcons.flag,
                size: Sizes.size20,
              ),
              Gaps.h20,
              FaIcon(
                FontAwesomeIcons.ellipsis,
                size: Sizes.size20,
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          ListView.separated(
            padding: const EdgeInsets.symmetric(
              vertical: Sizes.size20,
              horizontal: Sizes.size14,
            ),
            itemBuilder: (context, index) {
              final isMine = index % 2 == 0;
              return Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment:
                    isMine ? MainAxisAlignment.end : MainAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(
                      Sizes.size14,
                    ),
                    decoration: BoxDecoration(
                      color: isMine ? Colors.blue : Colors.red,
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(
                          Sizes.size20,
                        ),
                        topRight: const Radius.circular(
                          Sizes.size20,
                        ),
                        bottomLeft: Radius.circular(
                          isMine ? Sizes.size20 : Sizes.size5,
                        ),
                        bottomRight: Radius.circular(
                          isMine ? Sizes.size5 : Sizes.size20,
                        ),
                      ),
                    ),
                    child: const Text(
                      "This is a message",
                      style: TextStyle(
                        fontSize: Sizes.size16,
                      ),
                    ),
                  ),
                ],
              );
            },
            separatorBuilder: (context, index) => Gaps.v10,
            itemCount: 20,
          ),
          Positioned(
            bottom: 0,
            width: MediaQuery.of(context).size.width,
            child: BottomAppBar(
              color: isDarkMode(context) ? Colors.black : null,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Sizes.size20,
                  vertical: Sizes.size24,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _textEditingController,
                        onChanged: _onTextChange,
                        decoration: const InputDecoration(
                            hintText: "Send a message..."),
                      ),
                    ),
                    Gaps.h10,
                    const FaIcon(
                      FontAwesomeIcons.faceSmile,
                      size: Sizes.size24,
                    ),
                    Gaps.h10,
                    Container(
                      height: Sizes.size32,
                      width: Sizes.size32,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _isWriting ? Colors.blue : Colors.grey.shade400,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FaIcon(
                            FontAwesomeIcons.paperPlane,
                            color: _isWriting ? Colors.white : Colors.black,
                            size: Sizes.size20,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
      /////////////////////////////////////////////////////////////////////////
      // body: Padding(
      //   padding: const EdgeInsets.symmetric(
      //     horizontal: Sizes.size12,
      //   ),
      //   child: Stack(
      //     children: [
      //       Positioned(
      //         bottom: 0,
      //         child: Row(
      //           children: [
      //             Container(
      //               padding: const EdgeInsets.symmetric(
      //                 horizontal: Sizes.size10,
      //                 vertical: Sizes.size5,
      //               ),
      //               decoration: BoxDecoration(
      //                 color: isDarkMode(context)
      //                     ? Colors.grey.shade700
      //                     : Colors.grey.shade300,
      //                 borderRadius: BorderRadius.circular(
      //                   Sizes.size20,
      //                 ),
      //               ),
      //               child: const Row(
      //                 children: [
      //                   FaIcon(
      //                     FontAwesomeIcons.solidHeart,
      //                     color: Colors.red,
      //                     size: Sizes.size20,
      //                   ),
      //                   FaIcon(
      //                     FontAwesomeIcons.solidHeart,
      //                     color: Colors.red,
      //                     size: Sizes.size20,
      //                   ),
      //                   FaIcon(
      //                     FontAwesomeIcons.solidHeart,
      //                     color: Colors.red,
      //                     size: Sizes.size20,
      //                   ),
      //                 ],
      //               ),
      //             ),
      //             Container(
      //               padding: const EdgeInsets.symmetric(
      //                 horizontal: Sizes.size10,
      //                 vertical: Sizes.size5,
      //               ),
      //               decoration: BoxDecoration(
      //                 color: isDarkMode(context)
      //                     ? Colors.grey.shade700
      //                     : Colors.grey.shade300,
      //                 borderRadius: BorderRadius.circular(
      //                   Sizes.size20,
      //                 ),
      //               ),
      //               child: const Row(
      //                 children: [
      //                   FaIcon(
      //                     FontAwesomeIcons.solidFaceSadCry,
      //                     size: Sizes.size20,
      //                   ),
      //                   FaIcon(
      //                     FontAwesomeIcons.solidFaceSadCry,
      //                     size: Sizes.size20,
      //                   ),
      //                   FaIcon(
      //                     FontAwesomeIcons.solidFaceSadCry,
      //                     size: Sizes.size20,
      //                   ),
      //                 ],
      //               ),
      //             ),
      //             Container(
      //               padding: const EdgeInsets.symmetric(
      //                 horizontal: Sizes.size10,
      //                 vertical: Sizes.size5,
      //               ),
      //               decoration: BoxDecoration(
      //                 color: isDarkMode(context)
      //                     ? Colors.grey.shade700
      //                     : Colors.grey.shade300,
      //                 borderRadius: BorderRadius.circular(
      //                   Sizes.size20,
      //                 ),
      //               ),
      //               child: const Row(
      //                 children: [
      //                   FaIcon(
      //                     FontAwesomeIcons.solidThumbsUp,
      //                     size: Sizes.size20,
      //                   ),
      //                   FaIcon(
      //                     FontAwesomeIcons.solidThumbsUp,
      //                     size: Sizes.size20,
      //                   ),
      //                   FaIcon(
      //                     FontAwesomeIcons.solidThumbsUp,
      //                     size: Sizes.size20,
      //                   ),
      //                 ],
      //               ),
      //             ),
      //             Container(
      //               padding: const EdgeInsets.symmetric(
      //                 horizontal: Sizes.size10,
      //                 vertical: Sizes.size5,
      //               ),
      //               decoration: BoxDecoration(
      //                 color: isDarkMode(context)
      //                     ? Colors.grey.shade700
      //                     : Colors.grey.shade300,
      //                 borderRadius: BorderRadius.circular(
      //                   Sizes.size20,
      //                 ),
      //               ),
      //               child: const Row(
      //                 children: [
      //                   FaIcon(
      //                     FontAwesomeIcons.circlePlay,
      //                   ),
      //                   Text(
      //                     "Share post",
      //                     style: TextStyle(
      //                       fontSize: Sizes.size12,
      //                       fontWeight: FontWeight.bold,
      //                     ),
      //                   ),
      //                 ],
      //               ),
      //             ),
      //           ],
      //         ),
      //       ),
      //       Column(
      //         children: [
      //           const Row(
      //             mainAxisAlignment: MainAxisAlignment.center,
      //             children: [
      //               Text(
      //                 "December 16, 2022 3:29 PM",
      //               ),
      //             ],
      //           ),
      //           Gaps.v14,
      //           Row(
      //             mainAxisAlignment: MainAxisAlignment.end,
      //             children: [
      //               Container(
      //                 padding: const EdgeInsets.symmetric(
      //                   horizontal: Sizes.size12,
      //                   vertical: Sizes.size10,
      //                 ),
      //                 decoration: BoxDecoration(
      //                   color: Colors.blue,
      //                   borderRadius: BorderRadius.circular(
      //                     Sizes.size20,
      //                   ),
      //                 ),
      //                 child: const Text(
      //                   "Hahahaha",
      //                   textAlign: TextAlign.center,
      //                   style: TextStyle(
      //                     fontSize: Sizes.size20,
      //                     color: Colors.white,
      //                   ),
      //                 ),
      //               ),
      //             ],
      //           ),
      //           Gaps.v14,
      //           const Row(
      //             mainAxisAlignment: MainAxisAlignment.end,
      //             children: [
      //               FaIcon(
      //                 FontAwesomeIcons.thumbsUp,
      //                 size: Sizes.size40,
      //               ),
      //               FaIcon(
      //                 FontAwesomeIcons.thumbsUp,
      //                 size: Sizes.size40,
      //               ),
      //               FaIcon(
      //                 FontAwesomeIcons.thumbsUp,
      //                 size: Sizes.size40,
      //               ),
      //             ],
      //           ),
      //           Gaps.v14,
      //           const Row(
      //             mainAxisAlignment: MainAxisAlignment.end,
      //             children: [
      //               FaIcon(
      //                 FontAwesomeIcons.solidFaceSadCry,
      //                 size: Sizes.size40,
      //               ),
      //               FaIcon(
      //                 FontAwesomeIcons.solidFaceSadCry,
      //                 size: Sizes.size40,
      //               ),
      //               FaIcon(
      //                 FontAwesomeIcons.solidFaceSadCry,
      //                 size: Sizes.size40,
      //               ),
      //             ],
      //           ),
      //           Gaps.v14,
      //           const Row(
      //             mainAxisAlignment: MainAxisAlignment.end,
      //             children: [
      //               FaIcon(
      //                 FontAwesomeIcons.solidHeart,
      //                 size: Sizes.size40,
      //                 color: Colors.red,
      //               ),
      //               FaIcon(
      //                 FontAwesomeIcons.solidHeart,
      //                 size: Sizes.size40,
      //                 color: Colors.red,
      //               ),
      //               FaIcon(
      //                 FontAwesomeIcons.solidHeart,
      //                 size: Sizes.size40,
      //                 color: Colors.red,
      //               ),
      //             ],
      //           ),
      //           Gaps.v14,
      //           const Row(
      //             mainAxisAlignment: MainAxisAlignment.end,
      //             children: [
      //               FaIcon(
      //                 FontAwesomeIcons.arrowUp,
      //                 size: Sizes.size40,
      //               ),
      //               Gaps.h8,
      //               Text("Send")
      //             ],
      //           )
      //         ],
      //       ),
      //     ],
      //   ),
      // ),
      // bottomNavigationBar: BottomAppBar(
      //   color: isDarkMode(context) ? Colors.black : null,
      //   child: Padding(
      //     padding: const EdgeInsets.symmetric(
      //       horizontal: Sizes.size20,
      //       vertical: Sizes.size24,
      //     ),
      //     child: Row(
      //       children: [
      //         Expanded(
      //           child: TextField(
      //             controller: _textEditingController,
      //             onChanged: _onTextChange,
      //             decoration:
      //                 const InputDecoration(hintText: "Send a message..."),
      //           ),
      //         ),
      //         Gaps.h10,
      //         const FaIcon(
      //           FontAwesomeIcons.faceSmile,
      //           size: Sizes.size24,
      //         ),
      //         Gaps.h10,
      //         Container(
      //           height: Sizes.size32,
      //           width: Sizes.size32,
      //           decoration: BoxDecoration(
      //             shape: BoxShape.circle,
      //             color: _isWriting ? Colors.blue : Colors.grey.shade400,
      //           ),
      //           child: Row(
      //             mainAxisAlignment: MainAxisAlignment.center,
      //             children: [
      //               FaIcon(
      //                 FontAwesomeIcons.paperPlane,
      //                 color: _isWriting ? Colors.white : Colors.black,
      //                 size: Sizes.size20,
      //               ),
      //             ],
      //           ),
      //         )
      //       ],
      //     ),
      //   ),
      // ),
      /////////////////////////////////////////////////////////////////////////
    );
  }
}
