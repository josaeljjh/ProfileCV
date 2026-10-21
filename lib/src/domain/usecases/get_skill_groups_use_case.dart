import '../../core/resources/data_state.dart';
import '../../core/usecase/usecase.dart';
import '../models/skill_group_model.dart';
import '../repositories/cv_repository.dart';

class GetSkillGroupsUseCase implements UseCase<DataState<List<SkillGroupModel>>, LocaleParams> {
  GetSkillGroupsUseCase(this.repository);

  final CvRepository repository;

  @override
  Future<DataState<List<SkillGroupModel>>> call({LocaleParams? params}) =>
      repository.getSkillGroups(params!.locale);
}
