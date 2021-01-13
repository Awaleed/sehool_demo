import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../models/lazy_list_model.dart';
import '../../repositories/lazy_list_repository.dart';

part 'lazy_list_cubit.freezed.dart';
part 'lazy_list_state.dart';

@injectable
class LazyListCubit extends Cubit<LazyListState> {
  LazyListCubit(this._lazyListRepository)
      : super(const LazyListState.initial());

  final ILazyListRepository _lazyListRepository;
  final _nextPageUrl = ValueNotifier<String>(null);

  Future<void> getContent(LazyListType type) async {
    _nextPageUrl.value = null;
    emit(const LazyListState.loading());

    try {
      final values = await _lazyListRepository.getLazyListValues(
        type: type,
        pageUrl: _nextPageUrl,
      );

      if (_nextPageUrl.value == null) {
        emit(LazyListState.finished(values));
      } else {
        emit(LazyListState.success(values));
      }
    } catch (e) {
      // TODO: Handel error messages
      emit(LazyListState.failure(message: '$e'));
    }
  }

  Future<void> loadMore(LazyListType type) async {
    List currentValues = [];

    state.maybeWhen(
      success: (value) => currentValues = value,
      failureOnLoadMore: (_, value) => currentValues = value,
      orElse: () {},
    );

    emit(LazyListState.loadingMore(currentValues));
    try {
      List values = await _lazyListRepository.getLazyListValues(
        type: type,
        pageUrl: _nextPageUrl,
      );
      currentValues.addAll(values);
      if (_nextPageUrl.value == null) {
        emit(LazyListState.finished(currentValues));
      } else {
        emit(LazyListState.success(currentValues));
      }
    } catch (e) {
      // TODO: Handel error messages
      emit(
        LazyListState.failureOnLoadMore(message: '$e', values: currentValues),
      );
    }
  }
}
