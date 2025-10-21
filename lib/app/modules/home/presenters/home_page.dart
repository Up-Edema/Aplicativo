import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import 'package:up_edema/app/modules/home/widgets/home_header.dart';
import 'package:up_edema/app/modules/home/widgets/home_search_field.dart';
import 'package:up_edema/app/modules/home/widgets/quick_actions_grid.dart';
import 'package:up_edema/app/modules/home/widgets/section_header.dart';
import 'package:up_edema/app/modules/home/widgets/article_recommendations.dart';
import 'package:up_edema/app/modules/home/widgets/questionnaire_card.dart';

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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HomeHeader(),
              const HomeSearchField(),
              const QuickActionsGrid(),
              SectionHeader(
                title: 'Continue seus Questionários',
                onSeeAll: () {},
              ),
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
                        ).colorScheme.onSurface.withOpacity(0.35),
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
              SectionHeader(
                title: 'Recomendação de Artigo Novos',
                onSeeAll: () {},
              ),
              const ArticleRecommendations(),
              const SizedBox(height: 32),
            ],
          ),
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
        ).colorScheme.onSurface.withOpacity(0.7),
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Iconsax.home),
            label: 'Início',
            tooltip: 'Página inicial',
          ),
          BottomNavigationBarItem(
            icon: Icon(Iconsax.play_circle),
            label: 'Vídeos',
            tooltip: 'Conteúdo em vídeo',
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
