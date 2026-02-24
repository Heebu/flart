import 'package:flartdart/flartdart.dart';

class Batch1Lab extends StatefulWidget {
  const Batch1Lab({Key? key}) : super(key: key);

  @override
  State<Batch1Lab> createState() => _Batch1LabState();
}

class _Batch1LabState extends State<Batch1Lab> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return FDScaffold(
      appBar: FDAppBar(
        title: FDText('Batch 1: Core Foundation'),
        actions: [
          FDElevatedButton(
            onPressed: () => reRenderApp(),
            child: FDText('Refresh'),
          ),
        ],
      ),
      body: FDListView(
        padding: EdgeInsets.all(24),
        children: [
          _sectionTitle('1. FDContainer & BoxDecoration'),
          _subTitle('Testing Gradients, Borders, and Shadows'),
          FDRow(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FDContainer(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: FlartColors.blue,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: FlartColor('#00000044'),
                      blurRadius: 10,
                      offsetX: 0,
                      offsetY: 4,
                    )
                  ],
                ),
                child: FDCenter(
                    child: FDText('Flat',
                        style: TextStyle(color: FlartColors.white))),
              ),
              FDContainer(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  gradient: Gradient(
                    colors: [FlartColors.purple, FlartColors.blue],
                    direction: 'to bottom right',
                  ),
                  borderRadius: BorderRadius.circular(50), // Circle
                  border: Border.all(
                    side: BorderSide(color: FlartColors.white, width: 3),
                  ),
                ),
                child: FDCenter(
                    child: FDText('Gradient',
                        style: TextStyle(color: FlartColors.white))),
              ),
            ],
          ),
          FDSizedBox(height: 32),
          _sectionTitle('2. FDCard & Elevation'),
          _subTitle('Testing Material Design surfaces'),
          FDRow(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FDCard(
                elevation: 2,
                padding: EdgeInsets.all(16),
                child: FDText('Low Elevation'),
              ),
              FDCard(
                elevation: 8,
                padding: EdgeInsets.all(16),
                child: FDText('High Elevation'),
              ),
            ],
          ),
          FDSizedBox(height: 32),
          _sectionTitle('3. Flex Layout (Row/Column/Expanded/Spacer)'),
          _subTitle('Testing alignment and flexible space distribution'),
          FDContainer(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(
                side: BorderSide(color: theme.dividerColor),
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: FDColumn(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FDText('Parent Column (Cross: Start)',
                    style: TextStyle(fontSize: 12)),
                FDSizedBox(height: 10),
                FDRow(
                  children: [
                    FDContainer(
                        width: 50,
                        height: 30,
                        decoration: BoxDecoration(color: FlartColors.red)),
                    FDSpacer(),
                    FDText('Spacer in between'),
                    FDSpacer(),
                    FDContainer(
                        width: 50,
                        height: 30,
                        decoration: BoxDecoration(color: FlartColors.green)),
                  ],
                ),
                FDSizedBox(height: 20),
                FDRow(
                  children: [
                    FDExpanded(
                      flex: 1,
                      child: FDContainer(
                          height: 40,
                          decoration: BoxDecoration(color: FlartColors.amber),
                          child: FDCenter(child: FDText('Flex 1'))),
                    ),
                    FDSizedBox(width: 10),
                    FDExpanded(
                      flex: 2,
                      child: FDContainer(
                          height: 40,
                          decoration: BoxDecoration(color: FlartColors.indigo),
                          child: FDCenter(
                              child: FDText('Flex 2',
                                  style: TextStyle(color: FlartColors.white)))),
                    ),
                  ],
                ),
              ],
            ),
          ),
          FDSizedBox(height: 32),
          _sectionTitle('4. FDStack & FDPositioned'),
          _subTitle('Testing Z-index and absolute positioning'),
          FDCenter(
            child: FDContainer(
              width: 200,
              height: 150,
              decoration: BoxDecoration(
                  color: theme.cardColor,
                  border: Border.all(
                    side: BorderSide(color: theme.dividerColor),
                  )),
              child: FDStack(
                children: [
                  FDPositioned(
                    top: 10,
                    left: 10,
                    child: FDContainer(
                        width: 60,
                        height: 60,
                        decoration:
                            BoxDecoration(color: FlartColors.pink.shade50)),
                  ),
                  FDPositioned(
                    bottom: 10,
                    right: 10,
                    child: FDContainer(
                        width: 60,
                        height: 60,
                        decoration:
                            BoxDecoration(color: FlartColors.indigo.shade100)),
                  ),
                  FDCenter(
                    child: FDContainer(
                      padding: EdgeInsets.all(8),
                      decoration:
                          BoxDecoration(color: FlartColors.white, boxShadow: [
                        BoxShadow(
                          color: FlartColor('#00000022'),
                          blurRadius: 4,
                          offsetX: 0,
                          offsetY: 2,
                        )
                      ]),
                      child: FDText('Centered in Stack'),
                    ),
                  ),
                ],
              ),
            ),
          ),
          FDSizedBox(height: 32),
          _sectionTitle('5. Alignment & Spacing (Align/Padding/SizedBox)'),
          FDContainer(
            height: 100,
            decoration: BoxDecoration(color: theme.cardColor),
            child: FDAlign(
              alignment: Aligns.bottomRight,
              child: FDPadding(
                padding: EdgeInsets.all(16),
                child: FDContainer(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(color: theme.primaryColor)),
              ),
            ),
          ),
          FDSizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return FDPadding(
      padding: EdgeInsets.only(bottom: 8),
      child: FDText(title,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
    );
  }

  Widget _subTitle(String title) {
    return FDPadding(
      padding: EdgeInsets.only(bottom: 16),
      child: FDText(title,
          style: TextStyle(fontSize: 14, color: FlartColor('#666666'))),
    );
  }
}
