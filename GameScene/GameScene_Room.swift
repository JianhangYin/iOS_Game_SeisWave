//
//  GameScene_Room.swift
//  SeisWave
//
//  Created by Jianhang Yin on 4/10/18.
//  Copyright © 2018 Jianhang. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene_Room: SKScene {
    
    var moneyLabel = SKLabelNode(fontNamed: "RussoOne-Regular")
    let fieldButton = SKSpriteNode(imageNamed: "fieldbutton")
    let peopleButton = SKSpriteNode(imageNamed: "peoplebutton")

    override func didMove(to view: SKView) {
        
        initialization()
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        entermenu(touches: touches)
    }
    
    func initialization() {
        
        recordData()
        
        let backGround = SKSpriteNode(imageNamed: "background_\(levelRoom)_final")
        backGround.name = "Background"
        backGround.size = self.size
        backGround.position = CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.5)
        backGround.zPosition = 0
        self.addChild(backGround)
        
        fieldButton.name = "Homebutton"
        fieldButton.setScale(1)
        fieldButton.position = CGPoint(x: self.size.width * 0.7, y: self.size.height * 0.75)
        fieldButton.zPosition = 10
        self.addChild(fieldButton)
        let scaleIn = SKAction.scale(to: 1.1, duration: 0.4)
        let scaleOut = SKAction.scale(to: 1, duration: 0.4)
        let scaleSequence = SKAction.sequence([scaleIn, scaleOut])
        fieldButton.run(SKAction.repeat(scaleSequence, count: -1))
        
        peopleButton.name = "Homebutton"
        peopleButton.setScale(1)
        peopleButton.position = CGPoint(x: self.size.width * 0.65, y: self.size.height * 0.1)
        peopleButton.zPosition = 10
        self.addChild(peopleButton)
        peopleButton.run(SKAction.repeat(scaleSequence, count: -1))
        
        moneyLabel.text = "MONEY: \(moneyAmount)"
        moneyLabel.fontSize = 70
        moneyLabel.fontColor = SKColor.white
        moneyLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.right
        moneyLabel.position = CGPoint(x: self.size.width * 0.80, y: self.size.height * 0.92)
        moneyLabel.zPosition = 10
        self.addChild(moneyLabel)
        
    }
    
    func entermenu(touches: Set<UITouch>) {
        
        for touch in touches {
            let location = touch.location(in: self)
            if fieldButton.contains(location) {
                changeSceneOne()
            } else if peopleButton.contains(location) {
                changeSceneTwo()
            }
        }
        
    }
    
    func changeSceneOne() {
        let targetscene = GameScene_Select(size: self.size)
        targetscene.scaleMode = self.scaleMode
        let scenetransition = SKTransition.fade(withDuration: 0.2)
        self.view!.presentScene(targetscene, transition: scenetransition)
        view?.showsPhysics = false
    }

    func changeSceneTwo() {
        let targetscene = GameScene_Member(size: self.size)
        targetscene.scaleMode = self.scaleMode
        let scenetransition = SKTransition.fade(withDuration: 0.2)
        self.view!.presentScene(targetscene, transition: scenetransition)
        view?.showsPhysics = false
    }
    func recordData() {
        let defaultsLevel = UserDefaults()
        var recordLevel = defaultsLevel.integer(forKey: "levelSaved")
        recordLevel = levelRoom
        defaultsLevel.set(recordLevel, forKey: "levelSaved")
        
        let defaultsMoney = UserDefaults()
        var recordMoney = defaultsMoney.integer(forKey: "moneySaved")
        recordMoney = moneyAmount
        defaultsMoney.set(recordMoney, forKey: "moneySaved")
    }

}
