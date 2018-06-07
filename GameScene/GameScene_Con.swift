//
//  GameScene_Con.swift
//  SeisWave
//
//  Created by Jianhang Yin on 4/16/18.
//  Copyright © 2018 Jianhang. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene_Con: SKScene {
    
    var continueLabel = SKLabelNode(fontNamed: "RussoOne-Regular")
    let cheerSound = SKAction.playSoundFileNamed("cheer.wav", waitForCompletion: false)

    
    override func didMove(to view: SKView) {
        
        initialization()
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        continuegame(touches: touches)
    }
    
    func initialization() {
        
        let backGround = SKSpriteNode(imageNamed: "background_con")
        backGround.name = "BackgroundCon"
        backGround.size = self.size
        backGround.position = CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.5)
        backGround.zPosition = 1
        backGround.alpha = 0
        self.addChild(backGround)
        let backgroundFadeIn = SKAction.fadeIn(withDuration: 0.5)
        let backgroundSequence = SKAction.sequence([cheerSound, backgroundFadeIn])
        backGround.run(backgroundSequence)
        
        continueLabel.text = "CONTINUE"
        continueLabel.fontSize = 150
        continueLabel.fontColor = SKColor.white
        continueLabel.position = CGPoint(x: self.size.width / 2, y: self.size.height * 0.15)
        continueLabel.zPosition = 2
        continueLabel.alpha = 0
        self.addChild(continueLabel)
        let continueFadeIn = SKAction.fadeIn(withDuration: 2)
        let continueSequence = SKAction.sequence([continueFadeIn])
        continueLabel.run(continueSequence)
        
    }

    func continuegame(touches: Set<UITouch>) {
        
        for touch in touches {
            let location = touch.location(in: self)
            if continueLabel.contains(location) {
                changeScene()
            }
        }
        
    }
    
    func changeScene() {
        let targetscene = GameScene_Room(size: self.size)
        targetscene.scaleMode = self.scaleMode
        let scenetransition = SKTransition.fade(withDuration: 0.2)
        self.view!.presentScene(targetscene, transition: scenetransition)
        view?.showsPhysics = false
    }
}
















