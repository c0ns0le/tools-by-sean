$versions = '3.8.0','2.2.0','1.7.0','1.2.9'
$jsonFile = ".\monikerMapping-azurermps.json"
$map = [ordered]@{}

foreach ($version in $versions) {
  $modMap = @{}

  $modules = dir c:\temp\psgallery\azurerm-$version -inc *.psd1 -rec |
               where {$_.name -notlike '*.dll-help.psd1' -and $_.name -ne 'AzureRM.psd1'} |
                 %{ get-module $_ -list } | sort name | select -uni Name,Version

  $modules | %{
    if (!$modMap.ContainsKey($_.Name)) {
      $modMap.Add($_.Name,([ordered]@{_displayName=$_.name;_version=$_.version.tostring()}))
    }
  }

  $map.Add("azurermps-$version",@{'azure-docs-powershell/azureps-cmdlets-docs/ResourceManager'=$modMap})
}
$map | ConvertTo-Json -Depth 4 | Out-File $jsonFile -Force -Encoding ascii
