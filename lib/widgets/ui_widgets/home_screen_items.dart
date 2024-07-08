import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neuro/blocs/post_bloc/post_bloc.dart';

class FeedTab extends StatelessWidget {
  const FeedTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      length: 2,
      child: Column(
        children: [
          TabBar(
            indicatorColor: Colors.green,
            labelColor: Colors.green,
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(text: 'Public Feed'),
              Tab(text: 'Business Feed'),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                FeedList(feedType: 'Public Feed'),
                FeedList(feedType: 'Business Feed'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FeedList extends StatefulWidget {
  final String feedType;
  const FeedList({super.key, required this.feedType});

  @override
  State<FeedList> createState() => _FeedListState();
}

class _FeedListState extends State<FeedList> {
  String? selectedTopic;
  final List<String> topics = ["Climate Change & Sustainability", "Conscious Art", "Others"];

  void _filterByTopic(String topic) {
    setState(() {
      selectedTopic = topic;
    });
  }

  void _showFilterSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return ListView(
          children: topics.map((topic) {
            return ListTile(
              leading: Image.asset('assets/logos/abcc.png', width: 40, height: 40),
              title: Text(topic),
              onTap: () {
                Navigator.pop(context);
                _filterByTopic(topic);
              },
            );
          }).toList(),
        );
      },
    );
  }

  Future<void> _onRefresh() async {
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 18.0),
                child: Text(
                  'Feeds',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 18.0),
                child: GestureDetector(
                  onTap: _showFilterSheet,
                  child: const Icon(Icons.filter_alt_outlined, color: Colors.black),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: BlocBuilder<PostBloc, PostState>(
            builder: (context, state) {
              final posts = state.posts
                  .where((post) =>
                      post.isPublic == (widget.feedType == 'Public Feed') &&
                      (selectedTopic == null || post.topic == selectedTopic))
                  .toList();

              if (posts.isEmpty) {
                return const Padding(
                  padding: EdgeInsets.only(top: 58.0),
                  child: Center(child: Text('No posts available')),
                );
              }

              return RefreshIndicator(
                onRefresh: _onRefresh,
                child: ListView.builder(
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    final post = posts[index];
                    return Column(
                      children: [
                        FeedItem(post: post),
                      ],
                    );
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class FeedItem extends StatelessWidget {
  final Post post;

  const FeedItem({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.blueGrey[50],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    backgroundImage: AssetImage('assets/logos/abc.png'),
                    radius: 20,
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Text(
                            'James',
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                          ),
                          SizedBox(width: 4),
                          Icon(Icons.verified, color: Colors.green, size: 16),
                          SizedBox(width: 4),
                          Text(
                            '• 1 hour ago',
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                      Text(
                        post.topic,
                        style: const TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                  const Spacer(),
                  const Icon(Icons.more_vert, color: Colors.grey),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                post.content,
                style: const TextStyle(color: Colors.black, fontSize: 14),
              ),
              if (post.imageFile != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Image.file(
                    File(post.imageFile!.path),
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              const SizedBox(height: 8),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.favorite_border, color: Colors.black),
                  SizedBox(width: 5),
                  Icon(Icons.chat_bubble_outline, color: Colors.black),
                  SizedBox(width: 5),
                  Icon(Icons.send, color: Colors.black),
                  SizedBox(width: 5),
                  Spacer(),
                  Icon(Icons.bookmark_border, color: Colors.black),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
