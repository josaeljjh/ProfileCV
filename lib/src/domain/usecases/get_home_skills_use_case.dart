import '../../core/resources/data_state.dart';
import '../../core/usecase/usecase.dart';
import '../repositories/cv_repository.dart';

class GetHomeSkillsUseCase implements UseCase<DataState<List<String>>, NoParams> {
  GetHomeSkillsUseCase(this.repository);

  final CvRepository repository;

  @override
  Future<DataState<List<String>>> call({NoParams? params}) => repository.getHomeSkills();
}
