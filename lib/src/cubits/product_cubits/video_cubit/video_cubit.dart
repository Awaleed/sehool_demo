import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:sehool/src/models/video_model.dart';
import 'package:sehool/src/repositories/product_repository.dart';

part 'video_state.dart';
part 'video_cubit.freezed.dart';

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
      addError(e);
      // TODO: Handel error messages
      emit(VideoState.failure(message: '$e'));
    }
  }
}
