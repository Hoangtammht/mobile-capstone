import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:fe_capstone/apis/FirebaseAPI.dart';
import 'package:fe_capstone/blocs/UserPreferences.dart';
import 'package:fe_capstone/main.dart';
import 'package:fe_capstone/models/Message.dart';
import 'package:fe_capstone/ui/components/MessageCard.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../models/ChatUser.dart';

class ChatScreen extends StatefulWidget {
  final ChatUser user;
  const ChatScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<MessageCustom> _list = [];
  String userID = '';
  Stream<QuerySnapshot<Map<String, dynamic>>>? stream;

  @override
  void initState() {
    super.initState();
    getUserID();
    getStream();
  }

  void getUserID() async {
    String? name = await UserPreferences.getUserID();
    if (userID != null) {
      setState(() {
        userID = name!;
      });
    }
  }

  void getStream() async {
    Stream<QuerySnapshot<Map<String, dynamic>>> data = await FirebaseAPI.getAllMessages(widget.user);
    if (data != null) {
      setState(() {
        stream = data!;
      });
    }
  }

  final _textController = TextEditingController();
  bool _showEmoji = false, _isUploading = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SafeArea(
        child: WillPopScope(
          onWillPop: () {
            if (_showEmoji) {
              setState(() {
                _showEmoji = !_showEmoji;
              });
              return Future.value(false);
            } else {
              return Future.value(true);
            }
          },
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).primaryColor,
              centerTitle: true,
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              title: Text(
                widget.user.name,
                style: TextStyle(
                  fontSize: 26 * ffem,
                  fontWeight: FontWeight.w700,
                  height: 1.175 * ffem / fem,
                  color: Color(0xffffffff),
                ),
              ),
            ),
            backgroundColor: const Color.fromARGB(255, 234, 248, 255),
            body: Column(
              children: [
                Expanded(
                  child: StreamBuilder(
                    // stream: getAllMessages(),
                    stream: stream,
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                        case ConnectionState.none:
                          return const Center(
                              child: CircularProgressIndicator());
                        case ConnectionState.active:
                        case ConnectionState.done:
                          final data = snapshot.data?.docs;
                          _list = data?.map((e) => MessageCustom.fromJson(e.data())).toList() ?? [];

                          if (_list.isNotEmpty) {
                            return ListView.builder(
                              // reverse: true,
                                itemCount: _list.length,
                                padding: EdgeInsets.only(top: mq.height * .01),
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return MessageCard(
                                    message: _list[index], userID: userID,
                                  );
                                });
                          } else {
                            return const Center(
                              child: Text(
                                'Xin chào ! 👋 ',
                                style: TextStyle(fontSize: 20),
                              ),
                            );
                          }
                      }
                    },
                  ),
                ),
                if (_isUploading)
                  const Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                          padding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                          ))),
                _chatInput(),
                if (_showEmoji)
                  SizedBox(
                    height: mq.height * .35,
                    child: EmojiPicker(
                      textEditingController: _textController,
                      config: Config(
                        bgColor: const Color.fromARGB(255, 234, 248, 255),
                        columns: 8,
                        emojiSizeMax: 32 * (Platform.isIOS ? 1.30 : 1.0),
                      ),
                    ),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _chatInput() {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: mq.height * .01, horizontal: mq.width * .025),
      child: Row(
        children: [
          Expanded(
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        setState(() {
                          _showEmoji = !_showEmoji;
                        });
                      },
                      icon: const Icon(
                        Icons.emoji_emotions,
                        color: Colors.blueAccent,
                        size: 25,
                      )),
                  Expanded(
                      child: TextField(
                        controller: _textController,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        onTap: () {
                          if (_showEmoji) setState(() => _showEmoji = !_showEmoji);
                        },
                        decoration: const InputDecoration(
                            hintText: 'Type Something...',
                            hintStyle: TextStyle(color: Colors.blueAccent),
                            border: InputBorder.none),
                      )),
                  SizedBox(
                    width: mq.width * .02,
                  )
                ],
              ),
            ),
          ),
          MaterialButton(
            onPressed: () {
              if (_textController.text.isNotEmpty) {
                FirebaseAPI.sendMessage(widget.user, _textController.text);
                _textController.text = '';
              }
            },
            minWidth: 0,
            padding:
            const EdgeInsets.only(top: 10, bottom: 10, right: 5, left: 10),
            shape: const CircleBorder(),
            color: Colors.green,
            child: const Icon(
              Icons.send,
              color: Colors.white,
              size: 28,
            ),
          )
        ],
      ),
    );
  }
}