import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc() : super(const PostState()) {
    on<CreatePostEvent>(_onCreatePost);
  }

  void _onCreatePost(CreatePostEvent event, Emitter<PostState> emit) {
    final post = Post(
      isPublic: event.isPublic,
      content: event.content,
      topic: event.topic,
      imageFile: event.imageFile,
    );

    emit(state.copyWith(posts: List.from(state.posts)..add(post)));
  }
}
