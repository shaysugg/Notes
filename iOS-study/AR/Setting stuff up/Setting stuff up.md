## RealityKit
* Drag an reality kit view to the main storyboard.
* load your anchor.
	```Swift
	let anchor = try! myAnchor.load_myAnchor()
	```
* Add it to scene.
	``` Swift
	arView.scene.anchors.append(anchor)
	```

## SpriteKit
* Drag an AR SpriteKit view to the main storyboard.
* Conform to its the delegate (`ARSKViewDelegate`).
* In `viewWillAppear` run the sceneView session with a `configuration`. ([[AR Different Configurations]])
* We can use `nodeFor` to assign our custom node for the given anchors like that
``` Swift
/// assigning an emoji text node to the anchor
func view(_ view: ARSKView, nodeFor anchor: ARAnchor) -> SKNode? {
	let spawnNode = SKNode()
	spawnNode.name = "SpawnPoint"
	
	let boxNode = SKLabelNode(text: "🆘")
	boxNode.verticalAlignmentMode = .center
	boxNode.horizontalAlignmentMode = .center
	boxNode.zPosition = 100
	boxNode.setScale(0)
	
	spawnNode.addChild(boxNode)
	return spawnNode
}
```
* We can use this functions to configure the Scene programatically.
``` Swift
override func didMove(to view: SKView) {
	//the initial function
}

override func update(_ currentTime: TimeInterval) {
// update and define our behaviours here
// getting called 60fps
}

override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
// make our experience interactive by using the 
let touchedLocation = touch.location(in: self)
let touchedNode = self.atPoint(touchedLocation)
}
```
### Notes
* We can add **actions** (making sound, transform) to our nodes. we can also add array of these actions as an action
```Swift
let soundAction = SKAction.playSoundFileNamed("soundpath/sound.mp3")
let actions = SKAction.sequence([])
Node.run(actions)
```
* We can add **physicsBody** for better interactions. physics body can be rectangle, circle, custom & etc. also we can apply different forces like applyImpulse, applyTorque
``` Swift
node.physicsBody = SKPhysicsBody(circleOfRadius: 15)
node.physicsBody?.mass = 0.01
node.physicsBody?.applyImpulse(CGVector())
node.physicsBody?.applyTorque()
```
* Use `name` to identify anchors and nodes at different places.
## SceneKit
* Drag an AR SceneKit view to the main storyboard.
* Init scene + Conform to its delegate and add our initial node to it.
``` Swift
	let scene = SCNScene()
	sceneView.scene = scene
	sceneView.delegate = self
	let arPortScene = SCNScene(named: "art.scnassets/Scenes/Scene.scn")!
	arPortNode = arPortScene.rootNode.childNode(withName: "Node", recursively: false)
	sceneView.scene.rootNode.addChildNode(arPortNode)
```
* Run the sceneView session with a `configuration`. ([[AR Different Configurations]])
* Use the this SceneView delegate to update our app
``` Swift
func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
}
```
* Use the this SceneView delegate to capture the touches and make app responsive.
``` Swift
override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    let touchLocation = touches.first?.location(in: self.sceneView)
	let hit = self.sceneView.hitTest(touchLocation).first
}
```
### Notes
* **Ray-Casting**: 
> When we call this function, ARKit creates a ray that **extends in the positive z-direction** from the argument screen space point, to determine if any of the argument targets exist in the physical environment anywhere along the ray

``` Swift
let focusPoint = CGPoint(x: 0, y: 10)
if let query = sceneView.raycastQuery(from: focusPoint, allowing: .estimatedPlane, alignment: .horizontal) {
	let result = sceneView.session.raycast(query)
}
```
* `ARCoachingOverlayView` can be used to guide the user for setting up the AR environment.