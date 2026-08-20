import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_data_hub/app/theme/app_colors.dart';
import 'package:health_data_hub/app/theme/app_text_styles.dart';
import 'package:health_data_hub/controllers/genotype_controller.dart';
import 'package:health_data_hub/core/constants/app_constants.dart';
import 'package:health_data_hub/data/models/genotype_section.dart';
import 'package:health_data_hub/widgets/genotype/section_selector.dart';

/// Anchors [SectionDropdownMenu] to the section title via the root overlay
/// so the menu is not clipped by the page [Stack] / [ScrollView].
class SectionSelectorAnchor extends StatefulWidget {
  const SectionSelectorAnchor({super.key, required this.controller});

  final GenotypeController controller;

  @override
  State<SectionSelectorAnchor> createState() => _SectionSelectorAnchorState();
}

class _SectionSelectorAnchorState extends State<SectionSelectorAnchor> {
  final OverlayPortalController _portal = OverlayPortalController();
  final LayerLink _link = LayerLink();

  GenotypeController get _controller => widget.controller;

  void _toggle() {
    if (_portal.isShowing) {
      _portal.hide();
      _controller.closeSectionMenu();
    } else {
      _portal.show();
      _controller.openSectionMenu();
    }
    setState(() {});
  }

  void _hide() {
    if (_portal.isShowing) {
      _portal.hide();
    }
    _controller.closeSectionMenu();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final menuWidth =
        MediaQuery.sizeOf(context).width - (AppConstants.pagePadding * 2);

    return OverlayPortal(
      controller: _portal,
      overlayChildBuilder: (context) {
        return Stack(
          children: [
            Positioned.fill(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: _hide,
                child: const ColoredBox(color: Color(0x33000000)),
              ),
            ),
            CompositedTransformFollower(
              link: _link,
              showWhenUnlinked: false,
              targetAnchor: Alignment.bottomCenter,
              followerAnchor: Alignment.topCenter,
              offset: const Offset(0, 12),
              child: SizedBox(
                width: menuWidth,
                child: Material(
                  type: MaterialType.transparency,
                  child: Obx(
                    () => SectionDropdownMenu(
                      sections: _controller.sections,
                      selectedId: _controller.selectedSectionId.value,
                      onSelect: (id) {
                        _controller.selectSection(id);
                        _hide();
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
      child: CompositedTransformTarget(
        link: _link,
        child: Obx(
          () => SectionSelector(
            title: _controller.sectionTitle,
            expanded: _portal.isShowing,
            onTap: _toggle,
          ),
        ),
      ),
    );
  }
}

class SectionDropdownMenu extends StatelessWidget {
  const SectionDropdownMenu({
    super.key,
    required this.sections,
    required this.selectedId,
    required this.onSelect,
  });

  final List<GenotypeSection> sections;
  final String selectedId;
  final ValueChanged<String> onSelect;

  static const Color _panelGlow = Color(0xFF5B3A9A);
  static const Color _cyanRim = Color(0xFF2EE6D6);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: _panelGlow.withValues(alpha: 0.38),
            blurRadius: 28,
            spreadRadius: 2,
          ),
          BoxShadow(
            color: const Color(0xFF12708B).withValues(alpha: 0.22),
            blurRadius: 18,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (var i = 0; i < sections.length; i++) ...[
            if (i > 0) const SizedBox(height: 10),
            _SectionOptionCard(
              section: sections[i],
              selected: sections[i].id == selectedId,
              onTap: () => onSelect(sections[i].id),
              selectedRim: _cyanRim,
            ),
          ],
        ],
      ),
    );
  }
}

class _SectionOptionCard extends StatelessWidget {
  const _SectionOptionCard({
    required this.section,
    required this.selected,
    required this.onTap,
    required this.selectedRim,
  });

  final GenotypeSection section;
  final bool selected;
  final VoidCallback onTap;
  final Color selectedRim;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(12, 14, 14, 14),
        decoration: BoxDecoration(
          color: const Color(0xE6121218),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: selected
                ? selectedRim
                : AppColors.textPrimary.withValues(alpha: 0.12),
            width: selected ? 1.4 : 1,
          ),
          boxShadow: selected
              ? [
                  BoxShadow(
                    color: selectedRim.withValues(alpha: 0.45),
                    blurRadius: 16,
                  ),
                  BoxShadow(
                    color: selectedRim.withValues(alpha: 0.18),
                    blurRadius: 28,
                    spreadRadius: 1,
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.35),
                    blurRadius: 10,
                  ),
                ],
        ),
        child: Row(
          children: [
            _IconTile(icon: section.icon),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(section.title, style: AppTextStyles.bodyLarge),
                  const SizedBox(height: 4),
                  Text(section.subtitle, style: AppTextStyles.caption),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _IconTile extends StatelessWidget {
  const _IconTile({required this.icon});

  final GenotypeSectionIcon icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 46,
      height: 46,
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A22),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: AppColors.textPrimary.withValues(alpha: 0.12),
        ),
      ),
      child: CustomPaint(
        painter: icon == GenotypeSectionIcon.molecule
            ? const _MoleculeIconPainter()
            : const _HeartPulseIconPainter(),
      ),
    );
  }
}

