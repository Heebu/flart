
$path = "lib/flartdart.dart"
$c = Get-Content $path -Raw

# 1. Add BoxFit export
if ($c -notmatch "box_fit.dart") {
      $c = $c -replace "export 'src/enums/text_tag.dart';", "export 'src/enums/text_tag.dart';`nexport 'src/enums/box_fit.dart';"
}

# 2. Fix broken file imports (Remove FD prefix and lowercase)
# Structure
$c = $c -ireplace "structure/FDScaffold.dart", "structure/scaffold.dart"
$c = $c -ireplace "structure/FDAppBar.dart", "structure/appbar.dart"
$c = $c -ireplace "structure/FDContainer.dart", "structure/container.dart"
$c = $c -ireplace "structure/FDImage.dart", "structure/image.dart"
$c = $c -ireplace "structure/FDIcons.dart", "structure/icons.dart"
$c = $c -ireplace "structure/FDDialog.dart", "structure/dialog.dart"
$c = $c -ireplace "structure/FDDrawer.dart", "structure/drawer.dart"
$c = $c -ireplace "structure/FDDivider.dart", "structure/divider.dart"
$c = $c -ireplace "structure/FDGridView.dart", "structure/gridview.dart"
$c = $c -ireplace "structure/FDSpacer.dart", "structure/spacer.dart"
$c = $c -ireplace "structure/FDExpanded.dart", "structure/expanded.dart"
$c = $c -ireplace "structure/FDCard.dart", "structure/card.dart"

# Arrangement
$c = $c -ireplace "arrangement_widgets/FDAlign.dart", "arrangement_widgets/align.dart"
$c = $c -ireplace "arrangement_widgets/FDCenter.dart", "arrangement_widgets/center.dart"
$c = $c -ireplace "arrangement_widgets/FDColumn.dart", "arrangement_widgets/column.dart"
$c = $c -ireplace "arrangement_widgets/FDListView.dart", "arrangement_widgets/list_view.dart" # Check filename!
$c = $c -ireplace "arrangement_widgets/FDRow.dart", "arrangement_widgets/row.dart"
$c = $c -ireplace "arrangement_widgets/FDStack.dart", "arrangement_widgets/stack.dart"

# Buttons
$c = $c -ireplace "buttons/FDButton.dart", "buttons/button.dart"

# Inputs
$c = $c -ireplace "inputs/FDTextField.dart", "inputs/textfield.dart"

# Texts
$c = $c -ireplace "texts/FDText.dart", "texts/text.dart"
$c = $c -ireplace "texts/FDRichText.dart", "texts/richtext.dart" # Check filename

# Styles
$c = $c -ireplace "styles/FDAlign.dart", "styles/align.dart"

Set-Content $path -Value $c -Encoding UTF8
Write-Host "Fixed flartdart.dart"
