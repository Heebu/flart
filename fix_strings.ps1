
$files = Get-ChildItem -Path "lib", "example" -Recurse -Include *.dart
foreach ($file in $files) {
      if ($file.FullName -match "\\.antigravity" -or $file.Name -match "fix_.*\.ps1") { continue }
    
      $content = Get-Content $file.FullName -Raw
      $originalContent = $content
    
      # CSS Property Values
      $content = $content -creplace ":\s*FDCenter\b", ": center"
      $content = $content -creplace ":\s*FDColumn\b", ": column"
      $content = $content -creplace ":\s*FDRow\b", ": row"
      $content = $content -creplace "no-repeat FDCenter", "no-repeat center"
    
      # CSS Property Names
      $content = $content -creplace "FDAlign-items", "align-items"
      $content = $content -creplace "FDText-FDAlign", "text-align"
    
      # Just in case "return 'FDCenter'" was missed
      $content = $content -creplace "return 'FDCenter'", "return 'center'"
    
      if ($content -ne $originalContent) {
            Set-Content $file.FullName -Value $content -Encoding UTF8
            Write-Host "Fixed strings in $($file.Name)"
      }
}
