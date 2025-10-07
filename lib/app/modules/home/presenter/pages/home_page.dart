import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:up_edema/app/utils/app_theme.dart';
import 'package:up_edema/app/widgets/app_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() =>
      _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.center,
            children: [
              Container(
                color: AppColors.primary,
                width: size.width,
                height: size.height * 0.5,
              ),
              Padding(
                padding: EdgeInsetsGeometry.only(
                  top: size.height * 0.07,
                ),
                child: Text(
                  "Up Edema",
                  style: TextStyle(
                    fontSize: size.width * 0.06,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: size.height * 0.02,
                  left: size.width * 0.025,
                  right: size.width * 0.025,
                ),
                child: Text(
                  'Suporte clínico e educacional sobre avaliação de edemas vasculares',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: size.width * 0.04,
                    fontWeight: FontWeight.normal,
                    color: const Color(
                      0xFF8A8A8A,
                    ),
                    height: 1.5,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: EdgeInsetsGeometry.only(
                  left: size.width * 0.04,
                  right: size.width * 0.04,
                ),
                child: PrimaryButton(
                  text: 'Cadastre-se',
                  onPressed: () => Modular.to
                      .pushNamed("auth/register"),
                  borderRadius: 10,
                ),
              ),
              const SizedBox(height: 12),
              SecondaryButton(
                text: 'Acessar',
                onPressed: () =>
                    Modular.to.pushNamed("auth"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
