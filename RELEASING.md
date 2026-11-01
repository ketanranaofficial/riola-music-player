# Releasing Riola

Everything here is a one-off setup plus one command. `build.sh` does the rest.

## 1. Make a release key

Do this once, and keep the file and its password safe. Android only installs an
update if it is signed with the same key as the version already on the phone, so
losing the key means everyone who installed Riola has to uninstall it (and lose
their programs) to get the next version. It is also the key you would upload to
Play, which can never be changed.

```bash
mkdir -p ~/keys && chmod 700 ~/keys
keytool -genkeypair -v \
  -keystore ~/keys/riola-release.jks \
  -alias riola \
  -keyalg RSA -keysize 4096 -validity 10000 \
  -dname "CN=Your Name, O=Riola, C=IN"
chmod 600 ~/keys/riola-release.jks
```

It asks for a password; choose a long one. The file, that password and the alias
(`riola`) are all needed to sign an update, so keep two copies of the file (a USB
stick and an encrypted cloud copy, say) and the password in a password manager.

Keep `riola-release.jks` **out of the repository**. It is already covered by
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
./build.sh --clean --release \
  --keystore ~/keys/riola-release.jks \
  --alias riola \
  --version-code 7 --version-name "1.3"
```

It asks for the keystore password in the terminal, with nothing echoed and nothing
left in your shell history. (For a script, set `RIOLA_STOREPASS` in the environment
instead and it will not ask.) Whichever shell you use, run it as a normal command; if
yours is fish, the same line works as it is.

`--version-code` must increase with every upload. `--version-name` is what people
see. The result is `build/riola.apk`, signed with your key and verified by
`apksigner`. Check which key signed it with
`apksigner verify --print-certs build/riola.apk`, and publish that certificate
fingerprint next to the release so people can check theirs.

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
