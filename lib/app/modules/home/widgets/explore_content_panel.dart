import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:up_edema/app/modules/home/widgets/home_search_field.dart';
import 'package:up_edema/app/modules/home/widgets/section_header.dart';
import 'package:up_edema/app/modules/home/widgets/article_recommendations.dart';

class ExploreContentPanel extends StatelessWidget {
  const ExploreContentPanel({
    super.key,
    required this.onClose,
    required this.searchFocus,
  });

  final VoidCallback onClose;
  final FocusNode searchFocus;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 12),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Iconsax.arrow_left_2),
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      onClose();
                    },
                  ),
                  const SizedBox(width: 8),
                  Text('Explorar Conteúdo', style: theme.textTheme.titleMedium),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: HomeSearchField(focusNode: searchFocus, autofocus: false),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Text('Pesquisa Popular', style: theme.textTheme.labelLarge),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Wrap(
                spacing: 12,
                runSpacing: 12,
                children: const [
                  _Chip('Lorem'), _Chip('Lorem'), _Chip('Lorem'), _Chip('Lorem'),
                  _Chip('Lorem'), _Chip('Lorem'), _Chip('Lorem Ipsum'),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child:
                  Text('Pesquisar por categorias', style: theme.textTheme.labelLarge),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: 4,
                childAspectRatio: 0.9,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                children: [
                  const _CategoryItem('Sobre o Edema'),
                  const _CategoryItem('Artigos Científicos'),
                  const _CategoryItem('Mensuração'),
                  const _CategoryItem('Antropométricos'),
                  GestureDetector(
                    onTap: () => context.push('/quizzes/'),
                    child: const _CategoryItem('Questionários'),
                  ),
                  const _CategoryItem('Terapia Física'),
                  const _CategoryItem('Ajuda e Diagnóstico'),
                  const _CategoryItem('Sobre o App'),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SectionHeader(
                title: 'Recomendação de Artigo Novos',
                onSeeAll: () => context.push('/articles/'),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: ArticleRecommendations(),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip(this.label);
  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: theme.dividerColor),
      ),
      child: Text(label, style: theme.textTheme.bodySmall),
    );
  }
}

class _CategoryItem extends StatelessWidget {
  const _CategoryItem(this.label);
  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: theme.dividerColor),
          ),
          child: const Icon(Iconsax.document, color: Colors.teal, size: 28),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          textAlign: TextAlign.center,
          style: theme.textTheme.bodySmall,
          maxLines: 2,
        ),
      ],
    );
  }
}