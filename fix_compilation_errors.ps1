
$files = Get-ChildItem -Path "lib", "example" -Recurse -Include *.dart
foreach ($file in $files) {
      if ($file.FullName -match "\\.antigravity" -or $file.Name -match ".*\.ps1") { continue }
    
      $content = Get-Content $file.FullName -Raw
      $originalContent = $content
    
      # 1. Fix Flow Control Keywords
      $content = $content -creplace "\bFDSwitch\b", "switch"
    
      # 2. Fix Enum Values & CSS Strings (FDCenter -> center in specific contexts)
      $content = $content -creplace "TextAlign.FDCenter", "TextAlign.center"
      $content = $content -creplace "Alignment.FDCenter", "Alignment.center"
      $content = $content -creplace "MainAxisAlignment.FDCenter", "MainAxisAlignment.center"
      $content = $content -creplace "CrossAxisAlignment.FDCenter", "CrossAxisAlignment.center"
      $content = $content -creplace "return 'FDCenter'", "return 'center'"
      $content = $content -creplace "'FDCenter'", "'center'" # CSS value usually
    
      # 3. Fix Text variable/property names (Restoring 'text' where it was variable name)
      # Be careful NOT to change "class FDText" or "new FDText" or "FDText("
    
      # Variable declarations
      $content = $content -creplace "final String FDText", "final String text"
      $content = $content -creplace "final String\? FDText", "final String? text"
    
      # Constructor parameters
      $content = $content -creplace "this.FDText", "this.text"
    
      # Named arguments usage
      $content = $content -creplace "FDText:", "text:"
    
      # Property access (controller.FDText -> controller.text)
      $content = $content -creplace "\.FDText", ".text"
    
      # 4. Fix String literals that define types or CSS
      $content = $content -creplace "'FDText'", "'text'" 
      $content = $content -creplace '"FDText"', '"text"'
      $content = $content -creplace "FDText-FDAlign", "text-align"
      $content = $content -creplace "FDText-Align", "text-align"
    
      # 5. Fix HTML Element property
      $content = $content -creplace "element.FDText", "element.text"

      if ($content -ne $originalContent) {
            Set-Content $file.FullName -Value $content -Encoding UTF8
            Write-Host "Fixed compilation errors in $($file.Name)"
      }
}
