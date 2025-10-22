import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:up_edema/app/utils/app_theme.dart';

Future<void> showHomeFilterBottomSheet(
  BuildContext context, {
  VoidCallback? onApply,
}) async {
  await showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Theme.of(context).colorScheme.surface,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (ctx) => const _HomeFilterContent(),
  );
}

class _HomeFilterContent extends StatefulWidget {
  const _HomeFilterContent();

  @override
  State<_HomeFilterContent> createState() => _HomeFilterContentState();
}

class _HomeFilterContentState extends State<_HomeFilterContent> {
  String _selectedCategory = 'Edema';
  String _orderBy = 'Recentes';
  int _stars = 5;

  final List<String> categories = const [
    'Edema',
    'Artigos',
    'Mensuração',
    'Terapia',
    'Antropométricos',
    'Questões',
  ];

  final List<String> orders = const ['Recentes', 'Conteúdo', 'Questões'];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Filtro', style: theme.textTheme.titleMedium),
                IconButton(
                  icon: const Icon(Iconsax.close_circle),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Categorias', style: theme.textTheme.labelLarge),
                TextButton(onPressed: () {}, child: const Text('Ver tudo')),
              ],
            ),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: categories.map((c) {
                final selected = _selectedCategory == c;
                return ChoiceChip(
                  label: Text(c),
                  selected: selected,
                  onSelected: (_) => setState(() => _selectedCategory = c),
                  selectedColor: AppColors.primary.withValues(alpha: 0.12),
                  labelStyle: theme.textTheme.bodyMedium?.copyWith(
                    color: selected ? AppColors.primary : AppColors.primaryText,
                    fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                  ),
                  side: BorderSide(
                    color: selected ? AppColors.primary : AppColors.outline,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  backgroundColor: theme.colorScheme.surface,
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            Text('Ordenar por', style: theme.textTheme.labelLarge),
            const SizedBox(height: 8),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: orders.map((o) {
                final selected = _orderBy == o;
                return ChoiceChip(
                  label: Text(o),
                  selected: selected,
                  onSelected: (_) => setState(() => _orderBy = o),
                  selectedColor: AppColors.primary.withValues(alpha: 0.12),
                  labelStyle: theme.textTheme.bodyMedium?.copyWith(
                    color: selected ? AppColors.primary : AppColors.primaryText,
                    fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                  ),
                  side: BorderSide(
                    color: selected ? AppColors.primary : AppColors.outline,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  backgroundColor: theme.colorScheme.surface,
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            Text(
              'Classificação por estrelas',
              style: theme.textTheme.labelLarge,
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: List.generate(5, (i) {
                final value = 5 - i; // 5,4,3,2,1
                final selected = _stars == value;
                return ChoiceChip(
                  label: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Iconsax.star,
                        size: 16,
                        color: Color(0xFFFFC107),
                      ),
                      const SizedBox(width: 6),
                      Text('$value'),
                    ],
                  ),
                  selected: selected,
                  onSelected: (_) => setState(() => _stars = value),
                  selectedColor: AppColors.primary.withValues(alpha: 0.12),
                  labelStyle: theme.textTheme.bodyMedium,
                  side: BorderSide(
                    color: selected ? AppColors.primary : AppColors.outline,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  backgroundColor: theme.colorScheme.surface,
                );
              }),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('Aplicar filtros'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
