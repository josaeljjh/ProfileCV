import 'dart:ui' show Locale;

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
///
/// Only the getters whose content is actual prose (and therefore needs a
/// Spanish/English version) take a [Locale]: [getProfile] (objective),
/// [getExperience] (employment type / period / duration / skills summary)
/// [getSkillGroups] (one Spanish entry among otherwise-English skill names)
/// and [getProjects] (descriptions). [getPortfolio] and [getHomeSkills] are
/// proper nouns/brand names with nothing to translate, and [getContact] is
/// language-neutral (email/phone/URL), so those three stay locale-free.
abstract class CvRepository {
  Future<DataState<ProfileModel>> getProfile(Locale locale);

  Future<DataState<List<PortfolioItemModel>>> getPortfolio();

  Future<DataState<List<String>>> getHomeSkills();

  Future<DataState<List<CompanyExperienceModel>>> getExperience(Locale locale);

  Future<DataState<List<SkillGroupModel>>> getSkillGroups(Locale locale);

  Future<DataState<List<ProjectModel>>> getProjects(Locale locale);

  Future<DataState<ContactModel>> getContact();
}
