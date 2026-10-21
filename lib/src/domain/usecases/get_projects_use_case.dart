import '../../core/resources/data_state.dart';
import '../../core/usecase/usecase.dart';
import '../models/project_model.dart';
import '../repositories/cv_repository.dart';

class GetProjectsUseCase implements UseCase<DataState<List<ProjectModel>>, LocaleParams> {
  GetProjectsUseCase(this.repository);

  final CvRepository repository;

  @override
  Future<DataState<List<ProjectModel>>> call({LocaleParams? params}) =>
      repository.getProjects(params!.locale);
}
