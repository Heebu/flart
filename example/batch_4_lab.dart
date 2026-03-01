import 'package:flartdart/flartdart.dart';

class Batch4Lab extends StatefulWidget {
  const Batch4Lab({Key? key}) : super(key: key);

  @override
  State<Batch4Lab> createState() => _Batch4LabState();
}

class _Batch4LabState extends State<Batch4Lab> {
  double _progress = 0.3;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return FDScaffold(
      appBar: FDAppBar(title: FDText('Batch 4: Content & Info')),
      body: FDListView(
        padding: EdgeInsets.all(24),
        children: [
          _sectionTitle('1. Progress Indicators'),
          FDRow(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FDCircularProgressIndicator(),
              FDCircularProgressIndicator(
                  size: 60, strokeWidth: 8, color: theme.successColor),
            ],
          ),
          FDSizedBox(height: 24),
          FDLinearProgressIndicator(value: _progress),
          FDSizedBox(height: 12),
          FDLinearProgressIndicator(), // Indeterminate
          FDElevatedButton(
            onPressed: () =>
                setState(() => _progress = (_progress + 0.1) % 1.0),
            child: FDText('Advance Progress'),
          ),

          FDSizedBox(height: 32),
          _sectionTitle('2. Chips & Badges'),
          FDRow(
            children: [
              FDChip(label: FDText('Flutter')),
              FDSizedBox(width: 8),
              FDChip(
                label: FDText('Verified'),
                backgroundColor: theme.successColor,
                avatar: FDIcon(
                    icon: FDIcons.done, size: 14, color: FlartColors.white),
              ),
              FDSizedBox(width: 8),
              FDChip(
                label: FDText('Delete Me'),
                onDeleted: () {},
              ),
            ],
          ),
          FDSizedBox(height: 24),
          FDRow(
            children: [
              FDBadge(
                label: '99+',
                child: FDIcon(icon: FDIcons.notifications, size: 32),
              ),
              FDSizedBox(width: 32),
              FDBadge(
                label: 'NEW',
                backgroundColor: theme.primaryColor,
                child: FDContainer(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: theme.cardColor,
                      borderRadius: BorderRadius.circular(4)),
                  child: FDText('Features'),
                ),
              ),
            ],
          ),

          FDSizedBox(height: 32),
          _sectionTitle('3. Images & SVGs'),
          FDRow(
            children: [
              FDContainer(
                width: 100,
                height: 100,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(12)),
                child: FDImage.network('https://via.placeholder.com/100'),
              ),
              FDSizedBox(width: 16),
              FDText('Placeholder Image Asset'),
            ],
          ),

          FDSizedBox(height: 32),
          _sectionTitle('4. Skeleton Loaders'),
          FDColumn(
            children: [
              FDRow(
                children: [
                  FDSkeleton.circle(radius: 20),
                  FDSizedBox(width: 12),
                  FDColumn(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      FDSkeleton(width: 120, height: 16),
                      FDSizedBox(height: 8),
                      FDSkeleton(width: 80, height: 12),
                    ],
                  ),
                ],
              ),
              FDSizedBox(height: 24),
              FDSkeleton(height: 150, borderRadius: BorderRadius.circular(12)),
              FDSizedBox(height: 12),
              FDSkeleton(width: 200, height: 20),
            ],
          ),

          FDSizedBox(height: 32),
          _sectionTitle('5. Data Tables'),
          FDDataTable(
            columns: [
              FDDataColumn(label: FDText('ID'), numeric: true),
              FDDataColumn(label: FDText('Name')),
              FDDataColumn(label: FDText('Status')),
            ],
            rows: [
              FDDataRow(cells: [
                FDDataCell(child: FDText('1')),
                FDDataCell(child: FDText('Widget Alpha')),
                FDDataCell(
                  child: FDChip(
                    label: FDText('Active'),
                    backgroundColor: theme.successColor,
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  ),
                ),
              ]),
              FDDataRow(cells: [
                FDDataCell(child: FDText('2')),
                FDDataCell(child: FDText('Component Beta')),
                FDDataCell(
                  child: FDChip(
                    label: FDText('Deprecated'),
                    backgroundColor: theme.errorColor,
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  ),
                ),
              ]),
            ],
          ),

          FDSizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return FDPadding(
      padding: EdgeInsets.only(bottom: 16),
      child: FDText(title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
    );
  }
}
