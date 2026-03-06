import 'package:flartdart/flartdart.dart';

void main() {
  // Initialize Responsive Utility with desktop design size (1440x900)
  ScreenUtil.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp();

  @override
  Widget build(BuildContext context) {
    return FDMaterialApp(
      title: 'Flartdart App',
      home: FDScaffold(
        appBar: const FDAppBar(
          title: FDText('Welcome to Flartdart'),
          backgroundColor: FlartColors.blue,
        ),
        body: FDCenter(
          child: FDColumn(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const FDIcon(
                icon: FDIcons.favorite,
                size: 64.0,
                color: FlartColors.red,
              ),
              FDSizedBox(height: 20.0.h),
              FDText(
                'Hello, Flartdart!',
                style: TextStyle(
                  fontSize: 32.0.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              FDSizedBox(height: 10.0.h),
              FDText(
                'Your new project is ready.',
                style: TextStyle(fontSize: 18.0.sp),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
