import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
// Removed flutter_modular import; using get_it for dependencies.
import 'package:flutter_triple/flutter_triple.dart';
import 'package:up_edema/app/modules/profile/presenters/stores/personal_data_store.dart';
import 'package:up_edema/app/utils/app_theme.dart';
import 'package:up_edema/app/widgets/app_button.dart';
import 'package:up_edema/app/modules/core/config/service_locator.dart';

class PersonalDataPage extends StatefulWidget {
  const PersonalDataPage({super.key});

  @override
  State<PersonalDataPage> createState() => _PersonalDataPageState();
}

class _PersonalDataPageState extends State<PersonalDataPage> {
  final PersonalDataStore store = getIt<PersonalDataStore>();

  final TextEditingController _crmController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  DateTime? _dob;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      store.observer(
        onState: (s) {
          _emailController.text = s.email;
          _phoneController.text = s.phone;
          _crmController.text = s.crm;
          _dob = s.dob;
          _dobController.text = s.dobDisplay;
        },
      );
      store.load();
    });
  }

  @override
  void dispose() {
    _crmController.dispose();
    _dobController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _reload() async {
    await store.load();
  }

  String _formatDatePt(DateTime date) {
    const months = [
      'jan',
      'fev',
      'mar',
      'abr',
      'mai',
      'jun',
      'jul',
      'ago',
      'set',
      'out',
      'nov',
      'dez',
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }

  Future<void> _pickDob() async {
    final now = DateTime.now();
    final initialDate = _dob ?? DateTime(now.year - 20, now.month, now.day);
    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1900, 1, 1),
      lastDate: now,
    );

    if (picked != null) {
      setState(() {
        _dob = picked;
        _dobController.text = _formatDatePt(picked);
      });
      store.update(
        store.state.copyWith(dob: picked, dobDisplay: _formatDatePt(picked)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Dados Pessoais')),
      body: ScopedBuilder<PersonalDataStore, PersonalDataState>(
        store: store,
        onLoading: (_) => const Center(child: CircularProgressIndicator()),
        onError: (_, error) => Center(
          child: Text(
            'Falha ao carregar dados. Tente novamente.',
            style: theme.textTheme.bodyMedium,
          ),
        ),
        onState: (_, state) => ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                width: 96,
                height: 96,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: theme.colorScheme.surface,
                  border: Border.all(color: Colors.white70, width: 3),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Center(
                  child: Icon(Iconsax.image, color: AppColors.primary),
                ),
              ),
            ),
            const SizedBox(height: 16),

            _SectionHeader('Informações de Conta'),
            TextFormField(
              controller: _emailController,
              readOnly: true,
              decoration: const InputDecoration(
                labelText: 'E-mail',
                hintText: 'Seu e-mail',
                prefixIcon: Icon(Iconsax.sms),
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _phoneController,
              readOnly: true,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: 'Telefone',
                hintText: 'Seu telefone',
                prefixIcon: Icon(Iconsax.call),
              ),
            ),

            const SizedBox(height: 12),
            _SectionHeader('Dados Profissionais'),
            TextFormField(
              controller: _crmController,
              decoration: const InputDecoration(
                labelText: 'CRM',
                hintText: 'Informe seu CRM',
              ),
              textInputAction: TextInputAction.next,
            ),

            const SizedBox(height: 12),
            _SectionHeader('Dados Pessoais'),
            TextFormField(
              controller: _dobController,
              readOnly: true,
              decoration: const InputDecoration(
                labelText: 'Data de nascimento',
                hintText: 'Selecione a data',
                suffixIcon: Icon(Iconsax.calendar),
              ),
              onTap: _pickDob,
            ),

            const SizedBox(height: 24),
            PrimaryButton(
              text: 'Atualizar dados',
              onPressed: _reload,
              borderRadius: 12,
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader(this.title);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(title, style: Theme.of(context).textTheme.labelLarge),
    );
  }
}

class _InfoTile extends StatelessWidget {
  const _InfoTile({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.dividerColor),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Color.alphaBlend(
                theme.colorScheme.primary.withOpacity(0.08),
                theme.colorScheme.surface,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: theme.colorScheme.primary),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: theme.textTheme.bodySmall),
                const SizedBox(height: 4),
                Text(value, style: theme.textTheme.bodyMedium),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusTile extends StatelessWidget {
  const _StatusTile({required this.status});
  final String status;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isActive = status.toLowerCase() == 'active';
    final color = isActive ? Colors.green : Colors.red;
    final text = isActive ? 'Ativo' : 'Inativo';

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.dividerColor),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Color.alphaBlend(
                color.withOpacity(0.12),
                theme.colorScheme.surface,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(Iconsax.shield_tick, color: color),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Status da Conta', style: theme.textTheme.bodySmall),
                const SizedBox(height: 4),
                Text(
                  text,
                  style: theme.textTheme.bodyMedium?.copyWith(color: color),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
