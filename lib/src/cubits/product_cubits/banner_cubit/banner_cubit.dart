import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../helpers/helper.dart';
import '../../../models/banner_model.dart';
import '../../../repositories/product_repository.dart';

part 'banner_cubit.freezed.dart';
part 'banner_state.dart';

@injectable
class BannerCubit extends Cubit<BannerState> {
  BannerCubit(this._productRepository) : super(const BannerState.loading()) {
    getBanners();
  }

  final IProductRepository _productRepository;

  Future<void> getBanners() async {
    emit(const BannerState.loading());
    try {
      final value = await _productRepository.getBanners();
      emit(BannerState.success(value));
    } catch (e) {
      emit(BannerState.failure(message: Helpers.mapErrorToMessage(e)));
      addError(e);
    }
  }
}
