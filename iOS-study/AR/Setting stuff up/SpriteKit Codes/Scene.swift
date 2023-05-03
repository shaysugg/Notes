//
//  Scene.swift
//  EmojiPop
//
//  Created by Shayan on 2/6/1402 AP.
//

import SpriteKit
import ARKit

public enum GameState {
    case Init
    case TapToStart
    case Playing
    case GameOver
}

class Scene: SKScene {
    
    var gameState = GameState.Init
    var anchor: ARAnchor?
    var emojis = "😃🥲😬🥹🤨🥰🤪🥸🤨😗"
    var spawnTime : TimeInterval = 0
    var score : Int = 0
    var lives : Int = 10
    
    override func didMove(to view: SKView) {
        startGame()
    }
    
    override func update(_ currentTime: TimeInterval) {
        if gameState != .Playing { return }
        if spawnTime == 0 { spawnTime = currentTime + 3 }
        if spawnTime < currentTime {
            spawnEmoji()
            spawnTime = currentTime + 0.5
        }
        updateHUD("SCORE: " + String(score) + "LIVES: " + String(lives))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        switch gameState {
        case .Init:
            break
        case .TapToStart:
            playGame()
            break
        case .Playing:
            checkTouches(touches)
            break
        case .GameOver:
            startGame()
            break
        }
    }
    
    func startGame() {
        gameState = .TapToStart
        updateHUD("TAP TO START")
        removeAnchor()
    }
    
    func playGame() {
        gameState = .Playing
        score = 0
        lives = 10
        spawnTime = 0
        addAnchor()
    }
    
    func stopGame() {
        gameState = .GameOver
        updateHUD("GAME OVER! SCORE: \(score)")
    }
    
    func addAnchor() {
        guard let sceneView = self.view as? ARSKView else { return }
        if let currentFrame = sceneView.session.currentFrame {
            var tranlation = matrix_identity_float4x4
            tranlation.columns.3.z = -0.5
            let transform = simd_mul(currentFrame.camera.transform, tranlation)
            anchor = ARAnchor(transform: transform)
            sceneView.session.add(anchor: anchor!)
        }
    }
    
    func removeAnchor() {
        guard let sceneView = self.view as? ARSKView else { return }
        if let _ = anchor {
            sceneView.session.remove(anchor: anchor!)
        }
        
    }
    
    func updateHUD(_ message: String) {
        guard let sceneView = self.view as? ARSKView else { return }
        let viewController = sceneView.delegate as! ViewController
        viewController.hudLabel.text = message
    }
    
    func spawnEmoji() {
        let emojiNode = SKLabelNode(text: String(emojis.randomElement()!))
        emojiNode.name = "Emoji"
        emojiNode.horizontalAlignmentMode = .center
        emojiNode.verticalAlignmentMode = .center
        
        guard let sceneView = self.view as? ARSKView else { return }
        sceneView.scene?.childNode(withName: "SpawnPoint")?.addChild(emojiNode)
        
        emojiNode.physicsBody = SKPhysicsBody(circleOfRadius: 15)
        emojiNode.physicsBody?.mass = 0.01
        emojiNode.physicsBody?.applyImpulse(CGVector(dx: -5 + 10 * randomCGFloat(), dy: 10 ))
        emojiNode.physicsBody?.applyTorque(-0.2 + 0.4 * randomCGFloat())
        
        let spawnSoundAction = SKAction.playSoundFileNamed("SoundEffects/Spawn.wav", waitForCompletion: false)
        let dieSoundAction = SKAction.playSoundFileNamed("SoundEffects/Die.wav", waitForCompletion: false)
        let waitAction = SKAction.wait(forDuration: 3)
        let removeAction = SKAction.removeFromParent()
        
        let runAction = SKAction.run { [unowned self] in
            self.lives -= 1
            if self.lives <= 0 {
                self.stopGame()
            }
        }
        
        let actions = SKAction.sequence([spawnSoundAction, waitAction, dieSoundAction, runAction, removeAction])
        emojiNode.run(actions)
        
    }
    
    func checkTouches(_ touches: Set<UITouch>) {
        guard let touch = touches.first else { return }
        let touchedLocation = touch.location(in: self)
        let touchedNode = self.atPoint(touchedLocation)
        if touchedNode.name == "Emoji" {
            score += 1
            let collectedSound = SKAction.playSoundFileNamed("SoundEffects/Collect.wav", waitForCompletion: false)
            let removeAction = SKAction.removeFromParent()
            let actions = SKAction.sequence([collectedSound, removeAction])
            touchedNode.run(actions)
        }
    }
    
    func randomCGFloat() -> CGFloat {
        CGFloat(Float(arc4random()) / Float(UINT32_MAX))
    }
}
