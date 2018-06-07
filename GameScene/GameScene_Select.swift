//
//  GameScene_Select.swift
//  SeisWave
//
//  Created by Jianhang Yin on 4/14/18.
//  Copyright © 2018 Jianhang. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene_Select: SKScene {
    
    var selectLevel: Int = 1
    
    var moneyLabel = SKLabelNode(fontNamed: "RussoOne-Regular")
    let homeButton = SKSpriteNode(imageNamed: "home")
    
    let cashSound = SKAction.playSoundFileNamed("cash.mp3", waitForCompletion: false)
    let wrongSound = SKAction.playSoundFileNamed("wrong.wav", waitForCompletion: false)
    let clickSound = SKAction.playSoundFileNamed("click.wav", waitForCompletion: false)

    override func didMove(to view: SKView) {
        
        initialization()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        selectmap(touches: touches)
        
    }
    
    func initialization() {
        
        if levelRoom == 1 {
            selectLevel = 1
        } else if levelRoom < 6 {
            selectLevel = 2
        } else {
            selectLevel = 3
        }
        
        let backGround = SKSpriteNode(imageNamed: "background_pref_\(selectLevel)")
        backGround.name = "Background"
        backGround.size = self.size
        backGround.position = CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.5)
        backGround.zPosition = 0
        self.addChild(backGround)
        
        moneyLabel.text = "MONEY: \(moneyAmount)"
        moneyLabel.fontSize = 70
        moneyLabel.fontColor = SKColor.white
        moneyLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.right
        moneyLabel.position = CGPoint(x: self.size.width * 0.80, y: self.size.height * 0.92)
        moneyLabel.zPosition = 10
        self.addChild(moneyLabel)
        
        homeButton.name = "Homebutton"
        homeButton.setScale(0.6)
        homeButton.position = CGPoint(x: self.size.width * 0.26, y: self.size.height * 0 - homeButton.frame.size.height)
        homeButton.zPosition = 10
        self.addChild(homeButton)
        let homeButtonAppear = SKAction.moveTo(y: self.size.height * 0.1, duration: 0.5)
        homeButton.run(homeButtonAppear)
        
    }
    
    func selectmap(touches: Set<UITouch>) {
        
        for touch in touches {
            let location = touch.location(in: self)
            if homeButton.contains(location) {
                changeScene()
            } else if location.y > self.size.height * 0.75 && location.y < self.size.height * 0.9 {
                selectMap = 1
                moneyLabel.text = "MONEY: \(moneyAmount)"
                let scaleIn = SKAction.scale(to: 1.2, duration: 0.2)
                let scaleOut = SKAction.scale(to: 1, duration: 0.2)
                let scaleSequence = SKAction.sequence([clickSound, scaleIn, scaleOut])
                moneyLabel.run(scaleSequence) {
                    self.startgame()
                }
            } else if location.y > self.size.height * 0.50 && location.y < self.size.height * 0.65 {
                if selectLevel > 1 {
                    if moneyAmount >= 30 {
                        selectMap = 2
                        moneyAmount -= 30
                        moneyLabel.text = "MONEY: \(moneyAmount)"
                        recordData()
                        let scaleIn = SKAction.scale(to: 1.2, duration: 0.2)
                        let scaleOut = SKAction.scale(to: 1, duration: 0.2)
                        let scaleSequence = SKAction.sequence([cashSound, scaleIn, scaleOut])
                        moneyLabel.run(scaleSequence) {
                            self.startgame()
                        }
                    } else {
                        let scaleIn = SKAction.scale(to: 1.2, duration: 0.2)
                        let scaleOut = SKAction.scale(to: 1, duration: 0.2)
                        let scaleSequence = SKAction.sequence([wrongSound, scaleIn, scaleOut])
                        moneyLabel.run(scaleSequence)
                    }
                } else {
                    run(wrongSound)
                }
            } else if location.y > self.size.height * 0.25 && location.y < self.size.height * 0.40 {
                if selectLevel > 2 {
                    if moneyAmount >= 250 {
                        selectMap = 3
                        moneyAmount -= 250
                        moneyLabel.text = "MONEY: \(moneyAmount)"
                        recordData()
                        let scaleIn = SKAction.scale(to: 1.2, duration: 0.2)
                        let scaleOut = SKAction.scale(to: 1, duration: 0.2)
                        let scaleSequence = SKAction.sequence([cashSound, scaleIn, scaleOut])
                        moneyLabel.run(scaleSequence) {
                            self.startgame()
                        }
                    } else {
                        let scaleIn = SKAction.scale(to: 1.2, duration: 0.2)
                        let scaleOut = SKAction.scale(to: 1, duration: 0.2)
                        let scaleSequence = SKAction.sequence([wrongSound, scaleIn, scaleOut])
                        moneyLabel.run(scaleSequence)
                    }
                } else {
                    run(wrongSound)
                }
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
    
    func startgame() {
        let targetscene = GameScene_Field(size: self.size)
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







































