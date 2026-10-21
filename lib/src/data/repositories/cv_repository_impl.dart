import 'dart:ui' show Locale;

import '../../core/resources/data_state.dart';
import '../../domain/models/contact_model.dart';
import '../../domain/models/experience_model.dart';
import '../../domain/models/portfolio_item_model.dart';
import '../../domain/models/profile_model.dart';
import '../../domain/models/project_model.dart';
import '../../domain/models/skill_group_model.dart';
import '../../domain/repositories/cv_repository.dart';

/// Static-data implementation: the CV's content doesn't come from a remote
/// API or local database (yet), so this simply returns the real CV data
/// wrapped in [DataSuccess]. Kept behind the same [CvRepository] interface
/// a future network-backed implementation would use, so nothing above this
/// layer needs to change if that data source changes later.
///
/// Locale-dependent getters branch on `locale.languageCode == 'en'`, the
/// same check app.dart's `localeResolutionCallback` uses to pick a locale —
/// English if the device is English, Spanish for anything else.
class CvRepositoryImpl implements CvRepository {
  bool _isEnglish(Locale locale) => locale.languageCode == 'en';

  @override
  Future<DataState<ProfileModel>> getProfile(Locale locale) async {
    try {
      final profile = _isEnglish(locale)
          ? const ProfileModel(
              name: 'Julio Josaél Hernández Peréz',
              title: 'Senior Mobile Engineer',
              location: 'El Salvador',
              objective: 'Being part of a work team and growing professionally in a '
                  'company that recognizes personal achievements and performance, '
                  'while offering opportunities for personal and professional '
                  'development.',
              avatarAsset: 'assets/images/profile.jpg',
            )
          : const ProfileModel(
              name: 'Julio Josaél Hernández Peréz',
              title: 'Senior Mobile Engineer',
              location: 'El Salvador',
              objective: 'Ser parte de un equipo de trabajo y consolidarme profesionalmente en una '
                  'empresa donde se reconozcan los logros personales y el desempeño, además '
                  'de permitir oportunidades de desarrollo personal y profesional.',
              avatarAsset: 'assets/images/profile.jpg',
            );
      return DataSuccess(profile);
    } catch (e) {
      return DataError(e);
    }
  }

  @override
  Future<DataState<List<PortfolioItemModel>>> getPortfolio() async {
    try {
      // Brand/app names — proper nouns, no translation needed.
      const portfolio = [
        PortfolioItemModel(
          title: 'N1CO App',
          iconKey: 'account_balance_wallet_outlined',
          colorKey: 'iceberg',
        ),
        PortfolioItemModel(
          title: 'N1CO Business',
          iconKey: 'storefront_outlined',
          colorKey: 'edgeWater',
        ),
        PortfolioItemModel(
          title: 'Hugo App',
          iconKey: 'delivery_dining_outlined',
          colorKey: 'dirtyPink300',
        ),
        PortfolioItemModel(
          title: 'Scotiabank App',
          iconKey: 'account_balance_outlined',
          colorKey: 'soap400',
        ),
        PortfolioItemModel(
          title: 'Pagalo App',
          iconKey: 'payments_outlined',
          colorKey: 'lili300',
        ),
        PortfolioItemModel(
          title: 'AFP Confia',
          iconKey: 'savings_outlined',
          colorKey: 'polar',
        ),
        PortfolioItemModel(
          title: 'Yummy App',
          iconKey: 'restaurant_outlined',
          colorKey: 'auxAlert100',
        ),
        PortfolioItemModel(
          title: 'Gourmet Express',
          iconKey: 'fastfood_outlined',
          colorKey: 'soap300',
        ),
      ];
      return const DataSuccess(portfolio);
    } catch (e) {
      return DataError(e);
    }
  }

  @override
  Future<DataState<List<String>>> getHomeSkills() async {
    try {
      // Technology names — proper nouns, no translation needed.
      const skills = [
        'Flutter',
        'Kotlin',
        'Swift',
        'Dart',
        'Clean Architecture',
        'Jetpack Compose',
      ];
      return const DataSuccess(skills);
    } catch (e) {
      return DataError(e);
    }
  }

