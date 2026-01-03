import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'tableau_embed_card.dart';

class TableauEmbedCarouselItem {
  final String title;
  final String html;

  const TableauEmbedCarouselItem({
    required this.title,
    required this.html,
  });
}

/// Horizontal swipe carousel for Tableau dashboard cards with indicator dots.
class TableauEmbedCarousel extends StatefulWidget {
  final List<TableauEmbedCarouselItem> items;
  final double cardHeight;

  const TableauEmbedCarousel({
    super.key,
    required this.items,
    required this.cardHeight,
  });

  @override
  State<TableauEmbedCarousel> createState() => _TableauEmbedCarouselState();
}

class _TableauEmbedCarouselState extends State<TableauEmbedCarousel> {
  late final PageController _controller;
  int _index = 0;

  @override
  void initState() {
    super.initState();
    _controller = PageController(viewportFraction: 0.92);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.items.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      children: [
        SizedBox(
          height: widget.cardHeight,
          child: PageView.builder(
            controller: _controller,
            itemCount: widget.items.length,
            onPageChanged: (i) => setState(() => _index = i),
            itemBuilder: (context, i) {
              final item = widget.items[i];
              return Padding(
                padding: EdgeInsets.only(
                  left: i == 0 ? 0 : 6,
                  right: i == widget.items.length - 1 ? 0 : 6,
                ),
                child: TableauEmbedCard(
                  title: item.title,
                  html: item.html,
                  height: widget.cardHeight,
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 10),
        _DotsIndicator(
          count: widget.items.length,
          index: _index,
        ),
      ],
    );
  }
}

class _DotsIndicator extends StatelessWidget {
  final int count;
  final int index;

  const _DotsIndicator({
    required this.count,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    if (count <= 1) return const SizedBox.shrink();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (i) {
        final active = i == index;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOut,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: active ? 18 : 7,
          height: 7,
          decoration: BoxDecoration(
            color: active ? AppColors.primary : AppColors.primary.withOpacity(0.25),
            borderRadius: BorderRadius.circular(999),
          ),
        );
      }),
    );
  }
}


