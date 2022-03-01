## 1.0.0

* initial release.

## 2.0.0

* all periodic functions now are returning a nullable generic typed Future `Future<T?>`
* you can now use `FutureBuilder` to return a widget from `once` like so 
  * ```dart
    FutureBuilder<Widget?>(
        future: Once.runDaily<Widget?>(
            "MyKey",
            (){/* handling the callback to return a [Widget] or [null] */},
        ),
        builder: (_, snapshot) {
            if (snapshot.hasData) {
                return snapshot.data!;
            } else {
                /* handling a fallback widget if [myNullableWidget] returns null */
            }
        },
    )
    ```