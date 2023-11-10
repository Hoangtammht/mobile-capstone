import 'package:cached_network_image/cached_network_image.dart';
import 'package:fe_capstone/apis/FirebaseAPI.dart';
import 'package:fe_capstone/blocs/UserPreferences.dart';
import 'package:fe_capstone/main.dart';
import 'package:fe_capstone/models/Message.dart';
import 'package:fe_capstone/ui/helper/dialogs.dart';
import 'package:fe_capstone/ui/helper/my_date_until.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MessageCard extends StatefulWidget {
  final MessageCustom message;
  final String userID;
  const MessageCard({Key? key, required this.message, required this.userID}) : super(key: key);

  @override
  State<MessageCard> createState() => _MessageCardState();
}

class _MessageCardState extends State<MessageCard> {

  @override
  void initState() {
    super.initState();
    // getUserID();
  }

  // void getUserID() async {
  //   String? name = await UserPreferences.getUserID();
  //   if (userID != null) {
  //     setState(() {
  //       userID = name!;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return widget.message.fromId == widget.userID ?   _ownerMessage() : _receiveMessage() ;
  }

  Widget _receiveMessage() {
    if (widget.message.toId == widget.userID && widget.message.read.isEmpty) {
      FirebaseAPI.updateMessageStatus(widget.message);
    }
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Flexible(
        child: Container(
          padding: EdgeInsets.all(widget.message.type == Type.image
              ? mq.width * .03
              : mq.width * .04),
          margin: EdgeInsets.symmetric(
              horizontal: mq.width * .04, vertical: mq.height * .01),
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 221, 245, 255),
              border: Border.all(color: Colors.lightBlue),
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                  bottomRight: Radius.circular(30))),
          child: widget.message.type == Type.text
              ?
          //show text
          Text(
            widget.message.msg,
            style: const TextStyle(fontSize: 15, color: Colors.black87),
          )
              :
          //show image
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: CachedNetworkImage(
              imageUrl: 'https://fiftyfifty.b-cdn.net/eparking/scaled_Screenshot_20231022-095624_Animal Puzzle.jpg',
              placeholder: (context, url) => const Padding(
                padding: EdgeInsets.all(8.0),
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              ),
              errorWidget: (context, url, error) =>
              const Icon(Icons.image, size: 70),
            ),
          ),
        ),
      ),

      Padding(
        padding: EdgeInsets.only(right: mq.width * .04),
        child: Text(
          MyDateUtil.getMessageTime(
              context: context, time: widget.message.sent),
          style: const TextStyle(fontSize: 13, color: Colors.black54),
        ),
      ),

    ]);
  }

  Widget _ownerMessage() {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Row(children: [
        SizedBox(
          width: mq.width * .04,
        ),
        const SizedBox(
          width: 2,
        ),
        if(widget.message.read.isNotEmpty)
          const Icon(
            Icons.done_all_rounded,
            color: Colors.blue,
            size: 20,
          ),
        Text(
          MyDateUtil.getMessageTime(
              context: context, time: widget.message.sent),
          style: const TextStyle(fontSize: 13, color: Colors.black54),
        ),
      ]),
      Flexible(
        child: Container(
          padding: EdgeInsets.all(widget.message.type == Type.image
              ? mq.width * .03
              : mq.width * .04),
          margin: EdgeInsets.symmetric(
              horizontal: mq.width * .04, vertical: mq.height * .01),
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 218, 255, 176),
              border: Border.all(color: Colors.lightGreen),
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                  bottomLeft: Radius.circular(30))),
          child: widget.message.type == Type.text
              ?
          //show text
          Text(
            widget.message.msg,
            style: const TextStyle(fontSize: 15, color: Colors.black87),
          )
              :
          //show image
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: CachedNetworkImage(
              imageUrl: 'https://fiftyfifty.b-cdn.net/eparking/scaled_Screenshot_20231022-095624_Animal Puzzle.jpg',
              placeholder: (context, url) => const Padding(
                padding: EdgeInsets.all(8.0),
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              ),
              errorWidget: (context, url, error) =>
              const Icon(Icons.image, size: 70),
            ),
          ),
        ),
      ),
    ]);
    ;
  }


}