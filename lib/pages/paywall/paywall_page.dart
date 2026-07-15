import 'package:asocijacije_nove/constants/app_colors.dart';
import 'package:asocijacije_nove/constants/app_styles.dart';
import 'package:asocijacije_nove/l10n/app_localizations.dart';
import 'package:asocijacije_nove/providers/all_providers.dart';
import 'package:asocijacije_nove/services/purchase_service.dart';
import 'package:asocijacije_nove/widgets/app_page_header.dart';
import 'package:asocijacije_nove/widgets/app_separator.dart';
import 'package:asocijacije_nove/widgets/buttons/base-buttons/app_button_empty.dart';
import 'package:asocijacije_nove/widgets/buttons/base-buttons/app_button_full.dart';
import 'package:asocijacije_nove/widgets/neon_background.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// One-time "pro" unlock screen. Pops with `true` when the user ends up
/// entitled (purchase, restore, or debug unlock), otherwise with nothing.
class PaywallPage extends ConsumerStatefulWidget {
  const PaywallPage({super.key});

  @override
  ConsumerState<PaywallPage> createState() => _PaywallPageState();
}

class _PaywallPageState extends ConsumerState<PaywallPage> {
  String? _price;
  bool _busy = false;

  @override
  void initState() {
    super.initState();
    PurchaseService.getProPrice().then((price) {
      if (mounted) setState(() => _price = price);
    });
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      body: NeonBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 8, left: 24, right: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppPageHeader(title: localizations.proNaslov),
                const AppSeparator(color: AppColors.orange),
                const SizedBox(height: 30),
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppColors.orange.withValues(alpha: 0.15),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.orange.withValues(alpha: 0.35),
                          blurRadius: 32,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.workspace_premium,
                      color: AppColors.orange,
                      size: 56,
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                Center(
                  child: Text(
                    localizations.proPodnaslov,
                    textAlign: TextAlign.center,
                    style: NeonText.body(size: 14, color: AppColors.sub),
                  ),
                ),
                const SizedBox(height: 28),
                _ProFeature(
                  icon: Icons.edit_note,
                  text: localizations.proPogodnostSvojeReci,
                ),
                const SizedBox(height: 12),
                _ProFeature(
                  icon: Icons.qr_code,
                  text: localizations.proPogodnostQr,
                ),
                const SizedBox(height: 12),
                _ProFeature(
                  icon: Icons.auto_awesome,
                  text: localizations.proPogodnostBuduce,
                ),
                const Spacer(),
                if (_busy)
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: CircularProgressIndicator(color: AppColors.orange),
                    ),
                  )
                else ...[
                  AppButtonFull(
                    fillColor: AppColors.orange,
                    textColor: AppColors.inkOnFill,
                    buttonText: _price != null
                        ? localizations.otkljucajZa(_price!)
                        : localizations.otkljucaj,
                    onPressed: _purchase,
                  ),
                  const SizedBox(height: 14),
                  Center(
                    child: TextButton(
                      onPressed: _restore,
                      child: Text(
                        localizations.vratiKupovinu,
                        style: NeonText.body(
                          size: 14,
                          color: AppColors.sub,
                        ).copyWith(
                          decoration: TextDecoration.underline,
                          decorationColor: AppColors.sub,
                        ),
                      ),
                    ),
                  ),
                ],
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.only(bottom: 35.0),
                  child: AppButtonEmpty(
                    buttonText: localizations.nazad,
                    borderColor: AppColors.ink,
                    textColor: AppColors.ink,
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _purchase() async {
    if (kDebugMode && !PurchaseService.isConfigured) {
      // Debug-only bypass so the gated flow is testable before the store
      // setup is live. Never reachable in release builds.
      ref.read(proProvider.notifier).state = true;
      Navigator.pop(context, true);
      return;
    }
    if (!PurchaseService.isConfigured) {
      _showMessage(AppLocalizations.of(context)!.prodavnicaNijeDostupna);
      return;
    }

    setState(() => _busy = true);
    final success = await PurchaseService.purchasePro();
    if (!mounted) return;
    setState(() => _busy = false);

    if (success) {
      ref.read(proProvider.notifier).state = true;
      Navigator.pop(context, true);
    }
  }

  Future<void> _restore() async {
    if (!PurchaseService.isConfigured) {
      _showMessage(AppLocalizations.of(context)!.prodavnicaNijeDostupna);
      return;
    }

    setState(() => _busy = true);
    final restored = await PurchaseService.restorePurchases();
    if (!mounted) return;
    setState(() => _busy = false);

    final localizations = AppLocalizations.of(context)!;
    if (restored) {
      ref.read(proProvider.notifier).state = true;
      _showMessage(localizations.kupovinaVracena);
      Navigator.pop(context, true);
    } else {
      _showMessage(localizations.kupovinaNijeNadjena);
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: NeonText.body(size: 14, color: AppColors.ink),
        ),
        backgroundColor: AppColors.card,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}

class _ProFeature extends StatelessWidget {
  final IconData icon;
  final String text;

  const _ProFeature({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.violet.withValues(alpha: 0.33),
          width: 1.5,
        ),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.cyan, size: 26),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              text,
              style: NeonText.body(size: 14, color: AppColors.ink),
            ),
          ),
        ],
      ),
    );
  }
}