class _MoleculeIconPainter extends CustomPainter {
  const _MoleculeIconPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 1.4
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final fill = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final center = Offset(size.width * 0.48, size.height * 0.52);
    final nodes = <Offset>[
      center,
      center + const Offset(-10, -8),
      center + const Offset(11, -7),
      center + const Offset(-8, 10),
      center + const Offset(9, 9),
    ];

    canvas.drawLine(nodes[0], nodes[1], paint);
    canvas.drawLine(nodes[0], nodes[2], paint);
    canvas.drawLine(nodes[0], nodes[3], paint);
    canvas.drawLine(nodes[0], nodes[4], paint);
    canvas.drawLine(nodes[1], nodes[2], paint);

    for (final node in nodes) {
      canvas.drawCircle(node, node == center ? 2.6 : 2.1, fill);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _HeartPulseIconPainter extends CustomPainter {
  const _HeartPulseIconPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final heart = Path();
    final c = Offset(size.width / 2, size.height * 0.52);
    final w = size.width * 0.32;
    final h = size.height * 0.28;

    heart.moveTo(c.dx, c.dy + h * 0.55);
    heart.cubicTo(
      c.dx - w * 0.15,
      c.dy + h * 0.1,
      c.dx - w,
      c.dy - h * 0.15,
      c.dx - w * 0.45,
      c.dy - h * 0.55,
    );
    heart.cubicTo(
      c.dx - w * 0.08,
      c.dy - h * 0.95,
      c.dx,
      c.dy - h * 0.35,
      c.dx,
      c.dy - h * 0.12,
    );
    heart.cubicTo(
      c.dx,
      c.dy - h * 0.35,
      c.dx + w * 0.08,
      c.dy - h * 0.95,
      c.dx + w * 0.45,
      c.dy - h * 0.55,
    );
    heart.cubicTo(
      c.dx + w,
      c.dy - h * 0.15,
      c.dx + w * 0.15,
      c.dy + h * 0.1,
      c.dx,
      c.dy + h * 0.55,
    );
    heart.close();

    final heartPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..strokeJoin = StrokeJoin.round;

    canvas.drawPath(heart, heartPaint);

    final pulse = Path()
      ..moveTo(size.width * 0.18, c.dy)
      ..lineTo(size.width * 0.34, c.dy)
      ..lineTo(size.width * 0.42, c.dy - 6)
      ..lineTo(size.width * 0.52, c.dy + 7)
      ..lineTo(size.width * 0.62, c.dy - 3)
      ..lineTo(size.width * 0.72, c.dy)
      ..lineTo(size.width * 0.84, c.dy);

    final pulsePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    canvas.drawPath(pulse, pulsePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
