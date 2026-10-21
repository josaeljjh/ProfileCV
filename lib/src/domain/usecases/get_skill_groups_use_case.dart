import '../../core/resources/data_state.dart';
import '../../core/usecase/usecase.dart';
import '../models/skill_group_model.dart';
import '../repositories/cv_repository.dart';

class GetSkillGroupsUseCase implements UseCase<DataState<List<SkillGroupModel>>, NoParams> {
  GetSkillGroupsUseCase(this.repository);

  final CvRepository repository;

  @override
  Future<DataState<List<SkillGroupModel>>> call({NoParams? params}) => repository.getSkillGroups();
}
