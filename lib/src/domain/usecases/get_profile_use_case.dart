import '../../core/resources/data_state.dart';
import '../../core/usecase/usecase.dart';
import '../models/profile_model.dart';
import '../repositories/cv_repository.dart';

class GetProfileUseCase implements UseCase<DataState<ProfileModel>, NoParams> {
  GetProfileUseCase(this.repository);

  final CvRepository repository;

  @override
  Future<DataState<ProfileModel>> call({NoParams? params}) => repository.getProfile();
}
