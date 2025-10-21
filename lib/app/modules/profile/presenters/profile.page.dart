import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:up_edema/app/modules/profile/presenters/widgets/profile_header.dart';
import 'package:up_edema/app/modules/profile/presenters/widgets/profile_menu_item.dart';
import 'package:up_edema/app/modules/profile/presenters/widgets/profile_section.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: ProfileHeader(
                name: 'Dr.',
                email: 'user@example.com',
                onMenuPressed: () {},
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 20)),
            SliverToBoxAdapter(
              child: ProfileSection(
                title: 'Geral',
                children: const [
                  ProfileMenuItem(icon: Iconsax.user, label: 'Dados Pessoais'),
                  ProfileMenuItem(
                    icon: Iconsax.activity,
                    label: 'Questionários',
                  ),
                ],
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 16)),
            SliverToBoxAdapter(
              child: ProfileSection(
                title: 'Others',
                children: const [
                  ProfileMenuItem(
                    icon: Iconsax.setting_2,
                    label: 'Configuração',
                  ),
                ],
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 24)),
          ],
        ),
      ),
    );
  }
}
