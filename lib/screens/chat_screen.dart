import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<Message> messages = [
    Message(
      text: 'Hi , how are you doing ?',
      timestamp: '16:04',
      isMe: true,
      profileImage: 'assets/logos/abc.png',
    ),
    Message(
      text: 'Im good , whats new?',
      timestamp: '16:04',
      isMe: false,
      profileImage: 'assets/logos/abcc.png',
    ),
  ];

  final TextEditingController _textController = TextEditingController();
  XFile? _imageFile;
  final ImagePicker _picker = ImagePicker();

  void _sendMessage() {
    if (_textController.text.isNotEmpty) {
      setState(() {
        messages.add(
          Message(
            text: _textController.text,
            timestamp: '16:04',
            isMe: true,
            profileImage: 'assets/logos/abc.png',
          ),
        );
        _textController.clear();
      });
    }
  }

  void _sendImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = pickedFile;
        messages.add(
          Message(
            imagePath: _imageFile!.path,
            timestamp: '16:04',
            isMe: true,
            profileImage: 'assets/logos/abc.png',
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const SizedBox(),
        title: const Text(
          'Bruno Pham',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 18.0),
            child: IconButton(
              icon: const Icon(Icons.settings, color: Colors.black),
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                return Align(
                  alignment: message.isMe ? Alignment.centerRight : Alignment.centerLeft,
                  child: Row(
                    mainAxisAlignment: message.isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (!message.isMe) ...[
                        CircleAvatar(
                          backgroundImage: AssetImage(message.profileImage),
                          radius: 20,
                        ),
                        const SizedBox(width: 8),
                      ],
                      Flexible(
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 20),
                          padding: const EdgeInsets.all(18.0),
                          decoration: BoxDecoration(
                            color: message.isMe ? Colors.blue[100] : Colors.grey[300],
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (message.text != null)
                                Text(
                                  message.text!,
                                  style: const TextStyle(color: Colors.black),
                                ),
                              if (message.imagePath != null)
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Image.file(
                                    File(message.imagePath!),
                                    height: 150,
                                    width: 150,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Text(
                                  message.timestamp,
                                  style: const TextStyle(color: Colors.black54, fontSize: 10.0),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (message.isMe) ...[
                        const SizedBox(width: 8),
                        CircleAvatar(
                          backgroundImage: AssetImage(message.profileImage),
                          radius: 20,
                        ),
                      ],
                    ],
                  ),
                );
              },
            ),
          ),
          const Divider(height: 1.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.filter, color: Colors.black),
                  onPressed: _sendImage,
                ),
                Expanded(
                  child: TextField(
                    controller: _textController,
                    decoration: const InputDecoration(
                      hintText: 'Type something',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.green),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Message {
  final String? text;
  final String timestamp;
  final bool isMe;
  final String? imagePath;
  final String profileImage;

  Message({
    this.text,
    required this.timestamp,
    required this.isMe,
    this.imagePath,
    required this.profileImage,
  });
}
