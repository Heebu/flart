
# 1. Fix Scaffold internal variable names (camelCase)
$scaffoldPath = "lib/src/widgets/structure/scaffold.dart"
if (Test-Path $scaffoldPath) {
      $c = Get-Content $scaffoldPath -Raw
      $c = $c -creplace "final FDAppBar\? FDAppBar;", "final FDAppBar? appBar;"
      $c = $c -creplace "final FDDrawer\? FDDrawer;", "final FDDrawer? drawer;"
      $c = $c -creplace "final FDBottomNavigationBar\? FDBottomNavigationBar;", "final FDBottomNavigationBar? bottomNavigationBar;"
      $c = $c -creplace "final FDFloatingActionButton\? FDFloatingActionButton;", "final FDFloatingActionButton? floatingActionButton;"
    
      # Text replacements for usages
      $c = $c -creplace "this.FDAppBar", "this.appBar"
      $c = $c -creplace "this.FDDrawer", "this.drawer"
      $c = $c -creplace "this.FDBottomNavigationBar", "this.bottomNavigationBar"
      $c = $c -creplace "this.FDFloatingActionButton", "this.floatingActionButton"
    
      $c = $c -creplace "if \(FDAppBar != null\)", "if (appBar != null)"
      $c = $c -creplace "content.writeln\(FDAppBar!.render", "content.writeln(appBar!.render"
    
      $c = $c -creplace "if \(FDBottomNavigationBar != null\)", "if (bottomNavigationBar != null)"
      $c = $c -creplace "content.writeln\(FDBottomNavigationBar!.render", "content.writeln(bottomNavigationBar!.render"
    
      $c = $c -creplace "if \(FDFloatingActionButton != null\)", "if (floatingActionButton != null)"
      $c = $c -creplace "\$\{FDFloatingActionButton!.render", "${floatingActionButton!.render"
    
    # Drawer logic
    $c = $c -creplace "final drawerHtml = FDDrawer != null", "final drawerHtml = drawer != null"
    $c = $c -creplace "\$\{FDDrawer!.render", "${drawer!.render"
    
    # Fix Flex Direction string
    $c = $c -creplace "'FDColumn'", "'column'"
    
    # Clean up JS/ID names
    $c = $c -creplace "flart-FDDrawer", "flart-drawer"
    $c = $c -creplace "const FDDrawer =", "const drawer ="
    $c = $c -creplace "if \(FDDrawer.style", "if (drawer.style"
    $c = $c -creplace "FDDrawer.style.transform", "drawer.style.transform"

    Set-Content $scaffoldPath -Value $c -Encoding UTF8
    Write-Host "Fixed scaffold.dart"
}

# 2. Fix Main.dart
$mainPath = "example/main.dart"
if (Test-Path $mainPath) {
    $c = Get-Content $mainPath -Raw
    
    # Fix FDScaffold arguments
    $c = $c -creplace "FDAppBar: FDAppBar", "appBar: FDAppBar"
    $c = $c -creplace "FDDrawer: FDDrawer", "drawer: FDDrawer"
    $c = $c -creplace "FDFloatingActionButton: FDFloatingActionButton", "floatingActionButton: FDFloatingActionButton"
    
    # Fix Lowercase Widgets
    $c = $c -creplace "\brow\(", "FDRow("
    $c = $c -creplace "\bcolumn\(", "FDColumn("
    $c = $c -creplace "\bcenter\(", "FDCenter("
    $c = $c -creplace "\bswitch\(", "FDSwitch("
    
    # Fix FDText param
    $c = $c -creplace "String FDText\)", "String text)"
    $c = $c -creplace "FDText\(\s*FDText, ", "FDText(text, "
    
    Set-Content $mainPath -Value $c -Encoding UTF8
    Write-Host "Fixed main.dart"
}
