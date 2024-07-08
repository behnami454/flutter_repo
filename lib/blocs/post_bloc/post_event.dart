part of 'post_bloc.dart';

abstract class PostEvent extends Equatable {
  const PostEvent();

  @override
  List<Object> get props => [];
}

class CreatePostEvent extends PostEvent {
  final bool isPublic;
  final String content;
  final String topic;
  final XFile? imageFile;

  const CreatePostEvent({
    required this.isPublic,
    required this.content,
    required this.topic,
    this.imageFile,
  });

  @override
  List<Object> get props => [isPublic, content, topic, imageFile ?? ''];
}