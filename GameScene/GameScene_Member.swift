//
//  GameScene_Member.swift
//  SeisWave
//
//  Created by Jianhang Yin on 4/10/18.
//  Copyright © 2018 Jianhang. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene_Member: SKScene {
    
    enum selectstatus {
        case preselect
        case onselect
    }
    
    var selectStatus = selectstatus.preselect
    var pageMember = 1
    let homeButton = SKSpriteNode(imageNamed: "home")
    let nextButton = SKSpriteNode(imageNamed: "nextpage")
    let previousButton = SKSpriteNode(imageNamed: "previouspage")
    let recruitButton = SKSpriteNode(imageNamed: "recruit")
    let recruitButtonDark = SKSpriteNode(imageNamed: "recruitdark")

    let selectButtonYellow = SKSpriteNode(imageNamed: "selectbutton_2")
    let selectButtonBrown = SKSpriteNode(imageNamed: "selectbutton_3")

    
    var moneyLabel = SKLabelNode(fontNamed: "RussoOne-Regular")
    
    let clickSound = SKAction.playSoundFileNamed("click.wav", waitForCompletion: false)
    let cashSound = SKAction.playSoundFileNamed("cash.mp3", waitForCompletion: false)
    let wrongSound = SKAction.playSoundFileNamed("wrong.wav", waitForCompletion: false)

    
    override func didMove(to view: SKView) {
        
        initialization()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        buttonfunction(touches: touches)
        
    }
    
    func initialization() {
        
        selectStatus = selectstatus.preselect
        
        let backGround = SKSpriteNode(imageNamed: "background_r\(pageMember)_final")
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
        
        recruitButtonDark.name = "Recruitbuttondark"
        recruitButtonDark.setScale(0.6)
        recruitButtonDark.position = CGPoint(x: self.size.width * 0.48, y: self.size.height * 0 - recruitButtonDark.frame.size.height)
        recruitButtonDark.zPosition = 10
        self.addChild(recruitButtonDark)
        let recruitButtonDarkAppear = SKAction.moveTo(y: self.size.height * 0.09, duration: 0.5)
        recruitButtonDark.run(recruitButtonDarkAppear)
        
        if pageMember == 1 {
            nextButton.name = "Nextbutton"
            nextButton.setScale(0.6)
            nextButton.position = CGPoint(x: self.size.width * 0.73, y: self.size.height * 0 - nextButton.frame.size.height)
            nextButton.zPosition = 10
            self.addChild(nextButton)
            let nextButtonDarkAppear = SKAction.moveTo(y: self.size.height * 0.09, duration: 0.5)
            nextButton.run(nextButtonDarkAppear)
            
            addbutton(buttonType: 3, buttonHeight: 1)
            addbutton(buttonType: 3, buttonHeight: 2)
            addbutton(buttonType: 3, buttonHeight: 3)
            if levelRoom == 1 {
                addbutton(buttonType: 2, buttonHeight: 4)
                addbutton(buttonType: 1, buttonHeight: 5)
            } else if levelRoom == 2 {
                addbutton(buttonType: 3, buttonHeight: 4)
                addbutton(buttonType: 2, buttonHeight: 5)
            } else {
                addbutton(buttonType: 3, buttonHeight: 4)
                addbutton(buttonType: 3, buttonHeight: 5)
            }
        } else if pageMember == 2 {
            previousButton.name = "Previousbutton"
            previousButton.setScale(0.6)
            previousButton.position = CGPoint(x: self.size.width * 0.73, y: self.size.height * 0 - previousButton.frame.size.height)
            previousButton.zPosition = 10
            self.addChild(previousButton)
            let previousButtonDarkAppear = SKAction.moveTo(y: self.size.height * 0.09, duration: 0.5)
            previousButton.run(previousButtonDarkAppear)
            if levelRoom == 1 {
                addbutton(buttonType: 1, buttonHeight: 1)
                addbutton(buttonType: 1, buttonHeight: 2)
                addbutton(buttonType: 1, buttonHeight: 3)
                addbutton(buttonType: 1, buttonHeight: 5)
            } else if levelRoom == 2 {
                addbutton(buttonType: 1, buttonHeight: 1)
                addbutton(buttonType: 1, buttonHeight: 2)
                addbutton(buttonType: 1, buttonHeight: 3)
                addbutton(buttonType: 1, buttonHeight: 5)
            } else if levelRoom == 3 {
                addbutton(buttonType: 2, buttonHeight: 1)
                addbutton(buttonType: 1, buttonHeight: 2)
                addbutton(buttonType: 1, buttonHeight: 3)
                addbutton(buttonType: 1, buttonHeight: 5)
            } else if levelRoom == 4 {
                addbutton(buttonType: 3, buttonHeight: 1)
                addbutton(buttonType: 2, buttonHeight: 2)
                addbutton(buttonType: 1, buttonHeight: 3)
                addbutton(buttonType: 1, buttonHeight: 5)
            } else if levelRoom == 5 {
                addbutton(buttonType: 3, buttonHeight: 1)
                addbutton(buttonType: 3, buttonHeight: 2)
                addbutton(buttonType: 2, buttonHeight: 3)
                addbutton(buttonType: 1, buttonHeight: 5)
            } else if levelRoom == 6 {
                addbutton(buttonType: 3, buttonHeight: 1)
                addbutton(buttonType: 3, buttonHeight: 2)
                addbutton(buttonType: 3, buttonHeight: 3)
                addbutton(buttonType: 2, buttonHeight: 5)
            } else if levelRoom == 7 {
                addbutton(buttonType: 3, buttonHeight: 1)
                addbutton(buttonType: 3, buttonHeight: 2)
                addbutton(buttonType: 3, buttonHeight: 3)
                addbutton(buttonType: 3, buttonHeight: 5)
            }
        }
        
    }
    
    func addrecruitbutton(buttonType: Int) {
        if buttonType == 1 {
            recruitButtonDark.name = "Recruitbuttondark"
            recruitButtonDark.setScale(0.6)
            recruitButtonDark.position = CGPoint(x: self.size.width * 0.48, y: self.size.height * 0.09)
            recruitButtonDark.zPosition = 10
            self.addChild(recruitButtonDark)

        } else {
            recruitButton.name = "Recruitbuttondark"
            recruitButton.setScale(0.6)
            recruitButton.position = CGPoint(x: self.size.width * 0.48, y: self.size.height * 0.09)
            recruitButton.zPosition = 10
            self.addChild(recruitButton)
        }
    }
    
    func addbutton(buttonType: Int, buttonHeight: Int) {
        
        let selectButtonDark = SKSpriteNode(imageNamed: "selectbutton_1")
        let selectButtonOwn = SKSpriteNode(imageNamed: "own")
        let buttonLocation: CGPoint

        switch buttonHeight {
        case 1:
            buttonLocation = CGPoint(x: self.size.width * 0.67, y: self.size.height * 0.83)
        case 2:
            buttonLocation = CGPoint(x: self.size.width * 0.67, y: self.size.height * 0.676)
        case 3:
            buttonLocation = CGPoint(x: self.size.width * 0.67, y: self.size.height * 0.522)
        case 4:
            buttonLocation = CGPoint(x: self.size.width * 0.67, y: self.size.height * 0.368)
        case 5:
            buttonLocation = CGPoint(x: self.size.width * 0.67, y: self.size.height * 0.214)
        default:
            buttonLocation = CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.5)
            print("Wrong button position")
        }
        
        switch buttonType {
        case 1:
            selectButtonDark.name = "Selectbuttondark"
            selectButtonDark.setScale(0.6)
            selectButtonDark.position = buttonLocation
            selectButtonDark.zPosition = 10
            selectButtonDark.anchorPoint = CGPoint(x: 0, y: 0.5)
            self.addChild(selectButtonDark)
        case 2:
            selectButtonYellow.name = "Selectbuttonyellow"
            selectButtonYellow.setScale(0.6)
            selectButtonYellow.position = buttonLocation
            selectButtonYellow.zPosition = 10
            selectButtonYellow.anchorPoint = CGPoint(x: 0, y: 0.5)
            self.addChild(selectButtonYellow)
        case 3:
            selectButtonOwn.name = "Selectbuttonown"
            selectButtonOwn.setScale(0.6)
            selectButtonOwn.position = buttonLocation
            selectButtonOwn.zPosition = 10
            selectButtonOwn.anchorPoint = CGPoint(x: 0, y: 0.5)
            self.addChild(selectButtonOwn)
        case 4:
            selectButtonBrown.name = "Selectbuttonbrown"
            selectButtonBrown.setScale(0.6)
            selectButtonBrown.position = buttonLocation
            selectButtonBrown.zPosition = 10
            selectButtonBrown.anchorPoint = CGPoint(x: 0, y: 0.5)
            self.addChild(selectButtonBrown)
        default:
            print("Wrong button type")
        }
    }
    
    func buttonfunction(touches: Set<UITouch>) {
        
        for touch in touches {
            let location = touch.location(in: self)
            if homeButton.contains(location) {
                changeScene()
            } else if nextButton.parent != nil && nextButton.contains(location) {
                pageMember += 1
                self.removeAllChildren()
                initialization()
            } else if previousButton.parent != nil && previousButton.contains(location) {
                pageMember -= 1
                self.removeAllChildren()
                initialization()
            } else if selectButtonYellow.parent != nil && selectStatus == selectstatus.preselect && selectButtonYellow.contains(location) {
                let deleteYellowButton = SKAction.removeFromParent()
                let yellowButtonSequence = SKAction.sequence([clickSound, deleteYellowButton])
                selectButtonYellow.run(yellowButtonSequence)
                if levelRoom == 6 {
                    addbutton(buttonType: 4, buttonHeight: 5)
                } else {
                    addbutton(buttonType: 4, buttonHeight: 3 + levelRoom - levelRoom / 3 * 5)
                }
                recruitButtonDark.removeFromParent()
                addrecruitbutton(buttonType: 2)
                selectStatus = selectstatus.onselect
            } else if selectButtonBrown.parent != nil && selectStatus == selectstatus.onselect && selectButtonBrown.contains(location) {
                let deleteBrownButton = SKAction.removeFromParent()
                let brownButtonSequence = SKAction.sequence([clickSound, deleteBrownButton])
                selectButtonBrown.run(brownButtonSequence)
                if levelRoom == 6 {
                    addbutton(buttonType: 2, buttonHeight: 5)
                } else {
                    addbutton(buttonType: 2, buttonHeight: 3 + levelRoom - levelRoom / 3 * 5)
                }
                recruitButton.removeFromParent()
                addrecruitbutton(buttonType: 1)
                selectStatus = selectstatus.preselect
            } else if recruitButton.parent != nil && selectStatus == selectstatus.onselect && recruitButton.contains(location) {
                if levelRoom == 6 && moneyAmount >= 1000 {
                    moneyAmount -= 1000
                    moneyLabel.text = "MONEY: \(moneyAmount)"
                    let scaleIn = SKAction.scale(to: 1.2, duration: 0.2)
                    let scaleOut = SKAction.scale(to: 1, duration: 0.2)
                    let scaleSequence = SKAction.sequence([cashSound, scaleIn, scaleOut])
                    moneyLabel.run(scaleSequence){
                        self.congratulation()
                    }

                    levelRoom += 1
                    recordData()
                    self.removeAllChildren()
                    initialization()
    
                } else if levelRoom < 6 && moneyAmount >= 100 {
                    moneyAmount -= 100
                    moneyLabel.text = "MONEY: \(moneyAmount)"
                    let scaleIn = SKAction.scale(to: 1.2, duration: 0.2)
                    let scaleOut = SKAction.scale(to: 1, duration: 0.2)
                    let scaleSequence = SKAction.sequence([cashSound, scaleIn, scaleOut])
                    moneyLabel.run(scaleSequence)
                    
                    levelRoom += 1
                    recordData()
                    self.removeAllChildren()
                    initialization()
                } else {
                    let scaleIn = SKAction.scale(to: 1.2, duration: 0.2)
                    let scaleOut = SKAction.scale(to: 1, duration: 0.2)
                    let scaleSequence = SKAction.sequence([wrongSound, scaleIn, scaleOut])
                    moneyLabel.run(scaleSequence)
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
    
    func congratulation() {
        let targetscene = GameScene_Con(size: self.size)
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


































