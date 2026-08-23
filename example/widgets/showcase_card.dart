import 'package:flartdart/flartdart.dart';

class ShowcaseCard extends StatelessWidget {
  final String title;
  final String description;
  final Widget child;

  ShowcaseCard({
    required this.title,
    required this.description,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return FDContainer(
      margin: EdgeInsets.only(bottom: 32),
      decoration: BoxDecoration(
        color: FlartColor('#ffffff'),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: FlartColor('#e2e8f0'), width: 1),
        boxShadow: [
          BoxShadow(
            color: FlartColor('#000000').withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: FDColumn(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header section
          FDContainer(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(color: FlartColor('#e2e8f0'), width: 1)),
            ),
            child: FDColumn(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FDText(
                  title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: FlartColor('#1e293b'),
                  ),
                ),
                FDSizedBox(height: 8),
                FDText(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: FlartColor('#64748b'),
                  ),
                ),
              ],
            ),
          ),

          // Widget showcase section
          FDContainer(
            padding: EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: FlartColor('#f8fafc'),
              borderRadius: BorderRadius.only(
                bottomLeft: 12,
                bottomRight: 12,
              ),
            ),
            child: FDCenter(child: child),
          ),
        ],
      ),
    );
  }
}
