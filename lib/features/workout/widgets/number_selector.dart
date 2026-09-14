import 'package:flutter/material.dart';

class NumberSelector extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final int value;
  final VoidCallback onIncrease;
  final VoidCallback? onDecrease;

  const NumberSelector({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.value,
    required this.onIncrease,
    required this.onDecrease,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final accent = icon == Icons.layers_rounded ? colors.secondary : colors.primary;
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: accent.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: accent, size: 21),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 12, color: colors.onSurfaceVariant),
                  ),
                ],
              ),
            ),
            _StepButton(
              tooltip: 'Decrease $title',
              icon: Icons.remove_rounded,
              onPressed: onDecrease,
            ),
            SizedBox(
              width: 42,
              child: Semantics(
                label: '$title: $value',
                child: Text(
                  '$value',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                ),
              ),
            ),
            _StepButton(
              tooltip: 'Increase $title',
              icon: Icons.add_rounded,
              onPressed: onIncrease,
              emphasized: true,
            ),
          ],
        ),
      ),
    );
  }
}

class _StepButton extends StatelessWidget {
  final String tooltip;
  final IconData icon;
  final VoidCallback? onPressed;
  final bool emphasized;

  const _StepButton({
    required this.tooltip,
    required this.icon,
    required this.onPressed,
    this.emphasized = false,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return IconButton(
      tooltip: tooltip,
      onPressed: onPressed,
      icon: Icon(icon, size: 20),
      style: IconButton.styleFrom(
        foregroundColor: emphasized ? colors.primary : colors.onSurfaceVariant,
        backgroundColor: emphasized
            ? colors.primary.withValues(alpha: 0.12)
            : colors.surfaceContainerHighest,
        disabledForegroundColor: colors.onSurfaceVariant.withValues(alpha: 0.35),
        minimumSize: const Size(38, 38),
        maximumSize: const Size(38, 38),
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
