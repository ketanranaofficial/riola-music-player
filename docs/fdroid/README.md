# F-Droid submission notes

- Store text, icon, screenshots and changelogs live in `fastlane/metadata/android/en-US/`,
  which F-Droid reads straight from the repository. Add `changelogs/<versionCode>.txt`
  for each release.
- `com.riola.player.yml` is the draft build recipe. To submit: fork
  https://gitlab.com/fdroid/fdroiddata, copy it to `metadata/com.riola.player.yml`,
  and open a merge request.
- Two builds from clean checkouts differ only in the APK signing block, never in the
  contents, so a reproducible build (signature copied from the release APK) should work.
