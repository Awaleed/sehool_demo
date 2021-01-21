import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../helpers/helper.dart';
import '../../../models/video_model.dart';
import '../../../repositories/product_repository.dart';

part 'video_cubit.freezed.dart';
part 'video_state.dart';

@injectable
class VideoCubit extends Cubit<VideoState> {
  VideoCubit(this._productRepository) : super(const VideoState.loading()) {
    getVideos();
  }

  final IProductRepository _productRepository;

  Future<void> getVideos() async {
    emit(const VideoState.loading());
    try {
      final value = await _productRepository.getVideos();
      emit(VideoState.success(value));
    } catch (e) {
      emit(VideoState.failure(message: Helpers.mapErrorToMessage(e)));
      addError(e);
    }
  }
}
