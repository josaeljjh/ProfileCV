import '../../core/resources/data_state.dart';
import '../../core/usecase/usecase.dart';
import '../models/experience_model.dart';
import '../repositories/cv_repository.dart';

class GetExperienceUseCase implements UseCase<DataState<List<CompanyExperienceModel>>, LocaleParams> {
  GetExperienceUseCase(this.repository);

  final CvRepository repository;

  @override
  Future<DataState<List<CompanyExperienceModel>>> call({LocaleParams? params}) =>
      repository.getExperience(params!.locale);
}
