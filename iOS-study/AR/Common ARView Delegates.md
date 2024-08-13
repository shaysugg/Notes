## ARSceneView Delegates
* When an anchor-usually floor or walls or person body- is updated and you want to do something
```swift
func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor)
```
* When an anchor is recognized and is added to the scene. You probably want to add nodes that are related to the anchor.
```swift
func session(_ session: ARSession, didAdd anchors: [ARAnchor])
```

## ARSessionDelegate
* If you want to constantly update something on each frame. More like a game loop.
```swift
func session(_ session: ARSession, didUpdate frame: ARFrame)
```