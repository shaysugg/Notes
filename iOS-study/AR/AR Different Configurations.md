## Different Configurations
1.  `ARWorldTrackingConfiguration`: This is the most robust AR configuration and provides high-quality AR experiences with six degrees of freedom (6DoF) tracking. It uses the device's camera and sensors to track the position and orientation of the device in 3D space, enabling realistic virtual object placement, and real-world object occlusion.
    
2.  `ARImageTrackingConfiguration`: This configuration allows you to detect and track 2D images, such as posters or product packaging. When the device's camera detects a recognized image, it can display virtual content on top of the image.
    
3.  `ARObjectScanningConfiguration`: This configuration enables the user to scan real-world objects and create 3D models from them. It uses the device's camera to capture multiple images of the object from different angles, which are then used to generate a 3D mesh.
    
4.  `ARBodyTrackingConfiguration`: This configuration enables full-body tracking, allowing you to detect and track the movements and poses of a person in real-time. It uses the device's camera and machine learning algorithms to recognize and track the human body.
    
5.  `ARFaceTrackingConfiguration`: This configuration enables you to track the movements and expressions of a user's face. It uses the device's front-facing camera to capture facial expressions, which can then be used to animate a 3D avatar or apply virtual effects to the user's face.

## How to run a specific config
```swift
let config = ARWorldTrackingConfiguration()
config.frameSemantics = .personSegmentation
config.planeDetection = .horizontal
//...
session.run(configuration: config)
```