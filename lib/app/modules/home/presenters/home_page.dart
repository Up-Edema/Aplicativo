import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import 'package:up_edema/app/modules/home/widgets/home_header.dart';
import 'package:up_edema/app/modules/home/widgets/home_search_field.dart';
import 'package:up_edema/app/modules/home/widgets/quick_actions_grid.dart';
import 'package:up_edema/app/modules/home/widgets/section_header.dart';
import 'package:up_edema/app/modules/home/widgets/article_recommendations.dart';
import 'package:up_edema/app/modules/home/widgets/questionnaire_card.dart';
import 'package:up_edema/app/modules/profile/presenters/profile.page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final isNarrow = size.width < 360;
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: _selectedIndex,
          children: const [
            _HomeTab(),
            _ContentsTab(),
            _ArticlesTab(),
            ProfilePage(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedFontSize: isNarrow ? 11 : 12,
        unselectedFontSize: isNarrow ? 10 : 11,
        showUnselectedLabels: true,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Theme.of(
          context,
        ).colorScheme.onSurface.withValues(alpha: 0.7),
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Iconsax.home),
            label: 'Início',
            tooltip: 'Página inicial',
          ),
          BottomNavigationBarItem(
            icon: Icon(Iconsax.book),
            label: 'conteúdos',
            tooltip: 'Conteúdo sobre edemas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Iconsax.book_1),
            label: 'Artigos',
            tooltip: 'Itens salvos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Iconsax.user),
            label: 'Perfil',
            tooltip: 'Dados do usuário',
          ),
        ],
      ),
    );
  }
}

class _HomeTab extends StatelessWidget {
  const _HomeTab();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const HomeHeader(),
          const HomeSearchField(),
          const QuickActionsGrid(),
          SectionHeader(title: 'Continue seus Questionários', onSeeAll: () {}),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 8.0,
            ),
            child: QuestionnaireCard(
              category: 'Etiologia',
              progressText: '22/32',
              title: 'Etiologia da anemia',
              subtitle: 'Revise os pontos principais',
              progressValue: 0.75,
              onContinue: () {
                debugPrint('Continuar questionário...');
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withValues(alpha: 0.35),
                  ),
                ),
                const SizedBox(width: 6),
                Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withOpacity(0.35),
                  ),
                ),
                const SizedBox(width: 6),
                Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
          SectionHeader(title: 'Recomendação de Artigo Novos', onSeeAll: () {}),
          const ArticleRecommendations(),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}

class _ContentsTab extends StatelessWidget {
  const _ContentsTab();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Iconsax.book, size: 40),
          const SizedBox(height: 12),
          Text('Conteúdos', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          Text(
            'Em breve, conteúdos e guias sobre edemas.',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}

class _ArticlesTab extends StatelessWidget {
  const _ArticlesTab();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Iconsax.book_1, size: 40),
          const SizedBox(height: 12),
          Text('Artigos', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          Text(
            'Em breve, recomendações e listas de artigos.',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
