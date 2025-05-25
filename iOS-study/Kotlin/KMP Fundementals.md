[Get Started Docs](https://www.jetbrains.com/help/kotlin-multiplatform-dev/multiplatform-create-first-app.html)
[SKEI](https://skie.touchlab.co/features/#enums)
[Useful Packages](https://github.com/terrakok/kmp-awesome?tab=readme-ov-file#-serializer)
[Material Theme Builder](https://material-foundation.github.io/material-theme-builder/)
[Compose](https://developer.android.com/develop/ui/compose)
## Project Structure
* Shared code:
	* commonMain:
		* Pure shared code (Only accepts Kotlin and kotlin multi-platform packages)
		* Declaration of platform specifics code (`interface`, `expect fun`)
	* `iosMain`
		* iOS Platform specific code (implementations of interfaces)
	* Android Main
		*  Android Platform specific code (implementations of interfaces)
	* `build.gradle.kts`
			share code build configs (dependencies, plugins, versions)
* ProjectNameAndroid
		Android UI and application logic
* ProjectNameiOS 
		iOS UI and application logic
## Platform Code
For writing platform specific code declare the general interface in commonMain like
```Kotlin
interface Platform {  
    val name: String  
}  
  
expect fun getPlatform(): Platform
```
Implement it in iOSMain and AndroidMain like
```Kotlin
//iOSMain file
import platform.UIKit.UIDevice

class IOSPlatform: Platform {  
    override val name: String = UIDevice.currentDevice.systemName() + " " + UIDevice.currentDevice.systemVersion  
}  
  
actual fun getPlatform(): Platform = IOSPlatform()
```
## Data classes + json models
Data classes are like structs. They have methods like copy and equability can be checked based on the data that they stored
In order to make them be parsable from json add serialization in plugins in `build.gradle.kts`:
```kotlin
plugins {
kotlin("plugin.serialization") version "2.0.0"
}
```
Add the json serialization support to a data class
```kotlin
@Serializable  
data class RocketLaunch(  
    @SerialName("flight_number")  
    val flightName: Int,  
    @SerialName("name")  
    val missionName: String,  
    @SerialName("date_utc")  
    val launchDateUTC: String,  
    @SerialName("success")  
    val launchSuccess: Boolean,  
)
```
## Throws
errors in kotlin can remain unchecked while in swift they all had to be checked. To inform swift that a function throws we use
```kotlin
@Throws(Exception::class)
suspend fun hello(): String {}

```