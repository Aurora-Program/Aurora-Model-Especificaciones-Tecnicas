param(
    [string]$Folder = (Split-Path -Parent $MyInvocation.MyCommand.Path),
    [string]$OutputFile = "completo.md"
)

$OutputPath = Join-Path $Folder $OutputFile

$Files = Get-ChildItem -Path $Folder -Filter "*.md" -File |
    Where-Object { $_.Name -ne $OutputFile } |
    Sort-Object @{
        Expression = {
            if ($_.BaseName -match '^(\d+)') { [int]$Matches[1] } else { [int]::MaxValue }
        }
    }, @{
        Expression = { $_.Name.ToLowerInvariant() }
    }

if ($Files.Count -eq 0) {
    Set-Content -Path $OutputPath -Value "" -Encoding UTF8
    Write-Host "No se encontraron archivos .md para concatenar."
    exit 0
}

$Builder = New-Object System.Text.StringBuilder
[void]$Builder.AppendLine("# Documento Completo")
[void]$Builder.AppendLine("")

foreach ($File in $Files) {
    [void]$Builder.AppendLine("---")
    [void]$Builder.AppendLine("")
    [void]$Builder.AppendLine("## " + $File.Name)
    [void]$Builder.AppendLine("")

    $Content = Get-Content -Path $File.FullName -Raw -Encoding UTF8
    [void]$Builder.AppendLine($Content)
    [void]$Builder.AppendLine("")
}

[System.IO.File]::WriteAllText($OutputPath, $Builder.ToString(), [System.Text.UTF8Encoding]::new($true))
Write-Host "Archivo generado: $OutputPath"
