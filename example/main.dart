import 'package:flartdart/flartdart.dart';

void main() {
  runApp(const AnalyticsApp());
}

class AnalyticsApp extends Widget {
  const AnalyticsApp();

  @override
  String render(BuildContext context) {
    return FDMaterialApp(
      context: context,
      title: 'Flart Analytics',
      home: const Dashboard(),
      darkMode: true,
      rawCss: '''
        font-family: 'Inter', system-ui, -apple-system, sans-serif;
        background-color: #0f172a;
        color: #e2e8f0;
        /* Global Transitions */
        a, button, div { transition: all 0.2s ease-in-out; }
      ''',
    ).render(context);
  }
}

class Dashboard extends StatefulWidget {
  const Dashboard();

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return FDContainer(
        width: double.infinity,
        height: double.infinity,
        rawCss:
            'width: 100vw; height: 100vh; display: flex; overflow: hidden; background: #0f172a;',
        child: FDRow(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 1. Sidebar (Fixed width)
            _buildSidebar(),

            // 2. Main Content (Flexible)
            FDExpanded(
              child: FDContainer(
                rawCss:
                    'flex: 1; overflow-y: auto; position: relative; height: 100vh;',
                child: FDColumn(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Top Bar
                    _buildTopBar(),

                    // Dashboard Content Area
                    FDPadding(
                      padding: EdgeInsets.all(30),
                      child: _buildDashboardContent(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  Widget _buildSidebar() {
    return FDContainer(
      width: 280,
      rawCss: '''
        flex: 0 0 280px;
        background: #1e293b; 
        border-right: 1px solid #334155; 
        display: flex; 
        flex-direction: column;
        height: 100%;
        z-index: 20;
        box-shadow: 4px 0 24px rgba(0,0,0,0.2);
      ''',
      child: FDColumn(
        children: [
          // Logo Area
          FDContainer(
            height: 80,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 24),
            child: FDRow(
              children: [
                FDContainer(
                  width: 32,
                  height: 32,
                  rawCss:
                      'background: linear-gradient(135deg, #6366f1 0%, #a855f7 100%); border-radius: 8px;',
                  child: FDCenter(
                      child: FDText('F',
                          style: TextStyle(
                              color: '#fff', fontWeight: FontWeight.bold))),
                ),
                FDSizedBox(width: 12),
                FDText('FlartDash',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: '#f8fafc')),
              ],
            ),
          ),

          FDSizedBox(height: 20),

          // Menu Items
          _buildNavItem(0, FDIcons.home, 'Overview'),
          _buildNavItem(1, FDIcons.pie_chart, 'Analytics'),
          _buildNavItem(2, FDIcons.person, 'Customers'),
          _buildNavItem(3, FDIcons.settings, 'Settings'),

          FDSpacer(),

          // Pro Card with Hover Effect
          FDContainer(
            margin: EdgeInsets.all(20),
            padding: EdgeInsets.all(20),
            rawCss: '''
              background: linear-gradient(135deg, rgba(99, 102, 241, 0.1) 0%, rgba(168, 85, 247, 0.1) 100%);
              border: 1px solid rgba(99, 102, 241, 0.2);
              border-radius: 16px;
              cursor: default;
            ''',
            child: FDColumn(
              children: [
                FDIcon(
                    icon: FDIcons.star, color: FlartColor('#a855f7'), size: 24),
                FDSizedBox(height: 12),
                FDText('Upgrade to Pro',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: '#f8fafc')),
                FDSizedBox(height: 8),
                FDText('Get access to all features',
                    style: TextStyle(fontSize: 12, color: '#94a3b8')),
                FDSizedBox(height: 16),
                FDElevatedButton(
                  child: FDText('Upgrade Now'),
                  onPressed: () {},
                  cssStyle: {'background': '#6366f1', 'width': '100%'},
                  rawCss: '''
                    border-radius: 8px; 
                    font-size: 13px;
                    transition: transform 0.2s, box-shadow 0.2s;
                  ''',
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(int index, String icon, String label) {
    final isSelected = _selectedIndex == index;
    // We add a 'nav-item' class logic via pure rawCss strings since we don't have CSS modules
    return FDGestureDetector(
      onTap: () {
        setState(() => _selectedIndex = index);
      },
      child: FDContainer(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        rawCss: '''
          cursor: pointer;
          border-radius: 12px;
          display: flex;
          align-items: center;
          transition: all 0.2s ease;
          transform: scale(1);
          border: 1px solid transparent;
          ${isSelected ? 'background: rgba(51, 65, 85, 0.8); border-color: rgba(148, 163, 184, 0.1);' : ''}
        ''',
        child: FDRow(
          children: [
            FDIcon(
                icon: icon,
                size: 20,
                color:
                    isSelected ? FlartColor('#818cf8') : FlartColor('#64748b')),
            FDSizedBox(width: 12),
            FDText(label,
                style: TextStyle(
                    fontSize: 14,
                    color: isSelected ? '#f8fafc' : '#94a3b8',
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.normal)),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return FDContainer(
      height: 80,
      padding: EdgeInsets.symmetric(horizontal: 30),
      rawCss: '''
        background: rgba(15, 23, 42, 0.8);
        backdrop-filter: blur(10px);
        border-bottom: 1px solid #1e293b; 
        display: flex; 
        align-items: center; 
        justify-content: space-between;
        position: sticky;
        top: 0;
        z-index: 10;
      ''',
      child: FDRow(
        children: [
          // Search Bar
          FDContainer(
            width: 320,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            rawCss:
                'background: #1e293b; border-radius: 12px; display: flex; align-items: center; border: 1px solid #334155;',
            child: FDRow(
              children: [
                FDIcon(
                    icon: FDIcons.search,
                    color: FlartColor('#64748b'),
                    size: 18),
                FDSizedBox(width: 12),
                FDText('Search analytics...',
                    style: TextStyle(color: '#64748b', fontSize: 14)),
              ],
            ),
          ),

          FDSpacer(),

          // Actions
          FDIconButton(
            icon: FDIcon(
                icon: FDIcons.notifications, color: FlartColor('#94a3b8')),
            onPressed: () {},
            rawCss:
                'border-radius: 50%; padding: 8px; :hover { background: #334155; }',
          ),
          FDSizedBox(width: 16),
          FDContainer(
            width: 40,
            height: 40,
            rawCss: '''
              background: linear-gradient(135deg, #3b82f6 0%, #2dd4bf 100%); 
              border-radius: 50%; 
              border: 2px solid #1e293b; 
              cursor: pointer;
              box-shadow: 0 2px 10px rgba(59, 130, 246, 0.3);
            ''',
            child: FDCenter(
                child: FDText('JD',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: '#fff'))),
          ),
        ],
      ),
    );
  }

  Widget _buildDashboardContent() {
    return FDColumn(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Heading
        FDRow(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FDText('Dashboard Overview',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: '#f8fafc')),
            FDElevatedButton(
              child: FDRow(children: [
                FDIcon(
                    icon: FDIcons.file_upload,
                    size: 16,
                    color: FlartColor('#fff')),
                FDSizedBox(width: 8),
                FDText('Export Report')
              ]),
              onPressed: () {},
              rawCss: '''
                background: #334155; 
                border-radius: 8px; 
                border: 1px solid #475569;
                padding: 10px 20px;
                display: flex;
                align-items: center;
              ''',
            )
          ],
        ),

        FDSizedBox(height: 30),

        // Stat Cards Grid - Using flex wrap logic via simple Row expansion
        FDRow(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FDExpanded(
                child: _buildStatCard('Total Revenue', '\$54,230', '+12.5%',
                    '#10b981', FDIcons.monetization_on)),
            FDSizedBox(width: 20),
            FDExpanded(
                child: _buildStatCard('Active Users', '2,450', '+5.2%',
                    '#8b5cf6', FDIcons.person)),
            FDSizedBox(width: 20),
            FDExpanded(
                child: _buildStatCard('Bounce Rate', '42.3%', '-2.1%',
                    '#f43f5e', FDIcons.insert_chart)),
          ],
        ),

        FDSizedBox(height: 30),

        // Main Chart Section
        FDContainer(
          height: 400,
          padding: EdgeInsets.all(24),
          rawCss: '''
            background: #1e293b; 
            border-radius: 20px; 
            border: 1px solid #334155;
            position: relative;
            overflow: hidden;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
          ''',
          child: FDColumn(
            children: [
              FDRow(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FDText('Revenue Analytics',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  FDContainer(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    rawCss:
                        'background: #0f172a; border-radius: 8px; color: #94a3b8; font-size: 12px; border: 1px solid #334155;',
                    child: FDText('Last 7 Days'),
                  ),
                ],
              ),
              FDSizedBox(height: 20),
              FDExpanded(
                child: FDStack(
                  children: [
                    // Chart Lines (CSS gradients acting as bars/area)
                    FDPositioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      top: 60,
                      child: WaveShader(
                        color: '#6366f1',
                        speed: 0.5,
                        amplitude: 0.1,
                        rawCss:
                            'border-radius: 0 0 16px 16px; opacity: 0.3; filter: blur(20px);',
                      ),
                    ),
                    FDPositioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      top: 120,
                      child: WaveShader(
                        color: '#a855f7',
                        speed: 0.7,
                        amplitude: 0.05,
                        rawCss:
                            'border-radius: 0 0 16px 16px; opacity: 0.2; filter: blur(30px);',
                      ),
                    ),
                    FDCenter(
                      child: FDContainer(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        rawCss:
                            'background: rgba(15, 23, 42, 0.6); backdrop-filter: blur(4px); border-radius: 12px; border: 1px solid rgba(255,255,255,0.1);',
                        child: FDText('Live Data Visualization',
                            style: TextStyle(
                                color: '#94a3b8',
                                fontSize: 14,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        FDSizedBox(height: 30),

        // Recent Transactions Section
        FDText('Recent Transactions',
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: '#f8fafc')),
        FDSizedBox(height: 20),
        _buildTransactionItem('Netflix Subscription', 'Mar 2, 2024', '-\$15.00',
            FDIcons.play_arrow, '#f43f5e'),
        _buildTransactionItem('Freelance Project', 'Mar 1, 2024', '+\$450.00',
            FDIcons.work, '#10b981'),
        _buildTransactionItem('Grocery Shopping', 'Feb 28, 2024', '-\$84.20',
            FDIcons.shopping_cart, '#f59e0b'),
        FDSizedBox(height: 40), // Bottom breathing room
      ],
    );
  }

  Widget _buildStatCard(String title, String value, String change,
      String trendColor, String icon) {
    return FDContainer(
      padding: EdgeInsets.all(24),
      rawCss: '''
        background: #1e293b; 
        border: 1px solid #334155; 
        border-radius: 20px;
        transition: transform 0.2s ease, box-shadow 0.2s ease;
      ''',
      child: FDColumn(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FDRow(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FDText(title, style: TextStyle(color: '#94a3b8', fontSize: 14)),
              FDIcon(icon: icon, color: FlartColor('#475569'), size: 20),
            ],
          ),
          FDSizedBox(height: 16),
          FDRow(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              FDText(value,
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: '#f8fafc')),
              FDContainer(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                rawCss:
                    'background: ${trendColor}15; border-radius: 6px; display: flex; align-items: center;',
                child: FDText(change,
                    style: TextStyle(
                        color: trendColor,
                        fontSize: 12,
                        fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionItem(
      String title, String date, String amount, String icon, String color) {
    return FDContainer(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(16),
      rawCss: '''
        background: #1e293b; 
        border-radius: 12px; 
        border: 1px solid #334155; 
        display: flex; 
        align-items: center;
        transition: background 0.2s;
      ''',
      child: FDRow(
        children: [
          FDContainer(
            width: 48,
            height: 48,
            rawCss:
                'background: ${color}15; border-radius: 12px; display: flex; align-items: center; justify-content: center;',
            child: FDIcon(icon: icon, color: FlartColor(color), size: 24),
          ),
          FDSizedBox(width: 16),
          FDColumn(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FDText(title,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: '#f1f5f9',
                      fontSize: 15)),
              FDSizedBox(height: 4),
              FDText(date, style: TextStyle(fontSize: 13, color: '#64748b')),
            ],
          ),
          FDSpacer(),
          FDText(amount,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: amount.startsWith('+') ? '#10b981' : '#f1f5f9',
                  fontSize: 15)),
        ],
      ),
    );
  }
}
