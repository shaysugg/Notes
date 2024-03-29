[Original Article](https://www.manu.show/2023-08-18-improve-build-times-in-spm-packages-and-in-your-apps/)

## Measure the build times
### Build with Timing Summary
Use `Product Menu -> Perform Action -> Build With Timing Summary` to build the project and then navigate to report navigator (last tab on the right menu)
### Build with Recent Timeline
Select a recent build and go to `Editor -> Assistant`. This timeline view provides a visual representation of build processes and times.
## Show warning for code that takes so long to build
1. Select your target project
2. Go to the `Build Settings` tab.
3. Select the `All` sub tab.
4. Filter `Other Swift Flags`.
5. Add the following:
```
-Xfrontend -warn-long-function-bodies=<milliseconds>
-Xfrontend -warn-long-expression-type-checking=<milliseconds>
```
*`<milisecondes>` can be any value but 50 is good for the most of the cases*
* We can use same script for the SPMs
```
.target(
    name: "BuildTimesPackage",
    dependencies: [],
    swiftSettings: [
        .unsafeFlags([
            "-Xfrontend",
            "-warn-long-function-bodies=50",
            "-Xfrontend",
            "-warn-long-expression-type-checking=50"
        ])
    ]
),
```