  @override
  Future<DataState<List<CompanyExperienceModel>>> getExperience(Locale locale) async {
    try {
      final experience = _isEnglish(locale) ? _experienceEn : _experienceEs;
      return DataSuccess(experience);
    } catch (e) {
      return DataError(e);
    }
  }

  static const List<CompanyExperienceModel> _experienceEs = [
    CompanyExperienceModel(
      company: 'n1co',
      logoInitials: 'n1',
      logoColorKey: 'black',
      totalDuration: '4 años 9 meses',
      roles: [
        RoleModel(
          title: 'Staff Engineer',
          period: 'feb. de 2025 - actualidad',
          duration: '1 año 9 meses',
          skills: 'Claude Code, Flutter y 4 aptitudes más',
          employmentType: 'Jornada completa',
        ),
        RoleModel(
          title: 'Senior Flutter Engineer | TechLead',
          period: 'feb. de 2024 - actualidad',
          duration: '2 años 9 meses',
          skills: 'Flutter, Clean Architecture y 3 aptitudes más',
        ),
        RoleModel(
          title: 'Senior Flutter Engineer',
          period: 'feb. de 2023 - feb. de 2024',
          duration: '1 año 1 mes',
          skills: 'Flutter, Bloc y 2 aptitudes más',
        ),
        RoleModel(
          title: 'Senior Android Engineer',
          period: 'feb. de 2022 - feb. de 2023',
          duration: '1 año 1 mes',
          skills: 'Jetpack Compose UI, Android y 1 aptitud más',
          employmentType: 'Jornada completa',
        ),
      ],
    ),
    CompanyExperienceModel(
      company: 'hugo',
      logoInitials: 'h',
      logoColorKey: 'butterflyBush',
      roles: [
        RoleModel(
          title: 'Senior Android Engineer',
          period: 'ene. de 2021 - feb. de 2022',
          duration: '1 año 2 meses',
          skills: 'Clean Architecture, Android Jetpack y 1 aptitud más',
        ),
      ],
    ),
    CompanyExperienceModel(
      company: 'OE Internacional',
      logoInitials: 'OE',
      logoColorKey: 'carbon100',
      roles: [
        RoleModel(
          title: 'Senior Android Developer',
          period: 'feb. de 2020 - ene. de 2021',
          duration: '1 año',
          skills: '',
        ),
      ],
    ),
    CompanyExperienceModel(
      company: 'Elaniin',
      logoInitials: 'E',
      logoColorKey: 'secondary500',
      roles: [
        RoleModel(
          title: 'Senior Android Developer',
          period: 'mar. de 2019 - feb. de 2020',
          duration: '1 año',
          skills: '',
        ),
      ],
    ),
    CompanyExperienceModel(
      company: 'Mobile SV',
      logoInitials: 'M',
      logoColorKey: 'carbon400',
      roles: [
        RoleModel(
          title: 'Android Developer',
          period: '2016 - 2019',
          duration: '3 años',
          skills: 'Jetpack Compose, Clean Architecture',
        ),
      ],
    ),
  ];

