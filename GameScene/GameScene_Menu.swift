//
//  GameScene_Menu.swift
//  SeisWave
//
//  Created by Jianhang Yin on 4/10/18.
//  Copyright © 2018 Jianhang. All rights reserved.
//

import SpriteKit
import GameplayKit

var moneyAmount = 0
var levelRoom = 1
var selectMap = 1

class GameScene_Menu: SKScene {
    
    let startLabel = SKLabelNode(fontNamed: "RussoOne-Regular")
    let tutLabel = SKLabelNode(fontNamed: "RussoOne-Regular")
    
    override func didMove(to view: SKView) {
        
        initialization()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        startgame(touches: touches)
    }
    
    func initialization() {
        
        let defaultsMoney = UserDefaults()
        let recordMoney = defaultsMoney.integer(forKey: "moneySaved")
        moneyAmount = recordMoney
        
        let defaultsLevel = UserDefaults()
        let recordLevel = defaultsLevel.integer(forKey: "levelSaved")
        if recordLevel != 0 {
            levelRoom = recordLevel
        }
        
        let backGround = SKSpriteNode(imageNamed: "background_final")
        backGround.name = "Background"
        backGround.size = self.size
        backGround.position = CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.5)
        backGround.zPosition = 0
        self.addChild(backGround)
        
        let gameLabel1 = SKLabelNode(fontNamed: "RussoOne-Regular")
        gameLabel1.numberOfLines = 2
        gameLabel1.text = "Jianhang's"
        gameLabel1.fontSize = 100
        gameLabel1.fontColor = SKColor.white
        gameLabel1.position = CGPoint(x: self.size.width / 2, y: self.size.height * 0.68)
        gameLabel1.zPosition = 2
        self.addChild(gameLabel1)
        
        let gameLabel1s = SKLabelNode(fontNamed: "RussoOne-Regular")
        gameLabel1s.numberOfLines = 2
        gameLabel1s.text = "Jianhang's"
        gameLabel1s.fontSize = 100
        gameLabel1s.fontColor = SKColor.black
        gameLabel1s.position = CGPoint(x: self.size.width / 2 - 10, y: self.size.height * 0.68 - 10)
        gameLabel1s.zPosition = 1
        self.addChild(gameLabel1s)
        
        let gameLabel2 = SKLabelNode(fontNamed: "RussoOne-Regular")
        gameLabel2.numberOfLines = 2
        gameLabel2.text = "SEISWAVE"
        gameLabel2.fontSize = 160
        gameLabel2.fontColor = SKColor.white
        gameLabel2.position = CGPoint(x: self.size.width / 2, y: self.size.height * 0.60)
        gameLabel2.zPosition = 2
        self.addChild(gameLabel2)
        
        let gameLabel2s = SKLabelNode(fontNamed: "RussoOne-Regular")
        gameLabel2s.numberOfLines = 2
        gameLabel2s.text = "SEISWAVE"
        gameLabel2s.fontSize = 160
        gameLabel2s.fontColor = SKColor.black
        gameLabel2s.position = CGPoint(x: self.size.width / 2 - 10, y: self.size.height * 0.60 - 10)
        gameLabel2s.zPosition = 1
        self.addChild(gameLabel2s)
        
        tutLabel.text = "TUTORIAL"
        tutLabel.fontSize = 120
        tutLabel.fontColor = SKColor.white
        tutLabel.position = CGPoint(x: self.size.width / 2, y: self.size.height * 0.35)
        tutLabel.zPosition = 2
        self.addChild(tutLabel)
        
        let tutLabels = SKLabelNode(fontNamed: "RussoOne-Regular")
        tutLabels.text = "TUTORIAL"
        tutLabels.fontSize = 120
        tutLabels.fontColor = SKColor.black
        tutLabels.position = CGPoint(x: self.size.width / 2 - 10, y: self.size.height * 0.35 - 10)
        tutLabels.zPosition = 1
        self.addChild(tutLabels)
        
        startLabel.text = "START"
        startLabel.fontSize = 150
        startLabel.fontColor = SKColor.white
        startLabel.position = CGPoint(x: self.size.width / 2, y: self.size.height * 0.15)
        startLabel.zPosition = 2
        self.addChild(startLabel)
        
        let startLabels = SKLabelNode(fontNamed: "RussoOne-Regular")
        startLabels.text = "START"
        startLabels.fontSize = 150
        startLabels.fontColor = SKColor.black
        startLabels.position = CGPoint(x: self.size.width / 2 - 10, y: self.size.height * 0.15 - 10)
        startLabels.zPosition = 1
        self.addChild(startLabels)
        
        
    }
    
    func startgame(touches: Set<UITouch>) {
        
        for touch in touches {
            let location = touch.location(in: self)
            if startLabel.contains(location) {
                changeScene()
            } else if tutLabel.contains(location) {
                entertut()
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
    
    func entertut() {
        let targetscene = GameScene_Tut1(size: self.size)
        targetscene.scaleMode = self.scaleMode
        let scenetransition = SKTransition.fade(withDuration: 0.2)
        self.view!.presentScene(targetscene, transition: scenetransition)
        view?.showsPhysics = false
    }

}

















