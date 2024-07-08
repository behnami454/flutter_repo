import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:neuro/blocs/post_bloc/post_bloc.dart';
import 'package:neuro/widgets/ui_widgets/dialog_screen.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({Key? key}) : super(key: key);

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  bool isPublic = true;
  final List<String> topics = ["Climate Change & Sustainability", "Conscious Art", "Others"];
  String? selectedTopic;
  XFile? _imageFile;
  final ImagePicker _picker = ImagePicker();
  final TextEditingController _textController = TextEditingController();

  void _togglePostType(bool isPublic) {
    setState(() {
      this.isPublic = isPublic;
    });
  }

  void _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    setState(() {
      _imageFile = pickedFile;
    });
  }

  void _createPost() {
    if (_textController.text.isEmpty || selectedTopic == null) {
      showCustomDialog(context, 'Please fill all fields');

      return;
    }

    context.read<PostBloc>().add(CreatePostEvent(
          isPublic: isPublic,
          content: _textController.text,
          topic: selectedTopic!,
          imageFile: _imageFile,
        ));

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Post created successfully')),
    );

    _textController.clear();
    setState(() {
      selectedTopic = null;
      _imageFile = null;
    });

    Navigator.pushNamedAndRemoveUntil(context, '/home', (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Create Post',
          style: TextStyle(color: Colors.black),
        ),
        leading: const SizedBox(),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 18.0),
            child: TextButton(
              onPressed: _createPost,
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.green,
                    border: Border.all(color: Colors.green),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Post',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => _togglePostType(true),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: isPublic ? Colors.green : Colors.transparent,
                        border: Border.all(color: Colors.green),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          'Public',
                          style: TextStyle(
                            color: isPublic ? Colors.white : Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: GestureDetector(
                    onTap: () => _togglePostType(false),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: !isPublic ? Colors.green : Colors.transparent,
                        border: Border.all(color: Colors.green),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          'Business',
                          style: TextStyle(
                            color: !isPublic ? Colors.white : Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _textController,
              decoration: const InputDecoration(
                hintText: 'Type something',
              ),
              maxLines: 12,
            ),
            const SizedBox(height: 16),
            const Text(
              'Topics :',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Wrap(
              spacing: 8.0,
              children: topics.map((topic) {
                return ChoiceChip(
                  label: Text(topic),
                  selected: selectedTopic == topic,
                  onSelected: (selected) {
                    setState(() {
                      selectedTopic = selected ? topic : null;
                    });
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.photo_camera),
                  onPressed: () => _pickImage(ImageSource.camera),
                ),
                IconButton(
                  icon: const Icon(Icons.photo_library),
                  onPressed: () => _pickImage(ImageSource.gallery),
                ),
                if (_imageFile != null)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.file(
                      File(_imageFile!.path),
                      height: 50,
                      width: 50,
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
