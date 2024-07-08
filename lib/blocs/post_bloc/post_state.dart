part of 'post_bloc.dart';

class PostState extends Equatable {
  final List<Post> posts;

  const PostState({this.posts = const []});

  PostState copyWith({List<Post>? posts}) {
    return PostState(posts: posts ?? this.posts);
  }

  @override
  List<Object> get props => [posts];
}

class Post extends Equatable {
  final bool isPublic;
  final String content;
  final String topic;
  final XFile? imageFile;

  const Post({
    required this.isPublic,
    required this.content,
    required this.topic,
    this.imageFile,
  });

  @override
  List<Object> get props => [isPublic, content, topic, imageFile ?? ''];
}