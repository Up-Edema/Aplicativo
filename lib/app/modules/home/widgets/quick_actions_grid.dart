import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class QuickAction {
  final IconData icon;
  final String label;
  const QuickAction(this.icon, this.label);
}

class QuickActionsGrid extends StatelessWidget {
  const QuickActionsGrid({super.key});

  static const List<QuickAction> _actions = [
    QuickAction(Iconsax.document_text, 'Sobre o Edema'),
    QuickAction(Iconsax.book_1, 'Artigos Científicos'),
    QuickAction(Iconsax.ruler, 'Mensuração'),
    QuickAction(Iconsax.calculator, 'Antropométricos'),
    QuickAction(Iconsax.task_square, 'Questionários'),
    QuickAction(Iconsax.hospital, 'Terapia Física'),
    QuickAction(Icons.help_outline, 'Ajuda e Diagnóstico'),
    QuickAction(Icons.phone_iphone, 'Sobre o App'),
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final crossAxisCount = width < 360 ? 3 : 4;
    final childAspectRatio = width < 360 ? 0.5 : 0.55;

    final iconColor = Theme.of(context).colorScheme.primary;
    final tileBgColor = Color.alphaBlend(
      iconColor.withValues(alpha: 0.12),
      Theme.of(context).colorScheme.surface,
    );
    final labelStyle = Theme.of(
      context,
    ).textTheme.bodySmall?.copyWith(fontSize: 11);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 16.0),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: 30,
          mainAxisSpacing: 10,
          childAspectRatio: childAspectRatio,
        ),
        itemCount: _actions.length,
        itemBuilder: (context, index) {
          final action = _actions[index];
          return InkWell(
            onTap: () {
              if (action.label == 'Questionários') {
                context.push('/quizzes/');
              }
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: tileBgColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  alignment: Alignment.center,
                  child: Icon(
                    action.icon,
                    size: 22,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  action.label,
                  textAlign: TextAlign.center,
                  style: labelStyle,
                  maxLines: 2,
                  softWrap: true,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
