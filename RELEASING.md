# Releasing Riola

Everything here is a one-off setup plus one command. `build.sh` does the rest.

## 1. Make an upload key

Do this once, and keep the file and its passwords safe — losing them means you
can never update the app on Play again.

```bash
keytool -genkeypair -v \
  -keystore riola-upload.jks \
  -alias riola \
  -keyalg RSA -keysize 4096 -validity 10000 \
  -dname "CN=Your Name, O=Riola, C=IN"
```

Keep `riola-upload.jks` **out of the repository**. It is already covered by
`.gitignore` (`*.jks`, `*.keystore`).

## 2. Target a current API level

Google Play requires new apps to target a recent Android version, and raises
the bar every August. The build targets the newest platform installed in your
SDK, so this is just a download:

```bash
sdkmanager "platforms;android-36"
```

Then check what the build picked up — it prints `target sdk   : NN`
near the top. To pin it explicitly, pass `--target-sdk 36`.

Riola's `minSdkVersion` is 26 (Android 8.0), which covers effectively every
phone still in use.

## 3. Build a signed release

```bash
export RIOLA_STOREPASS="..."

./build.sh --clean --release \
  --keystore ~/keys/riola-upload.jks \
  --alias riola \
  --version-code 6 --version-name "1.2"
```

`--version-code` must increase with every upload. `--version-name` is what people
see. The result is `build/riola.apk`, signed with your key and verified by
`apksigner`.

For Play specifically you will want an **App Bundle** (`.aab`) rather than an
APK. That needs `bundletool`, and it is the one part of this pipeline that
Gradle would normally do for you; the APK is fine for GitHub releases, F-Droid
style distribution and sideloading.

## 4. What Play asks for

- **Privacy policy URL** — publish `PRIVACY.md` somewhere public (GitHub Pages
  works) and give Play that link.
- **Data safety form** — answer "no data collected". Riola has no internet
  permission, so this is honest and easy.
- **Content rating questionnaire** — everyone / no sensitive content.
- **Store listing** — short description, full description, and graphics:
  - App icon, 512 × 512 PNG (`docs/icon-512.png` is ready)
  - Feature graphic, 1024 × 500
  - At least two phone screenshots (there are some in `docs/`)
- **Target audience** — not designed for children, to avoid the Families
  policy requirements.

Riola has no ads, no purchases, no accounts and no network access, which
removes most of the awkward questions.

## 5. GitHub release

```bash
gh release create v1.0 build/riola.apk \
  --title "Riola 1.0" \
  --notes "First public release."
```

Anyone can then sideload it. Mention in the notes that the APK is signed with
your key and that Android will warn about installing from outside the store —
that is normal and expected.

## Checklist before you publish

- [ ] `--release` build with your own key, not the debug key
- [ ] `--version-code` higher than anything published before
- [ ] Targeting a current API level
- [ ] Privacy policy live at a public URL
- [ ] Screenshots refreshed if the UI changed
- [ ] Installed the built APK on a real phone and run a program end to end
