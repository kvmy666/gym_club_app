import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../l10n/app_localizations.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late final TextEditingController _emailController;
  late final TextEditingController _weightController;
  late final TextEditingController _heightController;

  final List<_MembershipPlan> _plans = const [
    _MembershipPlan(
      id: 'monthly',
      labelKey: 'membershipPlanMonthly',
      price: 'SAR 299',
      duration: '30 days',
      perks: ['Unlimited gym access', '1 PT session', 'Sauna access'],
    ),
    _MembershipPlan(
      id: 'quarterly',
      labelKey: 'membershipPlanQuarterly',
      price: 'SAR 799',
      duration: '90 days',
      perks: ['Unlimited access', '3 PT sessions', 'Sauna + pool'],
    ),
    _MembershipPlan(
      id: 'semiAnnual',
      labelKey: 'membershipPlanSemiAnnual',
      price: 'SAR 1,299',
      duration: '180 days',
      perks: ['Unlimited access', 'Monthly body scan', 'Nutrition guide'],
    ),
    _MembershipPlan(
      id: 'annual',
      labelKey: 'membershipPlanAnnual',
      price: 'SAR 2,299',
      duration: '365 days',
      perks: ['Unlimited access', 'Weekly PT check-in', 'Unlimited sauna/pool'],
    ),
  ];

  String _selectedPlan = 'monthly';

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: 'abdulkarim@email.com');
    _weightController = TextEditingController(text: '78');
    _heightController = TextEditingController(text: '178');
  }

  @override
  void dispose() {
    _emailController.dispose();
    _weightController.dispose();
    _heightController.dispose();
    super.dispose();
  }

  void _saveProfile(AppLocalizations l10n) {
    FocusScope.of(context).unfocus();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(l10n.profileSavedMessage)),
    );
  }

  void _renewMembership(AppLocalizations l10n) {
    final label = _plans
        .firstWhere((plan) => plan.id == _selectedPlan)
        .localizedLabel(l10n);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(l10n.membershipRenewSuccess(label))),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    const userName = 'Abdulkarim Al-Shudukhi';
    const membershipTier = 'Elite Plus';
    const daysRemaining = 18;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.profileTitle),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => context.pop(),
        ),
        actions: [
          IconButton(
            onPressed: () => context.go('/auth/sign-in'),
            icon: const Icon(Icons.login),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Hero(
            tag: 'profile-avatar',
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                gradient: LinearGradient(
                  colors: [
                    theme.colorScheme.primary.withValues(alpha: 0.9),
                    theme.colorScheme.secondary.withValues(alpha: 0.8),
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(
                      alpha: theme.brightness == Brightness.dark ? 0.45 : 0.15,
                    ),
                    blurRadius: 24,
                    offset: const Offset(0, 16),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    height: 72,
                    width: 72,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white24,
                    ),
                    child: const Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 42,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userName,
                          style: theme.textTheme.titleLarge?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _emailController.text,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: Colors.white70,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Text(
                            l10n.membershipStatusLabel(membershipTier),
                            style: theme.textTheme.labelMedium?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          _InfoCard(
            title: l10n.personalInfoSection,
            rows: [
              _EditableField(
                controller: _emailController,
                label: l10n.emailLabel,
                icon: Icons.mail_outline,
                keyboardType: TextInputType.emailAddress,
              ),
              _EditableField(
                controller: _weightController,
                label: l10n.weightLabel,
                icon: Icons.monitor_weight,
                suffix: 'kg',
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
              ),
              _EditableField(
                controller: _heightController,
                label: l10n.heightLabel,
                icon: Icons.height,
                suffix: 'cm',
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () => _saveProfile(l10n),
                  child: Text(l10n.profileSaveButton),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _MembershipCard(
            title: l10n.membershipSection,
            tier: membershipTier,
            remainingLabel: l10n.membershipRemaining(daysRemaining),
            plansTitle: l10n.membershipComparisonTitle,
            plans: _plans
                .map(
                  (plan) => _PlanOptionCard(
                    plan: plan,
                    isSelected: plan.id == _selectedPlan,
                    onSelected: () {
                      setState(() => _selectedPlan = plan.id);
                    },
                  ),
                )
                .toList(),
            onRenew: () => _renewMembership(l10n),
            selectedPlanLabel: _plans
                .firstWhere((plan) => plan.id == _selectedPlan)
                .localizedLabel(l10n),
            renewLabel: l10n.membershipRenewButton,
          ),
          const SizedBox(height: 24),
          _SupportCard(
            title: l10n.supportSection,
            subtitle: l10n.supportEmailLabel,
            email: l10n.supportEmail,
          ),
        ],
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.title, required this.rows});

  final String title;
  final List<Widget> rows;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 16),
            ...rows,
          ],
        ),
      ),
    );
  }
}

class _EditableField extends StatelessWidget {
  const _EditableField({
    required this.controller,
    required this.label,
    required this.icon,
    this.suffix,
    this.keyboardType,
  });

  final TextEditingController controller;
  final String label;
  final IconData icon;
  final String? suffix;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
   // final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          suffixText: suffix,
        ),
      ),
    );
  }
}

class _MembershipCard extends StatelessWidget {
  const _MembershipCard({
    required this.title,
    required this.tier,
    required this.remainingLabel,
    required this.plansTitle,
    required this.plans,
    required this.selectedPlanLabel,
    required this.renewLabel,
    required this.onRenew,
  });

  final String title;
  final String tier;
  final String remainingLabel;
  final String plansTitle;
  final List<Widget> plans;
  final String selectedPlanLabel;
  final String renewLabel;
  final VoidCallback onRenew;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tier,
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        remainingLabel,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              plansTitle,
              style: theme.textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 12),
            ...plans,
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.check_circle_outline),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    selectedPlanLabel,
                    style: theme.textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: onRenew,
                child: Text(renewLabel),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PlanOptionCard extends StatelessWidget {
  const _PlanOptionCard({
    required this.plan,
    required this.isSelected,
    required this.onSelected,
  });

  final _MembershipPlan plan;
  final bool isSelected;
  final VoidCallback onSelected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(
          color: isSelected
              ? theme.colorScheme.primary
              : theme.colorScheme.outlineVariant,
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onSelected,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      plan.localizedLabel(l10n),
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Icon(
                    isSelected
                        ? Icons.radio_button_checked
                        : Icons.radio_button_off,
                    color: theme.colorScheme.primary,
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                plan.duration,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                plan.price,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              ...plan.perks.map(
                (perk) => Row(
                  children: [
                    const Icon(Icons.check, size: 16),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        perk,
                        style: theme.textTheme.bodySmall,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SupportCard extends StatelessWidget {
  const _SupportCard({
    required this.title,
    required this.subtitle,
    required this.email,
  });

  final String title;
  final String subtitle;
  final String email;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.email_outlined),
                const SizedBox(width: 8),
                Text(
                  email,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _MembershipPlan {
  const _MembershipPlan({
    required this.id,
    required this.labelKey,
    required this.price,
    required this.duration,
    required this.perks,
  });

  final String id;
  final String labelKey;
  final String price;
  final String duration;
  final List<String> perks;

  String localizedLabel(AppLocalizations l10n) {
    switch (labelKey) {
      case 'membershipPlanMonthly':
        return l10n.membershipPlanMonthly;
      case 'membershipPlanQuarterly':
        return l10n.membershipPlanQuarterly;
      case 'membershipPlanSemiAnnual':
        return l10n.membershipPlanSemiAnnual;
      case 'membershipPlanAnnual':
        return l10n.membershipPlanAnnual;
      default:
        return labelKey;
    }
  }
}
