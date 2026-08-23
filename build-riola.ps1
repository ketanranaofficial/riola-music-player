param(
    [string]$Dir = ".\riola"
)

$ErrorActionPreference = 'Stop'

function Assert-Exit([string]$Step) {
    if ($LASTEXITCODE -ne 0) { throw "$Step failed (exit code $LASTEXITCODE)." }
}

if (-not $env:ANDROID_HOME -and $env:ANDROID_SDK_ROOT) { $env:ANDROID_HOME = $env:ANDROID_SDK_ROOT }
if (-not $env:ANDROID_HOME) { $env:ANDROID_HOME = "$env:LOCALAPPDATA\Android\Sdk" }
$PlatformJar = Join-Path $env:ANDROID_HOME 'platforms\android-34\android.jar'
if (-not (Test-Path -LiteralPath $PlatformJar)) { throw "android-34 platform not found: $PlatformJar" }
foreach ($tool in @('aapt2', 'javac', 'd8.bat', 'jar.exe', 'zipalign.exe', 'apksigner.bat', 'keytool')) {
    if (-not (Get-Command $tool -ErrorAction SilentlyContinue)) { throw "Required tool '$tool' not found in PATH." }
}

New-Item -ItemType Directory -Force -Path "$Dir\com\example\player" | Out-Null
Push-Location $Dir
try {
    Remove-Item -LiteralPath '.\unaligned.apk', '.\classes.dex', '.\programmable-player.apk', '.\riola.apk' -Force -ErrorAction SilentlyContinue
    Remove-Item -LiteralPath '.\compiled' -Recurse -Force -ErrorAction SilentlyContinue
    Get-ChildItem '.\com\example\player\*.class' -ErrorAction SilentlyContinue | Remove-Item -Force
    Get-ChildItem '.\com\example\player\R.java' -ErrorAction SilentlyContinue | Remove-Item -Force

    # ------------------------------------------------------------------
    # Compile resources (aapt2 compile + link)
    # ------------------------------------------------------------------
    New-Item -ItemType Directory -Force -Path '.\compiled' | Out-Null
    aapt2 compile --dir res -o compiled
    Assert-Exit 'aapt2 compile'

    $flats = Get-ChildItem -Path '.\compiled' -Filter '*.flat' | ForEach-Object { $_.FullName }
    aapt2 link -I $PlatformJar --manifest AndroidManifest.xml --java . -o unaligned.apk $flats
    Assert-Exit 'aapt2 link'

    # ------------------------------------------------------------------
    # Compile Java sources
    # ------------------------------------------------------------------
    javac -source 8 -target 8 -bootclasspath $PlatformJar -nowarn .\com\example\player\*.java
    Assert-Exit 'javac'

    # ------------------------------------------------------------------
    # Dex, package, align, sign
    # ------------------------------------------------------------------
    d8.bat --lib $PlatformJar .\com\example\player\*.class --output .
    Assert-Exit 'd8'

    jar.exe uf unaligned.apk classes.dex
    Assert-Exit 'jar'

    zipalign.exe -f 4 unaligned.apk programmable-player.apk
    Assert-Exit 'zipalign'

    # ------------------------------------------------------------------
    # Debug keystore (generated if missing)
    # ------------------------------------------------------------------
    $Keystore = Join-Path $env:USERPROFILE '.android\debug.keystore'
    if (-not (Test-Path -LiteralPath $Keystore)) {
        New-Item -ItemType Directory -Force -Path (Split-Path $Keystore) | Out-Null
        keytool -genkeypair -keystore $Keystore -alias androiddebugkey -storepass android -keypass android -keyalg RSA -keysize 2048 -validity 10000 -dname 'CN=Android Debug,O=Android,C=US'
        Assert-Exit 'keytool (debug keystore generation)'
    }

    apksigner.bat sign --ks $Keystore --ks-pass pass:android programmable-player.apk
    Assert-Exit 'apksigner sign'

    apksigner.bat verify programmable-player.apk
    Assert-Exit 'apksigner verify'

    $Apk = Join-Path (Get-Location).Path 'programmable-player.apk'
    Write-Host ''
    Write-Host "BUILD OK: $Apk"
    Write-Host "Install:  adb install -r `"$Apk`""
}
finally {
    Pop-Location
}