  static const List<CompanyExperienceModel> _experienceEn = [
    CompanyExperienceModel(
      company: 'n1co',
      logoInitials: 'n1',
      logoColorKey: 'black',
      totalDuration: '4 years 9 months',
      roles: [
        RoleModel(
          title: 'Staff Engineer',
          period: 'Feb 2025 - present',
          duration: '1 year 9 months',
          skills: 'Claude Code, Flutter and 4 more skills',
          employmentType: 'Full-time',
        ),
        RoleModel(
          title: 'Senior Flutter Engineer | TechLead',
          period: 'Feb 2024 - present',
          duration: '2 years 9 months',
          skills: 'Flutter, Clean Architecture and 3 more skills',
        ),
        RoleModel(
          title: 'Senior Flutter Engineer',
          period: 'Feb 2023 - Feb 2024',
          duration: '1 year 1 month',
          skills: 'Flutter, Bloc and 2 more skills',
        ),
        RoleModel(
          title: 'Senior Android Engineer',
          period: 'Feb 2022 - Feb 2023',
          duration: '1 year 1 month',
          skills: 'Jetpack Compose UI, Android and 1 more skill',
          employmentType: 'Full-time',
        ),
      ],
    ),
    CompanyExperienceModel(
      company: 'hugo',
      logoInitials: 'h',
      logoColorKey: 'butterflyBush',
      roles: [
        RoleModel(
          title: 'Senior Android Engineer',
          period: 'Jan 2021 - Feb 2022',
          duration: '1 year 2 months',
          skills: 'Clean Architecture, Android Jetpack and 1 more skill',
        ),
      ],
    ),
    CompanyExperienceModel(
      company: 'OE Internacional',
      logoInitials: 'OE',
      logoColorKey: 'carbon100',
      roles: [
        RoleModel(
          title: 'Senior Android Developer',
          period: 'Feb 2020 - Jan 2021',
          duration: '1 year',
          skills: '',
        ),
      ],
    ),
    CompanyExperienceModel(
      company: 'Elaniin',
      logoInitials: 'E',
      logoColorKey: 'secondary500',
      roles: [
        RoleModel(
          title: 'Senior Android Developer',
          period: 'Mar 2019 - Feb 2020',
          duration: '1 year',
          skills: '',
        ),
      ],
    ),
    CompanyExperienceModel(
      company: 'Mobile SV',
      logoInitials: 'M',
      logoColorKey: 'carbon400',
      roles: [
        RoleModel(
          title: 'Android Developer',
          period: '2016 - 2019',
          duration: '3 years',
          skills: 'Jetpack Compose, Clean Architecture',
        ),
      ],
    ),
  ];

  @override
  Future<DataState<List<SkillGroupModel>>> getSkillGroups(Locale locale) async {
    try {
      final groups = _isEnglish(locale) ? _skillGroupsEn : _skillGroupsEs;
      return DataSuccess(groups);
    } catch (e) {
      return DataError(e);
    }
  }

  static const List<SkillGroupModel> _skillGroupsEs = [
    SkillGroupModel(category: 'Flutter / Dart', skills: [
      'Senior Flutter Engineer',
      'Flutter Bloc/Cubit',
      'Dart',
      'Unit Test in Flutter with Mockito',
      'Dependency Injection',
    ]),
    SkillGroupModel(category: 'Android / Kotlin', skills: [
      'Senior Android Engineer',
      'Kotlin',
      'Jetpack Compose',
      'Coroutines/Flow',
      'Kotlin Multiplatform',
    ]),
    SkillGroupModel(category: 'Arquitectura y herramientas', skills: [
      'Clean Architecture',
      'Realm and Room',
      'IA con Claude Code',
    ]),
    SkillGroupModel(category: 'iOS / Swift', skills: [
      'Swift / SwiftUI',
    ]),
  ];

  static const List<SkillGroupModel> _skillGroupsEn = [
    SkillGroupModel(category: 'Flutter / Dart', skills: [
      'Senior Flutter Engineer',
      'Flutter Bloc/Cubit',
      'Dart',
      'Unit Test in Flutter with Mockito',
      'Dependency Injection',
    ]),
    SkillGroupModel(category: 'Android / Kotlin', skills: [
      'Senior Android Engineer',
      'Kotlin',
      'Jetpack Compose',
      'Coroutines/Flow',
      'Kotlin Multiplatform',
    ]),
    SkillGroupModel(category: 'Architecture & Tooling', skills: [
      'Clean Architecture',
      'Realm and Room',
      'AI with Claude Code',
    ]),
    SkillGroupModel(category: 'iOS / Swift', skills: [
      'Swift / SwiftUI',
    ]),
  ];

