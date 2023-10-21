import 'dart:io';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:fe_capstone/main.dart';
import 'package:fe_capstone/models/Message.dart';
import 'package:fe_capstone/ui/components/MessageCard.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<Message> _list = [];
  List<Message> fakeMessages = [
    Message(
      toId: '1',
      msg: 'Met ko?',
      read: 'Hello',
      type: Type.text,
      fromId: '2',
      sent: '1693818359802',
    ),
    Message(
      toId: '2',
      msg: 'Met moi lam nha !',
      read: 'Met moi lam nha',
      type: Type.text,
      fromId: '1',
      sent: '1693818359802',
    ),
    Message(
      toId: '2',
      msg: 'Met moi lam roi do !',
      read: 'Met moi lam nha',
      type: Type.text,
      fromId: '1',
      sent: '1693818359802',
    ),
  ];

  Stream<List<Message>> getAllMessages() async* {
    yield fakeMessages;
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
                icon: Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              title: Text(
                'Khach san Romantic',
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
                    stream: getAllMessages(),
                    builder: (context, snapshot) {
                      print('The data: ${snapshot.data}');
                      final data = snapshot.data ?? [];

                      if (data.isEmpty) {
                        return Center(
                          child: Text(
                            'No messages',
                            style: TextStyle(fontSize: 20),
                          ),
                        );
                      }

                      _list = data;

                      if (_list.isNotEmpty) {
                        return ListView.builder(
                            // reverse: true,
                            itemCount: _list.length,
                            padding: EdgeInsets.only(top: mq.height * .01),
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return MessageCard(
                                message: _list[index],
                              );
                            });
                      } else {
                        return const Center(
                          child: Text(
                            'Xin chào ! ',
                            style: TextStyle(fontSize: 20),
                          ),
                        );
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
                      textEditingController:
                      _textController,
                      config: Config(
                        bgColor: const Color.fromARGB(255, 234, 248, 255),
                        columns: 8,
                        emojiSizeMax: 32 *
                            (Platform.isIOS
                                ? 1.30
                                : 1.0),
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
                  IconButton(
                      onPressed: () async {
                        final ImagePicker picker = ImagePicker();
                        final List<XFile> images =
                        await picker.pickMultiImage(imageQuality: 70);

                        for (var i in images) {
                          print('Image Path: ${i.path}');
                          setState(() {
                            _isUploading = true;
                          });
                          // await APIs.sendChatImage(widget.user, File(i.path!));
                          setState(() {
                            _isUploading = false;
                          });
                        }
                      },
                      icon: const Icon(
                        Icons.image,
                        color: Colors.blueAccent,
                        size: 26,
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
                if (_list.isEmpty) {
                  //on first message (add user to my_user collection of chat user)
                  // APIs.sendFirstMessage(widget.user, _textController.text, Type.text);
                } else {
                  //simply send message
                  // APIs.sendMessage(widget.user, _textController.text, Type.text);
                }
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
