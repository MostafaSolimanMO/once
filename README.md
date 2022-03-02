# once

Want to run/show a piece of code/widget once (Once - Hourly - Daily - Weekly - Monthly - Every new version - Any custom duration)? We cove your back.  

----
Some things should happen **once**.
* Users should only get the guided tour _once_.
* Release notes should only pop up _once every new app version comes_.
* Etc.. _once every (Whatever you want)_.

`Once` supports `runOnce`, `runOnEveryNewVersion`, `runEvery12Hours`, `runHourly`, `runDaily`, `runOnNewDay`, `runWeekly`, `runMonthly`, `runOnNewMonth`, `runYearly` and `Custom (Duration)`.

Some widgets should show **once**.
* Users should only get the guided widget _OnceWidget_.
* Release notes widget should only pop up _OnceWidget every new app version comes_.
* Etc.. _OnceWidget every (Whatever you want)_.

`OnceWidgets` supports `showOnce`, `showOnEveryNewVersion`, `showEvery12Hours`, `showHourly`, `showDaily`, `showOnNewDay`, `showWeekly`, `showMonthly`, `showOnNewMonth`, `showYearly` and `Custom (Duration)`.

# Usage

## Once

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

Or maybe you want to show the rate this app dialog every week for the user:
```dart
OnceWidget.showWeekly("ratingDialog",
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
