
$mappings = @{
    "Container" = "FDContainer";
    "SizedBox" = "FDSizedBox";
    "Row" = "FDRow";
    "Column" = "FDColumn";
    "Stack" = "FDStack";
    "Positioned" = "FDPositioned";
    "Expanded" = "FDExpanded";
    "Center" = "FDCenter";
    "Align" = "FDAlign";
    "Spacer" = "FDSpacer";
    "ListView" = "FDListView";
    "GridView" = "FDGridView";
    "Scaffold" = "FDScaffold";
    "AppBar" = "FDAppBar";
    "Drawer" = "FDDrawer";
    "Dialog" = "FDDialog";
    "Card" = "FDCard";
    "Divider" = "FDDivider";
    "VerticalDivider" = "FDVerticalDivider";
    "Text" = "FDText";
    "RichText" = "FDRichText";
    "LinkText" = "FDLinkText";
    "EditableText" = "FDEditableText";
    "SelectableText" = "FDSelectableText";
    "Icon" = "FDIcon";
    "Icons" = "FDIcons";
    "FlartImage" = "FDImage";
    "Image" = "FDImage";
    "FloatingActionButton" = "FDFloatingActionButton";
    "ElevatedButton" = "FDElevatedButton";
    "TextButton" = "FDTextButton";
    "IconButton" = "FDIconButton";
    "BottomNavigationBar" = "FDBottomNavigationBar";
    "BottomNavigationBarItem" = "FDBottomNavigationBarItem";
    "TabBar" = "FDTabBar";
    "TabBarView" = "FDTabBarView";
    "Chip" = "FDChip";
    "CircularProgressIndicator" = "FDCircularProgressIndicator";
    "LinearProgressIndicator" = "FDLinearProgressIndicator";
    "MaterialApp" = "FDMaterialApp";
    "TextField" = "FDTextField";
    "TextFormField" = "FDTextFormField";
    "Checkbox" = "FDCheckbox";
    "Switch" = "FDSwitch";
    "Slider" = "FDSlider";
    "Radio" = "FDRadio";
    "GestureDetector" = "FDGestureDetector";
    "CustomPaint" = "FDCustomPaint";
    "SvgPicture" = "FDSvgPicture";
    "DatePicker" = "FDDatePicker";
    "TimePicker" = "FDTimePicker";
    "DateRangePicker" = "FDDateRangePicker";
    "MonthPicker" = "FDMonthPicker";
    "WeekPicker" = "FDWeekPicker";
    "ImagePicker" = "FDImagePicker";
    "Tooltip" = "FDTooltip";
    "SnackBar" = "FDSnackBar";
    "Badge" = "FDBadge";
    "Button" = "FDButton";
}

$files = Get-ChildItem -Path "lib","example" -Recurse -Include *.dart
$docs = Get-ChildItem -Path "." -Recurse -Include *.md

$allFiles = $files + $docs

foreach ($file in $allFiles) {
    if ($file.FullName -match "\\.antigravity") { continue }
    
    $content = Get-Content $file.FullName -Raw
    $originalContent = $content
    
    foreach ($key in $mappings.Keys) {
        $val = $mappings[$key]
        # REVERSE MAPPING: Val -> Key
        # Case Insensitive to catch FDContainer and FDcontainer
        $content = $content -replace "\b$val\b", $key 
    }
    
    # Correction: FlartImage was mapped to FDImage.
    # But Image was ALSO mapped to FDImage.
    # The reverse loop will replace FDImage with FlartImage OR Image depending on iteration order?
    # Actually keys order is random.
    # If "FlartImage" comes last, FDImage -> FlartImage.
    # If "Image" comes last, FDImage -> Image.
    # This is non-deterministic reversal for collisions.
    # Usage of FlartImage vs Image.
    
    if ($content -ne $originalContent) {
        Set-Content $file.FullName -Value $content -Encoding UTF8
        Write-Host "Reverted $($file.Name)"
    }
}
