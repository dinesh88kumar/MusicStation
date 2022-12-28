import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musicstation/bloc/app_events.dart';
import 'package:musicstation/bloc/app_states.dart';
import 'package:musicstation/repo/repository.dart';

class ProductBloc extends Bloc<ProductEvents, ProductState> {
  final Repo repo;
  ProductBloc({required this.repo}) : super(InitialState()) {
    on<Create>(((event, emit) async {
      emit(ProductAdding());
      // await Future.delayed(const Duration(seconds: 1));
      try {
        await repo.create(
            songname: event.songname,
            authorname: event.authorname,
            favourite: event.favourite);
        emit(ProductAdded());
      } catch (e) {
        emit(ProductError(e.toString()));
      }
    }));
    on<Update>(((event, emit) async {
      emit(ProductAdding());
      // await Future.delayed(const Duration(seconds: 1));
      try {
        await repo.update(
            songname: event.songname,
            authorname: event.authorname,
            favourite: event.favourite,
            id: event.id);
        emit(ProductAdded());
      } catch (e) {
        emit(ProductError(e.toString()));
      }
    }));

    on<Getdata>((event, emit) async {
      emit(ProductLoading());
      // await Future.delayed(const Duration(seconds: 1));
      try {
        final data = await repo.get();
        emit(ProductLoaded(data));
      } catch (e) {
        emit(ProductError(e.toString()));
      }
    });

    on<GetdataF>((event, emit) async {
      emit(ProductLoading());
      // await Future.delayed(const Duration(seconds: 1));
      try {
        final data = await repo.getfav();
        emit(ProductLoadedF(data));
      } catch (e) {
        emit(ProductError(e.toString()));
      }
    });
  }
}