  @override
  Future<DataState<List<ProjectModel>>> getProjects(Locale locale) async {
    try {
      final projects = _isEnglish(locale) ? _projectsEn : _projectsEs;
      return DataSuccess(projects);
    } catch (e) {
      return DataError(e);
    }
  }

  static const List<ProjectModel> _projectsEs = [
    ProjectModel(
      name: 'ProfileCV',
      description: 'App de currículum hecha en Flutter (este proyecto).',
      tech: 'Flutter · Dart',
      url: 'https://github.com/josaeljjh/ProfileCV',
    ),
    ProjectModel(
      name: 'PokeAppFlutter',
      description: 'Pokédex construida con Flutter y arquitectura limpia.',
      tech: 'Flutter · Dart',
      url: 'https://github.com/josaeljjh/PokeAppFlutter',
    ),
    ProjectModel(
      name: 'PokeApp2',
      description: 'Pokédex nativa para Android con Kotlin, MVVM y Koin.',
      tech: 'Kotlin · Android',
      url: 'https://github.com/josaeljjh/PokeApp2',
    ),
    ProjectModel(
      name: 'PokeAppIOS',
      description: 'Pokédex nativa para iOS con Swift.',
      tech: 'Swift · iOS',
      url: 'https://github.com/josaeljjh/PokeAppIOS',
    ),
    ProjectModel(
      name: 'ListDataBinding',
      description: 'Ejemplo de listas en Android usando Data Binding.',
      tech: 'Kotlin · Android',
      url: 'https://github.com/josaeljjh/ListDataBinding',
    ),
    ProjectModel(
      name: 'ListSwiftMVVM',
      description: 'Ejemplo de listas en iOS con arquitectura MVVM.',
      tech: 'Swift · iOS',
      url: 'https://github.com/josaeljjh/ListSwiftMVVM',
    ),
  ];

  static const List<ProjectModel> _projectsEn = [
    ProjectModel(
      name: 'ProfileCV',
      description: 'Resume app built with Flutter (this project).',
      tech: 'Flutter · Dart',
      url: 'https://github.com/josaeljjh/ProfileCV',
    ),
    ProjectModel(
      name: 'PokeAppFlutter',
      description: 'Pokédex built with Flutter and clean architecture.',
      tech: 'Flutter · Dart',
      url: 'https://github.com/josaeljjh/PokeAppFlutter',
    ),
    ProjectModel(
      name: 'PokeApp2',
      description: 'Native Android Pokédex with Kotlin, MVVM and Koin.',
      tech: 'Kotlin · Android',
      url: 'https://github.com/josaeljjh/PokeApp2',
    ),
    ProjectModel(
      name: 'PokeAppIOS',
      description: 'Native iOS Pokédex built with Swift.',
      tech: 'Swift · iOS',
      url: 'https://github.com/josaeljjh/PokeAppIOS',
    ),
    ProjectModel(
      name: 'ListDataBinding',
      description: 'Android list example using Data Binding.',
      tech: 'Kotlin · Android',
      url: 'https://github.com/josaeljjh/ListDataBinding',
    ),
    ProjectModel(
      name: 'ListSwiftMVVM',
      description: 'iOS list example with MVVM architecture.',
      tech: 'Swift · iOS',
      url: 'https://github.com/josaeljjh/ListSwiftMVVM',
    ),
  ];

  @override
  Future<DataState<ContactModel>> getContact() async {
    try {
      // Email/phone/URL are language-neutral — no locale needed.
      const contact = ContactModel(
        email: 'josael_jjh@hotmail.com',
        phone: '+503 7956-8406',
        linkedinDisplay: 'www.linkedin.com/in/josaél-hernández-691790184',
        linkedinUrl: 'https://www.linkedin.com/in/josa%C3%A9l-hern%C3%A1ndez-691790184',
      );
      return const DataSuccess(contact);
    } catch (e) {
      return DataError(e);
    }
  }
}
