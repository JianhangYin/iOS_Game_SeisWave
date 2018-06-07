//
//  GameScene_Tut1.swift
//  SeisWave
//
//  Created by Jianhang Yin on 4/16/18.
//  Copyright © 2018 Jianhang. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene_Tut1: SKScene {

    override func didMove(to view: SKView) {
        initialization()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        changeScene()
    }
    
    func initialization() {
        
        let backGround = SKSpriteNode(imageNamed: "background_tut_1")
        backGround.name = "Background"
        backGround.size = self.size
        backGround.position = CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.5)
        backGround.zPosition = 0
        self.addChild(backGround)
        
    }
    
    func changeScene() {
        let targetscene = GameScene_Tut2(size: self.size)
        targetscene.scaleMode = self.scaleMode
        let scenetransition = SKTransition.fade(withDuration: 0.2)
        self.view!.presentScene(targetscene, transition: scenetransition)
        view?.showsPhysics = false
    }
}
