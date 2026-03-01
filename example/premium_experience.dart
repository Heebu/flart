import 'package:flartdart/flartdart.dart';

void main() {
  runApp(const PremiumShowcase());
}

class PremiumShowcase extends StatelessWidget {
  const PremiumShowcase({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FDMaterialApp(
      title: 'Premium Flart Experience',
      home: const ScrollShowcasePage(),
    );
  }
}

class ScrollShowcasePage extends StatefulWidget {
  const ScrollShowcasePage({Key? key}) : super(key: key);

  @override
  State<ScrollShowcasePage> createState() => _ScrollShowcasePageState();
}

class _ScrollShowcasePageState extends State<ScrollShowcasePage> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    // Simulate data loading to show the skeleton loader
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return FDScaffold(
      body: FDContainer(
        cssStyle: {
          'height': '100%',
          'overflow': 'auto',
          'background-color': theme.scaffoldBackgroundColor.toString(),
        },
        child: FDColumn(
          children: [
            // PREMIUM: Sliver App Bar
            FDSliverAppBar(
              title: FDText('Premium Experience'),
              expandedHeight: 250,
              flexibleSpace: FDStack(
                children: [
                  FDImage.network(
                    'https://images.unsplash.com/photo-1579546929518-9e396f3cc809?q=80&w=2070&auto=format&fit=crop',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 250,
                  ),
                  FDContainer(
                    cssStyle: {
                      'background':
                          'linear-gradient(to bottom, transparent 0%, rgba(0,0,0,0.7) 100%)',
                      'display': 'flex',
                      'align-items': 'flex-end',
                      'padding': '24px',
                      'color': 'white',
                    },
                    child: FDText(
                      'Welcome to Flart v1.3 🚀',
                      style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              actions: [
                FDIconButton(
                  icon:
                      FDIcon(icon: FDIcons.settings, color: FlartColors.white),
                  onPressed: () {},
                ),
              ],
            ),

            // CONTENT
            FDPadding(
              padding: EdgeInsets.all(24),
              child: FDColumn(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _sectionTitle('Interactive Components'),
                  FDSizedBox(height: 16),

                  _isLoading ? _buildSkeletonUI() : _buildDataRows(theme),

                  FDSizedBox(height: 48),
                  _sectionTitle('Recent Analytics'),
                  FDSizedBox(height: 16),

                  _isLoading
                      ? FDSkeleton(
                          height: 200, borderRadius: BorderRadius.circular(12))
                      : _buildDataTable(theme),

                  FDSizedBox(height: 80), // Bottom padding for scroll
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return FDText(title,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold));
  }

  Widget _buildSkeletonUI() {
    return FDColumn(
      children: List.generate(
          3,
          (index) => FDPadding(
                padding: EdgeInsets.only(bottom: 16),
                child: FDRow(
                  children: [
                    FDSkeleton.circle(radius: 25),
                    FDSizedBox(width: 16),
                    FDExpanded(
                      child: FDColumn(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FDSkeleton(width: 200, height: 20),
                          FDSizedBox(height: 8),
                          FDSkeleton(width: 150, height: 14),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
    );
  }

  Widget _buildDataRows(ThemeData theme) {
    return FDColumn(
      children: [
        _itemRow(FDIcons.person, 'User Profiles', 'Manage app members', theme),
        _itemRow(
            FDIcons.monetization_on, 'Revenue', 'Track monthly growth', theme),
        _itemRow(
            FDIcons.notifications, 'Alerts', 'System health status', theme),
      ],
    );
  }

  Widget _itemRow(String icon, String title, String subtitle, ThemeData theme) {
    return FDAnimate(
      fadeIn: true,
      slideX: -20,
      duration: Duration(milliseconds: 500),
      child: FDCard(
        margin: EdgeInsets.only(bottom: 16),
        padding: EdgeInsets.all(16),
        child: FDRow(
          children: [
            FDIcon(icon: icon, color: theme.primaryColor, size: 32),
            FDSizedBox(width: 16),
            FDColumn(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FDText(title,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                FDText(subtitle,
                    style: TextStyle(fontSize: 14, color: FlartColors.grey)),
              ],
            ),
            FDSpacer(),
            FDIcon(icon: FDIcons.chevron_right, color: FlartColors.grey),
          ],
        ),
      ),
    );
  }

  Widget _buildDataTable(ThemeData theme) {
    return FDDataTable(
      columns: [
        FDDataColumn(label: FDText('Source')),
        FDDataColumn(label: FDText('Visits'), numeric: true),
        FDDataColumn(label: FDText('Conversion')),
      ],
      rows: [
        FDDataRow(cells: [
          FDDataCell(child: FDText('Direct')),
          FDDataCell(child: FDText('1,240')),
          FDDataCell(child: FDText('12.4%')),
        ]),
        FDDataRow(cells: [
          FDDataCell(child: FDText('Social')),
          FDDataCell(child: FDText('890')),
          FDDataCell(child: FDText('8.1%')),
        ]),
        FDDataRow(cells: [
          FDDataCell(child: FDText('Email')),
          FDDataCell(child: FDText('560')),
          FDDataCell(child: FDText('15.2%')),
        ]),
      ],
    );
  }
}
