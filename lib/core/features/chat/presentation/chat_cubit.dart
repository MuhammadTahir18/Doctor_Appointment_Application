import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/chat_repository.dart';
import '../data/message_model.dart';
part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final ChatRepository _repo = ChatRepository();
  final String doctorId;

  ChatCubit({required this.doctorId}) : super(ChatInitial());

  // Messages stream subscribe karo
  void listenToMessages() {
    emit(ChatLoading());
    _repo.getMessages(doctorId).listen(
          (messages) => emit(ChatLoaded(messages)),
      onError: (e) => emit(ChatError(e.toString())),
    );
  }

  // Message bhejo
  Future<void> sendMessage(String message) async {
    if (message.trim().isEmpty) return;
    try {
      await _repo.sendMessage(doctorId, message);
    } catch (e) {
      emit(ChatError(e.toString()));
    }
  }
}