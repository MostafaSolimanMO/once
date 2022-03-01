# once

### For Once widgets use [flutter_once](https://pub.dev/packages/flutter_once)

Want to run a piece of code once (Once - Hourly - Daily - Weekly - Monthly - Every new version - Any  custom duration)? We cove your back.  

----

Some things should happen **once**.
* Users should only get the guided tour _once_.
* Release notes should only pop up _once every new app version comes_.
* Etc.. _once every (Whatever you want)_.

`Once` supports `runOnce`, `runOnEveryNewVersion`, `runEvery12Hours`, `runHourly`, `runDaily`, `runWeekly`, `runMonthly`, `runOnNewMonth`, `runYearly` and `Custom (Duration)`.

## Usage

**Mainly runner functions consists of callbacks and fallbacks**
* `callback` are the generic functions that run and returns a `future<T?>` . 
* `fallback` are the same but only runs in case if that callback future returns null.

Now you're ready to go. Say you wanted to show the new features dialog when the app is updated:

```dart
Once.runOnEveryNewVersion(
  callback: () {
    /* What's new in 2.3.2 version? dialog */
  },
  fallback: () {
   /* Navigate to new screen */
  },
);
```

Or maybe you want to show the rate this app dialog every week for the user:
```dart
if (!rated) {
  Once.runWeekly("ratingDialog",
    callback: () { 
       /* Like our app, Please rate us. dialog */ 
    },
    fallback: () {
      /* Thanks */
    },
  );
}
```

## Contributors
* [Mostafa Soliman](https://github.com/MostafaSolimanMO)
* [Nour Magdi](https://github.com/SPiercer)


inspired by the java library [Once](https://github.com/jonfinerty/Once) made by [Jon Finerty](https://github.com/jonfinerty)
