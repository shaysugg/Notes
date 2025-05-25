## Thinking in compose
When you recalculate the UI element based on state changes it's called Recomposition.
> Recomposition is the process of calling your composable functions again when inputs change

Recomposition skips as much as possible:
which means only part of the UI that the state change will effect will be recomposed.

Composable functions might run quite frequently
Avoid having expensive tasks in them. In animations they may be called on each frames.

Composable functions could be run in ==parallel==
To ensure your application behaves correctly, all composable functions should have no side-effects. Instead, trigger side-effects from callback

Composable functions can execute in any order
No guarantee that `StartScreen` called before `MiddleScreen` 
```Kotlin
@Composable
fun ButtonRow() {
    MyFancyNavigation {
        StartScreen()
        MiddleScreen()
        EndScreen()
    }
}
```
## Building for adaptive apps
Have dynamic UI based on window size
```Kotlin
val windowSizeClass = currentWindowAdaptiveInfo().windowSizeClass
```
## Using keys
In list of items in widget tree if we want to reduce recompositions and identified each element with an ID we can use key
```Kotlin
@Composable
fun MoviesScreenLazy(movies: List<Movie>) {
    LazyColumn {
        items(movies, key = { movie -> movie.id }) { movie ->
            MovieOverview(movie)
        }
    }
}
```
In the above example if list of movie is changed, let's say an item was inserted at the beginning of the list only the view related to that item will be recomposed, whereas if the associated ids don't exist all the items will be recomposed.
## Side-effects
A **side-effect** is a change to the state of the app that happens outside the scope of a composable function.
composable s should ideally be side-effect free.

 However there are times that is needed to have some side effects in compose functions. Make sure they are **UI related and doesn't break unidirectional data flow.**
 
 `LaunchedEffect`
 For running suspend functions.
 There is an associated key with Launch effect that will cancel and rerun its block.
 ```Kotlin
var pulseRateMs by remember { mutableStateOf(3000L) }
val alpha = remember { Animatable(1f) }

// Restart the effect when the pulse rate changes
LaunchedEffect(pulseRateMs) { 
    while (isActive) {
        delay(pulseRateMs)
        alpha.animateTo(0f)
        alpha.animateTo(1f)
    }
}
```

`rememberCoroutineScope`
Launched Effect can only be used inside of other composable functions. In order to scope other functions like a button on click rememberCoroutineScope is being used.
```Kotlin
@Composable
fun MoviesScreen(snackbarHostState: SnackbarHostState) {
    val scope = rememberCoroutineScope()
    
//...
            Button(onClick = {
                    scope.launch {
                    snackbarHostState.showSnackbar("Something happened!")
                    }}) { Text("Press me")}
        }
    }
}
```

`rememberUpdatedState`
Launched Effect restarts when its key changes. for preventing restarts we can wrap the function that it executes inside rememberUpdatedState
```Kotlin
@Composable
fun LandingScreen(onTimeout: () -> Unit) {
    val currentOnTimeout by rememberUpdatedState(onTimeout)
    LaunchedEffect(true) {
        delay(SplashWaitTimeMillis)
        currentOnTimeout()
    }
}
```

Other side effect handling solutions explained [here](https://developer.android.com/develop/ui/compose/side-effects#state-effect-use-cases)
## Phases of frame
Each frame contains three phases
1) composition: forming the widget tree
2) layout: where to place each elements
3) drawing: how render elements
![[compose-phases.png]]
## State Hoisting
A compose pattern to make the composable stateless.
- **`value: T`:** the current value to display
- **`onValueChange: (T) -> Unit`:** an event that requests the value to change, where `T` is the proposed new value
## Saving state
* Use `remembersavble` instead of remember to retain state across activities
* It only works with primitive types, if you want to store a class type apply `@parcelize` on the class to make it restorable.
* `remembersavble` stores properties in bundle. The size of the bundle is limited, avoid storing large objects with it.

TODO: more on it later ....
## Compositional Local
for having a value in a tree structure without needing to explicitly inject it in each view
Providing:
```Kotlin
data class Elevations(val card: Dp = 0.dp, val default: Dp = 0.dp)

val LocalElevations = compositionLocalOf { Elevations() }

class MyActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {


	CompositionLocalProvider(LocalElevations provides elevations) {
	//content
	}
    }
```
consuming:
```Kotlin
MyCard(elevation = LocalElevations.current.card) {
```
## Navigation
A small example:
```Kotlin

@Serializable
data class Profile(val name: String)
@Serializable
object FriendsList


@Composablefun MyApp() {
val navController = rememberNavController()  
NavHost(navController, startDestination = Profile(name = "John Smith")) {
composable<Profile> { backStackEntry ->
val profile: Profile = backStackEntry.toRoute()        ProfileScreen(profile = profile,            onNavigateToFriendsList = {                navController.navigate(route = FriendsList)            }        )    
}  
composable<FriendsList> {
FriendsListScreen(onNavigateToProfile = {          
navController.navigate(route = Profile(name = "Aisha Devi")      )})}}}
```