# 1.6.2

- Chore: Updates dependencies `package_info_plus` to `^6.0.0`
- Chore: Updates minimum Dart SDK to `>=3.3.0`

# 1.6.1

- Chore: Update dependencies `package_info_plus` to `^5.0.1`

# 1.6.0

- Feat: Added [runOnEveryNewBuild](https://github.com/MostafaSolimanMO/once/pull/23) Function 
- Fix: `runOnNewVersion` saves version numbers with non-numerical values and does not sanitize them upon retrieval [Issue #24](https://github.com/MostafaSolimanMO/once/issues/24)
- Fix: Types Error in `runner.dart`
- Chore: Update dependencies & example app

# 1.5.4

- fix: [Issue #20](https://github.com/MostafaSolimanMO/once/issues/20)
- chore: update dependencies

# 1.5.3

- fix `runOnNewVersion` callback even on first run

# 1.5.2

- fix: add `uniqueKey` to `runOnNewVersion` to fix runOnEveryNewVersion runs only once even if used
  in multiple pages
- chore: update dependencies

# 1.5.1

- fix: `OnceBuilder.fallback()` is always called at least one time when specified
- chore: update dependencies

# 1.5.0

- fix: `runOnce` & `runEvery12Hours` fallback wasn't working properly
- chore: update dependencies

# 1.4.1

- fix: clear key was missing the prefix

# 1.4.0

- Add Functions
    * `clear` removes the `Once` or `OnceWidget` data for a specific `key`.
    * `clearAll` removes all the `Once` and `OnceWidget` data.

- Add debug parameters that only works in debug mode
    * `debugCallback` used to debug the `callback` function.
    * `debugFallback` used to debug the `fallback` function.

- Add prefix to the `key` to make it unique **No changes required**.

# 1.3.0

- Add `BuildContext` to the `builder` and `fallback` of `WidgetOnce`

# 1.2.1

- ReadMe.md Update

# 1.2.0

- Add `WidgetOnce` that return `Widget`
- Add `runOnNewDay` method that runs on every new day.
  The day here means you run the function at 3:00 AM. So, Day means
  the next 12:00 AM.

# 1.1.2

- Analyzing

# 1.1.0

- Fix bugs
- All periodic functions now are returning a nullable generic typed Future `Future<T?>`
- Add `fallback`  in case if that callback future returns null

# 1.0.0

- initial release.
