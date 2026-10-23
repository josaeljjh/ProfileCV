import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localization/localization.dart';

import '../../../config/resources/colors.dart';
import '../../../config/resources/sizes.dart';
import '../../../config/tools/locale_resolver.dart';
import '../../../core/resources/translations_constant.dart';
import '../../../presentation/widgets/feedback/error_view.dart';
import '../../../presentation/widgets/feedback/loading_view.dart';
import '../../../presentation/widgets/text/generic_label.dart';
import '../portfolio/portfolio_page.dart';
import '../skills/skills_page.dart';
import 'cubit/home_cubit.dart';
import 'cubit/home_ui_state.dart';
import 'widgets/experience_timeline.dart';
import 'widgets/home_header_delegate.dart';
import 'widgets/home_skills_chips.dart';
import 'widgets/portfolio_carousel.dart';
import 'widgets/section_title.dart';

/// "Home" tab content: CV summary inspired by the Figma "CV design for
/// mobile" layout - a collapsing header (big profile view that shrinks
/// into a compact avatar+name+title bar on scroll), portfolio carousel,
/// skills chips and experience list. Driven by [HomeCubit] / [HomeUiState];
/// purely composition, the actual sections live under widgets/.
class HomePageContent extends StatelessWidget {
  const HomePageContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: BlocBuilder<HomeCubit, HomeUiState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const LoadingView();
          }
          if (state.hasError || state.profile == null) {
            return ErrorView(
              message: ERROR_HOME.i18n(),
              onRetry: () => context.read<HomeCubit>().loadData(resolveAppLocale()),
            );
          }

          final profile = state.profile!;
          final topPadding = MediaQuery.of(context).padding.top;
          return CustomScrollView(
            slivers: [
              SliverPersistentHeader(
                pinned: true,
                delegate: HomeHeaderDelegate(profile: profile, topPadding: topPadding),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: paddingXXL),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: paddingXXL),
                        child: GenericLabel(
                          label: profile.objective,
                          lines: null,
                          softWrap: true,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: fontSize13, color: gray400),
                        ),
                      ),
                      const SizedBox(height: paddingXXXL),
                      SectionTitle(
                        text: SECTION_PORTFOLIO.i18n(),
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => const PortfolioPage()),
                        ),
                      ),
                      const SizedBox(height: paddingMD),
                      PortfolioCarousel(portfolio: state.portfolio),
                      const SizedBox(height: paddingXXXL),
                      SectionTitle(
                        text: SECTION_SKILLS.i18n(),
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => const SkillsPage()),
                        ),
                      ),
                      const SizedBox(height: paddingMD),
                      HomeSkillsChips(skills: state.homeSkills),
                      const SizedBox(height: paddingXXXL),
                      SectionTitle(text: SECTION_EXPERIENCE.i18n()),
                      const SizedBox(height: paddingSM),
                      ExperienceTimeline(experience: state.experience),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
