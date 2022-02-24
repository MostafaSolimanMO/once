# once

Want to run a piece of code once (Once - Hourly - Daily - Weekly - Monthly - Every new vetsion - Any Custom duration)? We got your back.

----

Some things should happen **once**.
* Users should only get the guided tour _once_. 
* Release notes should only pop up _once every mew app version come_. 
* Your app should only phone home to update content _once every hour_.
* Etc.. _once every (What ever you want)_.

`Once` supports `runOnce`, `runOnEveryNewVersion`, `runEvery12Hours`, `runHourly`, `runDaily`, `runWeekly`, `runMonthly`, `runOnNewMonth`, `runYearly` and `Custom (Duration)`.

## Usage
### Done on the time that you want the thing to be _done_

Now you're ready to go. Say you wanted to show the new features dialog when the app is updated: 

```dart
Once.runOnEveryNewVersion(() {
    /* What's new in 2.3.2 version? dialog */
});
```

Or maybe you want to show the rate this app dialog every week for the user:
```dart
if (!rated){
  Once.runWeekly("ratingDialog",() { 
    /* Like our app, Please rate us. dialog */ 
  });
}
```

## Contributors
* [Mostafa Soliman](https://github.com/MostafaSolimanMO)
* [Nour Magdi](https://github.com/SPiercer)


inspired by the java library [Once](https://github.com/jonfinerty/Once) made by [Jon Finerty](https://github.com/jonfinerty)