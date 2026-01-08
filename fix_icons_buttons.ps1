
# Fix Icons and Buttons

$files = Get-ChildItem -Path "lib", "example" -Recurse -Include *.dart
foreach ($file in $files) {
      if ($file.FullName -match "\\.antigravity" -or $file.Name -match "fix_.*\.ps1") { continue }
    
      $c = Get-Content $file.FullName -Raw
      $originalContent = $c
    
      # 1. Icons.dart & usage
      $c = $c -creplace 'final String FDIcon;', 'final String icon;'
      $c = $c -creplace 'final FDIcon FDIcon;', 'final FDIcon icon;'
      $c = $c -creplace 'required this.FDIcon', 'required this.icon'
      $c = $c -creplace 'this.FDIcon', 'this.icon' # Careful?
      $c = $c -creplace 'FDIcon:' , 'icon:' # Named Arg
      $c = $c -creplace '\$FDIcon', '$icon'
      $c = $c -creplace 'material-FDIcons', 'material-icons'
      $c = $c -creplace 'Material FDIcons', 'Material Icons'
    
      # 2. Button.dart logic
      $c = $c -creplace '<FDButton', '<button'
      $c = $c -creplace '</FDButton>', '</button>'
      $c = $c -creplace '\(FDText \?\?', '(text ??'
      $c = $c -creplace "'FDButton'", "'Button'" # Label fallback?
    
      if ($c -ne $originalContent) {
            Set-Content $file.FullName -Value $c -Encoding UTF8
            Write-Host "Fixed icons/buttons in $($file.Name)"
      }
}
