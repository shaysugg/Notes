## LaunchEffect and SideEffect
`launchEffect` when you need to perform side effects that are **dependent on the lifecycle of the composition**, such as setting up or tearing down resources.
Use `sideEffect` when you need to perform side effects that are **independent of the lifecycle of the composition**, such as updating external state or triggering events.
They both **executed after the initial composition and any subsequent recompositions.**