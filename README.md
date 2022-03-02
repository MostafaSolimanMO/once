# once

Want to run/show a piece of code/widget once (Once - Hourly - Daily - Weekly - Monthly - Every new version - Any custom duration)? We cove your back.  

----
Some things should happen **once**.
* Users should only get the guided tour _once_.
* Release notes should only pop up _once every new app version comes_.
* Etc.. _once every (Whatever you want)_.

`Once` supports `runOnce`, `runOnEveryNewVersion`, `runEvery12Hours`, `runHourly`, `runDaily`, `runOnNewDay`, `runWeekly`, `runMonthly`, `runOnNewMonth`, `runYearly` and `runCustom`.

Some widgets should show **once**.
* Users should only get this alert _OnceWidget_.
* Hello it new version widget shows _OnceWidget every new app version comes_.
* Etc.. _OnceWidget every (Whatever you want)_.

`OnceWidgets` supports `showOnce`, `showOnEveryNewVersion`, `showEvery12Hours`, `showHourly`, `showDaily`, `showOnNewDay`, `showWeekly`, `showMonthly`, `showOnNewMonth`, `showYearly` and `showCustom`.

# Usage

## Once

**Mainly runner functions consists of callbacks and fallbacks**
* `callback` is the generic function that runs and returns a `future<T?>` . 
* `fallback` is the same but only runs in case that callback future returns null.

Now you're ready to go. Say you wanted to show the new features dialog when new version of the app come:

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

Or maybe you want to show the rate this app dialog weekly:
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

## OnceWidget

**Mainly builder functions consists of builders and fallbacks**
* `builder` is the generic function that shows and returns a `Widget` .
* `fallback` is the same but only shows in case that callback future returns null (defaults to `SizedBox.shrink()`).

Now you're ready to go. Say you wanted to view a banner widget when the app is updated:

```dart
OnceWidget.showOnEveryNewVersion(
  builder: () {
   return Container(...);
  },
);
```

Or maybe you want to show the hello new week widget weekly:
```dart
OnceWidget.showWeekly("weekWidget",
  builder: () {
     return Text('Hello, New Week');
   },
  fallback: () {
     return Text('Hello!');
   },
);

```
## Contributors
* [Mostafa Soliman](https://github.com/MostafaSolimanMO)
* [Nour Magdi](https://github.com/SPiercer)


inspired by the java library [Once](https://github.com/jonfinerty/Once) made by [Jon Finerty](https://github.com/jonfinerty)
