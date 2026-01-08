
$files = Get-ChildItem -Path "lib", "example" -Recurse -Include *.dart
Write-Host "Processing $($files.Count) files"
foreach ($file in $files) {
      $content = Get-Content $file.FullName -Raw
      $originalContent = $content
    
      $content = $content -creplace "Switch \(", "switch ("
      $content = $content -creplace "Text-Align", "text-align"
      $content = $content -creplace "Align-items", "align-items"
      $content = $content -creplace "'Row'", "'row'"
      $content = $content -creplace "'Column'", "'column'"
      $content = $content -creplace "'Center'", "'center'"
      $content = $content -creplace "\.Center", ".center"
      $content = $content -creplace "bottomcenter", "bottomCenter"
      $content = $content -creplace "MainAxisAlignment.Center", "MainAxisAlignment.center"
      $content = $content -creplace "CrossAxisAlignment.Center", "CrossAxisAlignment.center"
    
      # Also fix Definition in Enum files?
      # "  Center," -> "  center,"
      # Need to be specific to avoid breaking something else?
      # Actually, if I change usage to lowercase, definition MUST be lowercase.
      $content = $content -creplace "\bCenter,", "center,"

      if ($content -ne $originalContent) {
            Set-Content $file.FullName -Value $content -Encoding UTF8
            Write-Host "Fixed $($file.Name)"
      }
}
