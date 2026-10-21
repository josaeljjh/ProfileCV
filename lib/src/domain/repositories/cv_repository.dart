import '../../core/resources/data_state.dart';
import '../models/contact_model.dart';
import '../models/experience_model.dart';
import '../models/portfolio_item_model.dart';
import '../models/profile_model.dart';
import '../models/project_model.dart';
import '../models/skill_group_model.dart';

/// Single aggregate repository for the CV's own content. Everything here
/// describes one bounded context (Julio's CV), so one repository interface
/// is used rather than one micro-repository per getter.
abstract class CvRepository {
  Future<DataState<ProfileModel>> getProfile();

  Future<DataState<List<PortfolioItemModel>>> getPortfolio();

  Future<DataState<List<String>>> getHomeSkills();

  Future<DataState<List<CompanyExperienceModel>>> getExperience();

  Future<DataState<List<SkillGroupModel>>> getSkillGroups();

  Future<DataState<List<ProjectModel>>> getProjects();

  Future<DataState<ContactModel>> getContact();
}
