import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neuro/blocs/post_bloc/post_bloc.dart';
import 'package:neuro/screens/chat_screen.dart';
import 'package:neuro/widgets/ui_widgets/buttom_navigation_bar.dart';
import 'package:neuro/widgets/ui_widgets/home_screen_items.dart';
import 'create_post_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _tabs = [
    const FeedTab(),
    const Center(child: Text("Search Content")),
    const CreatePostScreen(),
    const ChatScreen(),
    const Center(child: Text("Profile Content")),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Row(
            children: [
              Flexible(
                child: Text(
                  'CHANCE',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(width: 8),
              Icon(Icons.verified, color: Colors.green),
            ],
          ),
        ),
        actions: const [
          Icon(Icons.notifications_none_outlined, color: Colors.black),
          SizedBox(width: 28),
        ],
      ),
      body: BlocListener<PostBloc, PostState>(
        listener: (context, state) {
          setState(() {});
        },
        child: _tabs[_currentIndex],
      ),
      bottomNavigationBar: buildBottomNavigationBar(_currentIndex, _onTabTapped),
    );
  }
}
