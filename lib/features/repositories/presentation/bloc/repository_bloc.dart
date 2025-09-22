import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gemini_test/core/usecases/usecase.dart';
import 'package:gemini_test/features/repositories/domain/usecases/get_top_repositories.dart';
import 'package:gemini_test/features/repositories/presentation/bloc/repository_event.dart';
import 'package:gemini_test/features/repositories/presentation/bloc/repository_state.dart';

class RepositoryBloc extends Bloc<RepositoryEvent, RepositoryState> {
  final GetTopRepositories getTopRepositories;

  RepositoryBloc({required this.getTopRepositories}) : super(RepositoryInitial()) {
    on<GetRepositories>((event, emit) async {
      emit(RepositoryLoading());
      final failureOrRepositories = await getTopRepositories(Params(technology: event.technology));
      failureOrRepositories.fold(
        (failure) => emit(RepositoryError(failure.toString())),
        (repositories) => emit(RepositoryLoaded(repositories)),
      );
    });
  }
}