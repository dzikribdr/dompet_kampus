import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../core/services/deeplink_service.dart';
import '../../../core/theme/app_colors.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../widgets/app_button.dart';
import '../../widgets/app_logo.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(AuthCheckRequested());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthAuthenticated) {
          // Cek apakah ada deeplink payment yang menunggu (cold-start via deeplink).
          // Jika ada, langsung ke halaman konfirmasi. Jika tidak, ke home.
          final pending = DeeplinkService.consumePending();
          if (pending != null) {
            context.go('/pay', extra: pending);
          } else {
            context.go('/home');
          }
        } else if (state is AuthUnauthenticated) {
          // Stay on splash to show welcome
        }
      },
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(gradient: AppColors.primaryGradient),
          child: Stack(
            children: [
              // Thin outline ring, offset top-left for depth
              Positioned(
                top: -70,
                left: -70,
                child: Container(
                  width: 260,
                  height: 260,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.09),
                      width: 20,
                    ),
                  ),
                ),
              ),
              // Soft filled blob, lower-left
              Positioned(
                bottom: -60,
                left: -80,
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withValues(alpha: 0.05),
                  ),
                ),
              ),
              // Dot-grid texture, top-right
              Positioned(
                top: 86,
                right: 24,
                child: _buildDotGrid(),
              ),
              SafeArea(
                child: Column(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(28, 14, 28, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Brand lockup
                            Row(
                              children: [
                                Container(
                                  width: 36,
                                  height: 36,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(11),
                                    color: Colors.white.withValues(alpha: 0.16),
                                  ),
                                  child: const AppLogo(size: 20, light: true),
                                ),
                                const SizedBox(width: 10),
                                const Text(
                                  'CashLess',
                                  style: TextStyle(
                                    fontFamily: 'PlusJakartaSans',
                                    fontSize: 17,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white,
                                    letterSpacing: -0.3,
                                  ),
                                ),
                                const Spacer(),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 11, vertical: 6),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color:
                                          Colors.white.withValues(alpha: 0.35),
                                      width: 1,
                                    ),
                                  ),
                                  child: Text(
                                    'E-WALLET',
                                    style: TextStyle(
                                      fontFamily: 'PlusJakartaSans',
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                      color:
                                          Colors.white.withValues(alpha: 0.9),
                                      letterSpacing: 1.4,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(flex: 3),
                            // Rotated squircle logo mark, off-center
                            Align(
                              alignment: Alignment.center,
                              child: Transform.rotate(
                                angle: 12 * math.pi / 180,
                                child: Container(
                                  width: 132,
                                  height: 132,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(38),
                                    color: Colors.white.withValues(alpha: 0.14),
                                    border: Border.all(
                                      color:
                                          Colors.white.withValues(alpha: 0.28),
                                      width: 1.2,
                                    ),
                                  ),
                                  child: Transform.rotate(
                                    angle: -12 * math.pi / 180,
                                    child: const AppLogo(size: 68, light: true),
                                  ),
                                ),
                              ),
                            ),
                            const Spacer(flex: 3),
                            // Left-aligned headline
                            const Text(
                              'Satu Aplikasi,\nSemua Transaksi Kamu.',
                              style: TextStyle(
                                fontFamily: 'PlusJakartaSans',
                                fontSize: 28,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                                height: 1.18,
                                letterSpacing: -0.5,
                              ),
                            ),
                            const SizedBox(height: 14),
                            Text(
                              'Bayar, transfer, dan kelola uang Anda dalam satu aplikasi yang aman dan cepat.',
                              style: TextStyle(
                                fontFamily: 'PlusJakartaSans',
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.white.withValues(alpha: 0.82),
                                height: 1.6,
                              ),
                            ),
                            const Spacer(flex: 2),
                          ],
                        ),
                      ),
                    ),
                    _buildBottomPanel(context),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDotGrid() {
    return Column(
      children: List.generate(4, (row) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 14),
          child: Row(
            children: List.generate(4, (col) {
              final opacity = 0.06 + ((row + col) % 3) * 0.05;
              return Padding(
                padding: const EdgeInsets.only(right: 14),
                child: Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withValues(alpha: opacity),
                  ),
                ),
              );
            }),
          ),
        );
      }),
    );
  }

  Widget _buildBottomPanel(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(28, 26, 28, 30),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.12),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
        border: Border(
          top: BorderSide(color: Colors.white.withValues(alpha: 0.22)),
        ),
      ),
      child: Column(
        children: [
          AppButton(
            label: 'Buat Akun Baru',
            variant: AppButtonVariant.white,
            onPressed: () => context.push('/register'),
          ),
          const SizedBox(height: 12),
          AppButton(
            label: 'Masuk ke Akun',
            variant: AppButtonVariant.outlineWhite,
            onPressed: () => context.push('/login'),
          ),
          const SizedBox(height: 16),
          Text(
            'Dengan melanjutkan, kamu menyetujui Syarat & Ketentuan CashLess.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'PlusJakartaSans',
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: Colors.white.withValues(alpha: 0.65),
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
