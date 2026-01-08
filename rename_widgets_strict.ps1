
$mappings = @{
      "Container"                 = "FDContainer";
      "SizedBox"                  = "FDSizedBox";
      "Row"                       = "FDRow";
      "Column"                    = "FDColumn";
      "Stack"                     = "FDStack";
      "Positioned"                = "FDPositioned";
      "Expanded"                  = "FDExpanded";
      "Center"                    = "FDCenter";
      "Align"                     = "FDAlign";
      "Spacer"                    = "FDSpacer";
      "ListView"                  = "FDListView";
      "GridView"                  = "FDGridView";
      "Scaffold"                  = "FDScaffold";
      "AppBar"                    = "FDAppBar";
      "Drawer"                    = "FDDrawer";
      "Dialog"                    = "FDDialog";
      "Card"                      = "FDCard";
      "Divider"                   = "FDDivider";
      "VerticalDivider"           = "FDVerticalDivider";
      "Text"                      = "FDText";
      "RichText"                  = "FDRichText";
      "LinkText"                  = "FDLinkText";
      "EditableText"              = "FDEditableText";
      "SelectableText"            = "FDSelectableText";
      "Icon"                      = "FDIcon";
      "Icons"                     = "FDIcons";
      "FlartImage"                = "FDImage";
      "Image"                     = "FDImage";
      "FloatingActionButton"      = "FDFloatingActionButton";
      "ElevatedButton"            = "FDElevatedButton";
      "TextButton"                = "FDTextButton";
      "IconButton"                = "FDIconButton";
      "BottomNavigationBar"       = "FDBottomNavigationBar";
      "BottomNavigationBarItem"   = "FDBottomNavigationBarItem";
      "TabBar"                    = "FDTabBar";
      "TabBarView"                = "FDTabBarView";
      "Chip"                      = "FDChip";
      "CircularProgressIndicator" = "FDCircularProgressIndicator";
      "LinearProgressIndicator"   = "FDLinearProgressIndicator";
      "MaterialApp"               = "FDMaterialApp";
      "TextField"                 = "FDTextField";
      "TextFormField"             = "FDTextFormField";
      "Checkbox"                  = "FDCheckbox";
      "Switch"                    = "FDSwitch";
      "Slider"                    = "FDSlider";
      "Radio"                     = "FDRadio";
      "GestureDetector"           = "FDGestureDetector";
      "CustomPaint"               = "FDCustomPaint";
      "SvgPicture"                = "FDSvgPicture";
      "DatePicker"                = "FDDatePicker";
      "TimePicker"                = "FDTimePicker";
      "DateRangePicker"           = "FDDateRangePicker";
      "MonthPicker"               = "FDMonthPicker";
      "WeekPicker"                = "FDWeekPicker";
      "ImagePicker"               = "FDImagePicker";
      "Tooltip"                   = "FDTooltip";
      "SnackBar"                  = "FDSnackBar";
      "Badge"                     = "FDBadge";
      "Button"                    = "FDButton";
}

$files = Get-ChildItem -Path "lib", "example" -Recurse -Include *.dart
$docs = Get-ChildItem -Path "." -Recurse -Include *.md

$allFiles = $files + $docs

foreach ($file in $allFiles) {
      if ($file.FullName -match "\\.antigravity" -or $file.Name -eq "fix_casing.ps1" -or $file.Name -eq "revert_widgets.ps1") { continue }
    
      $content = Get-Content $file.FullName -Raw
      $originalContent = $content
    
      foreach ($key in $mappings.Keys) {
            $val = $mappings[$key]
            # Strict Case Sensitive Replacement
            $content = $content -creplace "\b$key\b", $val
      }
    
      if ($content -ne $originalContent) {
            Set-Content $file.FullName -Value $content -Encoding UTF8
            Write-Host "Renamed widgets in $($file.Name)"
      }
}
