import 'package:flartdart/flartdart.dart';

class ShowcaseCard extends StatelessWidget {
  final String title;
  final String description;
  final Widget child;

  const ShowcaseCard({
    required this.title,
    required this.description,
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final isSmall = mq.isSmall;
    final isMedium = mq.isMedium;

    final headerPadding = isSmall
        ? const EdgeInsets.symmetric(horizontal: 14, vertical: 12)
        : isMedium
            ? const EdgeInsets.all(16)
            : const EdgeInsets.all(20);

    final contentPadding = isSmall
        ? const EdgeInsets.all(12)
        : isMedium
            ? const EdgeInsets.all(20)
            : const EdgeInsets.all(28);

    return Container(
      margin: EdgeInsets.only(bottom: isSmall ? 16 : 28),
      decoration: BoxDecoration(
        color: const FlartColor('#ffffff'),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const FlartColor('#e2e8f0'), width: 1),
        boxShadow: [
          BoxShadow(
            color: const FlartColor('#000000').withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: headerPadding,
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: FlartColor('#e2e8f0'), width: 1),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: isSmall ? 17 : 20,
                    fontWeight: FontWeight.bold,
                    color: const FlartColor('#1e293b'),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: isSmall ? 13 : 14,
                    color: const FlartColor('#64748b'),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: contentPadding,
            decoration: const BoxDecoration(
              color: FlartColor('#f8fafc'),
              borderRadius: BorderRadius.only(
                bottomLeft: 12,
                bottomRight: 12,
              ),
            ),
            child: Center(child: child),
          ),
        ],
      ),
    );
  }
}
