import '../../core/resources/data_state.dart';
import '../../core/usecase/usecase.dart';
import '../models/project_model.dart';
import '../repositories/cv_repository.dart';

class GetProjectsUseCase implements UseCase<DataState<List<ProjectModel>>, NoParams> {
  GetProjectsUseCase(this.repository);

  final CvRepository repository;

  @override
  Future<DataState<List<ProjectModel>>> call({NoParams? params}) => repository.getProjects();
}
