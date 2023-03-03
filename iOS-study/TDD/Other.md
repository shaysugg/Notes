If we want to test something only on simulator
```Swift
“#if targetEnvironment(simulator)
return SimulatorPedometer()
#else
return CMPedometer()
#endif”

```