//
//  GameScene_Field.swift
//  SeisWave
//
//  Created by Jianhang Yin on 4/10/18.
//  Copyright © 2018 Jianhang. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene_Field: SKScene{
    
    enum stagestatus {
        
        case predeploy
        case ondeploy
        case onearthquake
        case prelocating
        case onlocating
        case afterlocating
        
    }

    let earthquakeWave = SKSpriteNode(imageNamed: "wave")
    let sensorNode = SKSpriteNode(imageNamed: "sensor")
    let detecterNode = SKSpriteNode(imageNamed: "detecter")
    
    let deployButton = SKSpriteNode(imageNamed: "deploybutton")
    let deployButtonDark = SKSpriteNode(imageNamed: "deploybuttondark")
    let doneButton = SKSpriteNode(imageNamed: "donebutton")
    let doneButtonDark = SKSpriteNode(imageNamed: "donebuttondark")
    let sourceButton = SKSpriteNode(imageNamed: "sourcebutton")
    let sourceButtonDark = SKSpriteNode(imageNamed: "sourcebuttondark")
    
    var sensorLabel = SKLabelNode(fontNamed: "RussoOne-Regular")
    var moneyLabel = SKLabelNode(fontNamed: "RussoOne-Regular")
    var earthquakeMessageUp = SKLabelNode(fontNamed: "RussoOne-Regular")
    var earthquakeMessageMid = SKLabelNode(fontNamed: "RussoOne-Regular")
    var earthquakeMessageDown = SKLabelNode(fontNamed: "RussoOne-Regular")

    let clickSound = SKAction.playSoundFileNamed("click.wav", waitForCompletion: false)
    let earthquakeSound = SKAction.playSoundFileNamed("earthsound.wav", waitForCompletion: false)
    let recordSound = SKAction.playSoundFileNamed("record.mp3", waitForCompletion: false)
    let cashSound = SKAction.playSoundFileNamed("cash.mp3", waitForCompletion: false)
    let wrongSound = SKAction.playSoundFileNamed("wrong.wav", waitForCompletion: false)

    var earthquakePosition: CGPoint?
    var currentstage = stagestatus.predeploy
    var numberSensor = 3
    var sensorDistance: CGFloat = 0.0

    override func didMove(to view: SKView) {
        
        initialization()
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if currentstage == stagestatus.predeploy {
            offersensor(touches: touches)
        }
        if currentstage == stagestatus.ondeploy {
            deploysensor(touches: touches)
        }
        if currentstage == stagestatus.onearthquake {
            triggerearthquake(touches: touches)
        }
        if currentstage == stagestatus.prelocating {
            offerdetecter(touches: touches)
        }
        if currentstage == stagestatus.onlocating {
            deploydetecter(touches: touches)
        }
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if currentstage == stagestatus.ondeploy {
            movemode(touches: touches, targetNode: sensorNode)
        }
        if currentstage == stagestatus.onlocating {
            movemode(touches: touches, targetNode: detecterNode)
        }
    }
    
    func initialization() {
        
        let backGround = SKSpriteNode(imageNamed: "background_f")
        backGround.name = "Background"
        backGround.size = self.size
        backGround.position = CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.5)
        backGround.zPosition = 0
        self.addChild(backGround)
        
        sensorLabel.text = "SENSOR: 3"
        sensorLabel.fontSize = 70
        sensorLabel.fontColor = SKColor.white
        sensorLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        sensorLabel.position = CGPoint(x: self.size.width * 0.20, y: self.size.height * 0.92)
        sensorLabel.zPosition = 10
        self.addChild(sensorLabel)
        
        moneyLabel.text = "MONEY: \(moneyAmount)"
        moneyLabel.fontSize = 70
        moneyLabel.fontColor = SKColor.white
        moneyLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.right
        moneyLabel.position = CGPoint(x: self.size.width * 0.80, y: self.size.height * 0.92)
        moneyLabel.zPosition = 10
        self.addChild(moneyLabel)
        
        deployButton.name = "Deploybutton"
        deployButton.setScale(0.6)
        deployButton.position = CGPoint(x: self.size.width * 0.37, y: self.size.height * 0 - deployButton.frame.size.height)
        deployButton.zPosition = 10
        self.addChild(deployButton)
        let deployButtonAppear = SKAction.moveTo(y: self.size.height * 0.1, duration: 0.5)
        deployButton.run(deployButtonAppear)
        
        doneButtonDark.name = "DonebuttonDark"
        doneButtonDark.setScale(0.6)
        doneButtonDark.position = CGPoint(x: self.size.width * 0.65, y: self.size.height * 0 - deployButton.frame.size.height)
        doneButtonDark.zPosition = 10
        self.addChild(doneButtonDark)
        let doneButtonDarkAppear = SKAction.moveTo(y: self.size.height * 0.1, duration: 0.5)
        doneButtonDark.run(doneButtonDarkAppear)
        
        let earthquakeXposition = randomNum(num_1: self.size.width * 0.25, num_2: self.size.width * 0.75)
        let earthquakeYposition = randomNum(num_1: self.size.height * 0.2, num_2: self.size.height * 0.87)
        earthquakePosition = CGPoint(x: earthquakeXposition, y: earthquakeYposition)
        earthquakeWave.name = "Wave"
        earthquakeWave.setScale(0.2)
        earthquakeWave.position = earthquakePosition!
        earthquakeWave.zPosition = -1
        self.addChild(earthquakeWave)
    }
    
    func movemode(touches: Set<UITouch>, targetNode: SKSpriteNode) {
        for touch in touches {
            let locationOne = touch.location(in: self)
            let locationTwo = touch.previousLocation(in: self)
            let distanceX = locationOne.x - locationTwo.x
            let distanceY = locationOne.y - locationTwo.y
            targetNode.position.x += distanceX
            if targetNode.position.x > self.size.width * 0.75 {
                targetNode.position.x = self.size.width * 0.75
            }
            if targetNode.position.x < self.size.width * 0.25 {
                targetNode.position.x = self.size.width * 0.25
            }
            targetNode.position.y += distanceY
            if targetNode.position.y > self.size.height * 0.87 {
                targetNode.position.y = self.size.height * 0.87
            }
            if targetNode.position.y < self.size.height * 0.2 {
                targetNode.position.y = self.size.height * 0.2
            }
            
        }
    }
    
    func offersensor (touches: Set<UITouch>) {
        
        for touch in touches {
            if numberSensor > 0 {
                let location = touch.location(in: self)
                if deployButton.contains(location) {
                    sensorNode.name = "Sensor"
                    sensorNode.setScale(0.5)
                    sensorNode.position = CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.5)
                    sensorNode.zPosition = 4
                    sensorNode.alpha = 0
                    addChild(sensorNode)
                    let sensorFadeIn = SKAction.fadeIn(withDuration: 0.5)
                    sensorNode.run(sensorFadeIn)
                    
                    let deleteDeployButton = SKAction.removeFromParent()
                    let deployButtonSequence = SKAction.sequence([clickSound, deleteDeployButton])
                    deployButton.run(deployButtonSequence)
                    deployButtonDark.name = "DeploybuttonDark"
                    deployButtonDark.setScale(0.6)
                    deployButtonDark.position = CGPoint(x: self.size.width * 0.37, y: self.size.height * 0.1)
                    deployButtonDark.zPosition = 10
                    self.addChild(deployButtonDark)
                    
                    doneButtonDark.removeFromParent()
                    doneButton.name = "Donebutton"
                    doneButton.setScale(0.6)
                    doneButton.position = CGPoint(x: self.size.width * 0.65, y: self.size.height * 0.1)
                    doneButton.zPosition = 10
                    self.addChild(doneButton)
                    
                    currentstage = stagestatus.ondeploy
                }
            }
        }
        
    }
    
    func deploysensor(touches: Set<UITouch>) {
        
        for touch in touches {
            let location = touch.location(in: self)
            if doneButton.contains(location) {
                
                sensordeployed()
                let sensordeployNode = SKSpriteNode(imageNamed: "sensor")
                sensordeployNode.name = "Sensordeploy"
                sensordeployNode.position = sensorNode.position
                sensordeployNode.zPosition = 4
                sensordeployNode.setScale(0.3)
                self.addChild(sensordeployNode)
                sensorNode.removeFromParent()
                sensorDistance = distancebetweennode(node1: sensordeployNode, node2: earthquakeWave)
                
                let sensorDisLabel = SKLabelNode(fontNamed: "RussoOne-Regular")
                sensorDisLabel.name = "SensorDistanceLabel"
                sensorDisLabel.text = "\(Int(sensorDistance / 50))"
                sensorDisLabel.fontSize = 80
                sensorDisLabel.fontColor = SKColor.white
                sensorDisLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
                sensorDisLabel.position = CGPoint(x: sensordeployNode.position.x, y: sensordeployNode.position.y - 120)
                sensorDisLabel.zPosition = 20
                sensorDisLabel.alpha = 0
                self.addChild(sensorDisLabel)
                
                if numberSensor > 0 {
                    deployButtonDark.removeFromParent()
                    deployButton.name = "Deploybutton"
                    deployButton.setScale(0.6)
                    deployButton.position = CGPoint(x: self.size.width * 0.37, y: self.size.height * 0.1)
                    deployButton.zPosition = 10
                    self.addChild(deployButton)
                    
                    let deleteDoneButton = SKAction.removeFromParent()
                    let doneButtonSequence = SKAction.sequence([clickSound, deleteDoneButton])
                    doneButton.run(doneButtonSequence)
                    doneButtonDark.name = "DonebuttonDark"
                    doneButtonDark.setScale(0.6)
                    doneButtonDark.position = CGPoint(x: self.size.width * 0.65, y: self.size.height * 0.1)
                    doneButtonDark.zPosition = 10
                    self.addChild(doneButtonDark)
                    
                    currentstage = stagestatus.predeploy
                } else {
                    
                    deployButtonDark.removeFromParent()
                    let deleteDoneButton = SKAction.removeFromParent()
                    let doneButtonSequence = SKAction.sequence([clickSound, deleteDoneButton])
                    doneButton.run(doneButtonSequence)
                    
                    let messageFadeIn = SKAction.fadeIn(withDuration: 1)
                    
                    earthquakeMessageUp.text = "Tap Screen"
                    earthquakeMessageUp.fontSize = 90
                    earthquakeMessageUp.fontColor = SKColor.white
                    earthquakeMessageUp.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
                    earthquakeMessageUp.position = CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.55)
                    earthquakeMessageUp.zPosition = 10
                    earthquakeMessageUp.alpha = 0
                    self.addChild(earthquakeMessageUp)
                    earthquakeMessageUp.run(messageFadeIn)
                    
                    earthquakeMessageMid.text = "to"
                    earthquakeMessageMid.fontSize = 90
                    earthquakeMessageMid.fontColor = SKColor.white
                    earthquakeMessageMid.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
                    earthquakeMessageMid.position = CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.5)
                    earthquakeMessageMid.zPosition = 10
                    earthquakeMessageMid.alpha = 0
                    self.addChild(earthquakeMessageMid)
                    earthquakeMessageMid.run(messageFadeIn)
                    
                    earthquakeMessageDown.text = "Trigger Earthquake"
                    earthquakeMessageDown.fontSize = 90
                    earthquakeMessageDown.fontColor = SKColor.white
                    earthquakeMessageDown.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
                    earthquakeMessageDown.position = CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.45)
                    earthquakeMessageDown.zPosition = 10
                    earthquakeMessageDown.alpha = 0
                    self.addChild(earthquakeMessageDown)
                    earthquakeMessageDown.run(messageFadeIn)
                    
                    currentstage = stagestatus.onearthquake
                }
            }
        }
    }
    
    func sensordeployed() {
        
        numberSensor -= 1
        sensorLabel.text = "SENSOR: \(numberSensor)"
        
        let scaleIn = SKAction.scale(to: 1.2, duration: 0.2)
        let scaleOut = SKAction.scale(to: 1, duration: 0.2)
        let scaleSequence = SKAction.sequence([scaleIn, scaleOut])
        sensorLabel.run(scaleSequence)
        
    }
    
    func triggerearthquake(touches: Set<UITouch>) {
        
        for touch in touches {
            let location = touch.location(in: self)
            if location.y > self.size.height * 0.3 && location.y < self.size.height * 0.9 {
                let labelFadeOut = SKAction.fadeOut(withDuration: 1)
                let labelFadeIn = SKAction.fadeIn(withDuration: 1)
                let distancewaitTime = SKAction.wait(forDuration: 3)
                let sourcewaitTime = SKAction.wait(forDuration: 3.5)
                let deleteLabel = SKAction.removeFromParent()
                let earthquakeSequence = SKAction.sequence([labelFadeOut, earthquakeSound, deleteLabel])
                earthquakeMessageUp.run(earthquakeSequence)
                earthquakeMessageMid.run(earthquakeSequence)
                earthquakeMessageDown.run(earthquakeSequence)
                
                let distanceSequence = SKAction.sequence([distancewaitTime, recordSound, labelFadeIn])
                self.enumerateChildNodes(withName: "SensorDistanceLabel") { (sensorDisLabel, stop) in
                    sensorDisLabel.run(distanceSequence)
                }
                sourceButton.name = "Sourcebutton"
                sourceButton.setScale(0.6)
                sourceButton.position = CGPoint(x: self.size.width * 0.37, y: self.size.height * 0 - deployButton.frame.size.height)
                sourceButton.zPosition = 10
                self.addChild(sourceButton)
                let sourceButtonAppear = SKAction.moveTo(y: self.size.height * 0.1, duration: 0.5)
                sourceButton.run(SKAction.sequence([sourcewaitTime, sourceButtonAppear]))
                
                doneButtonDark.name = "DonebuttonDark"
                doneButtonDark.setScale(0.6)
                doneButtonDark.position = CGPoint(x: self.size.width * 0.65, y: self.size.height * 0 - deployButton.frame.size.height)
                doneButtonDark.zPosition = 10
                self.addChild(doneButtonDark)
                let doneButtonDarkAppear = SKAction.moveTo(y: self.size.height * 0.1, duration: 0.5)
                doneButtonDark.run(SKAction.sequence([sourcewaitTime, doneButtonDarkAppear]))
                
                currentstage = stagestatus.prelocating
            }
        }
    }
    
    func offerdetecter(touches: Set<UITouch>) {
        
        for touch in touches {
            let location = touch.location(in: self)
            if sourceButton.contains(location) {
                detecterNode.name = "Detecter"
                if selectMap == 1 {
                    detecterNode.setScale(0.6)
                } else if selectMap == 2 {
                    detecterNode.setScale(0.4)
                } else if selectMap == 3 {
                    detecterNode.setScale(0.2)
                }
                detecterNode.position = CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.5)
                detecterNode.zPosition = 3
                detecterNode.alpha = 0
                addChild(detecterNode)
                let detecterFadeIn = SKAction.fadeIn(withDuration: 0.5)
                detecterNode.run(detecterFadeIn)
                
                let deleteSourceButton = SKAction.removeFromParent()
                let sourceButtonSequence = SKAction.sequence([clickSound, deleteSourceButton])
                sourceButton.run(sourceButtonSequence)
                sourceButtonDark.name = "SourcebuttonDark"
                sourceButtonDark.setScale(0.6)
                sourceButtonDark.position = CGPoint(x: self.size.width * 0.37, y: self.size.height * 0.1)
                sourceButtonDark.zPosition = 10
                self.addChild(sourceButtonDark)
                
                doneButtonDark.removeFromParent()
                doneButton.name = "Donebutton"
                doneButton.setScale(0.6)
                doneButton.position = CGPoint(x: self.size.width * 0.65, y: self.size.height * 0.1)
                doneButton.zPosition = 10
                self.addChild(doneButton)
                
                currentstage = stagestatus.onlocating
            }
        }
        
    }
    
    func deploydetecter(touches: Set<UITouch>) {
    
        for touch in touches {
            let location = touch.location(in: self)
            if doneButton.contains(location) {
                let deleteSourceButton = SKAction.removeFromParent()
                let sourceButtonSequence = SKAction.sequence([clickSound, deleteSourceButton])
                sourceButtonDark.run(sourceButtonSequence)
                doneButton.removeFromParent()
                
                let waveLocation = earthquakeWave.position
                if detecterNode.contains(waveLocation) {
                    if selectMap == 1 {
                        moneyAmount += 10
                        moneyLabel.text = "MONEY: \(moneyAmount)"
                        recordData()
                        earthquakeWave.zPosition = 5
                        wavepropagate(location: waveLocation)
                        returnword(select: 1)
                        let waitTime = SKAction.wait(forDuration: 3)
                        let scaleIn = SKAction.scale(to: 1.2, duration: 0.2)
                        let scaleOut = SKAction.scale(to: 1, duration: 0.2)
                        let scaleSequence = SKAction.sequence([waitTime, cashSound, scaleIn, scaleOut])
                        moneyLabel.run(scaleSequence) {
                            self.changeScene()
                        }
                    } else if selectMap == 2 {
                        moneyAmount += 50
                        moneyLabel.text = "MONEY: \(moneyAmount)"
                        recordData()
                        earthquakeWave.zPosition = 5
                        wavepropagate(location: waveLocation)
                        returnword(select: 2)
                        let waitTime = SKAction.wait(forDuration: 3)
                        let scaleIn = SKAction.scale(to: 1.2, duration: 0.2)
                        let scaleOut = SKAction.scale(to: 1, duration: 0.2)
                        let scaleSequence = SKAction.sequence([waitTime, cashSound, scaleIn, scaleOut])
                        moneyLabel.run(scaleSequence) {
                            self.changeScene()
                        }
                    } else if selectMap == 3 {
                        moneyAmount += 300
                        moneyLabel.text = "MONEY: \(moneyAmount)"
                        recordData()
                        earthquakeWave.zPosition = 5
                        wavepropagate(location: waveLocation)
                        returnword(select: 3)
                        let waitTime = SKAction.wait(forDuration: 3)
                        let scaleIn = SKAction.scale(to: 1.2, duration: 0.2)
                        let scaleOut = SKAction.scale(to: 1, duration: 0.2)
                        let scaleSequence = SKAction.sequence([waitTime, cashSound, scaleIn, scaleOut])
                        moneyLabel.run(scaleSequence) {
                            self.changeScene()
                        }
                    }
                } else {
                    earthquakeWave.zPosition = 5
                    wavepropagate(location: waveLocation)
                    returnword(select: 4)
                    let waitTime = SKAction.wait(forDuration: 3)
                    let scaleIn = SKAction.scale(to: 1.2, duration: 0.2)
                    let scaleOut = SKAction.scale(to: 1, duration: 0.2)
                    let scaleSequence = SKAction.sequence([waitTime, wrongSound, scaleIn, scaleOut])
                    moneyLabel.run(scaleSequence) {
                        self.changeScene()
                    }
                }
            }
        }
    
    }
    
    func distancebetweennode(node1: SKSpriteNode, node2: SKSpriteNode) -> CGFloat {
        
        let distanceSquare = pow((node1.position.y - node2.position.y), 2) + pow((node1.position.x - node2.position.x), 2)
        return sqrt(distanceSquare)
        
    }
    
    func wavepropagate(location: CGPoint) {
        
        let waveCircle = SKShapeNode(circleOfRadius: 1700)
        waveCircle.position = location
        waveCircle.strokeColor = SKColor.yellow
        waveCircle.lineWidth = 30
        waveCircle.zPosition = 2
        waveCircle.setScale(0)
        self.addChild(waveCircle)
        let scaleIn = SKAction.scale(to: 1, duration: 5)
        let deleteNode = SKAction.removeFromParent()
        let scaleSequence = SKAction.sequence([scaleIn, deleteNode])
        waveCircle.run(scaleSequence)
        
    }
    
    func returnword(select: Int) {
        
        let wordLabel = SKLabelNode(fontNamed: "RussoOne-Regular")
        wordLabel.fontSize = 90
        wordLabel.fontColor = SKColor.white
        wordLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        wordLabel.position = CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.15)
        wordLabel.zPosition = 10
        switch select {
        case 1:
            wordLabel.text = "Good!"
        case 2:
            wordLabel.text = "Very Good!"
        case 3:
            wordLabel.text = "Excellent!"
        case 4:
            wordLabel.text = "Try Again"
        default:
            print("Waiting for updating")
        }
        self.addChild(wordLabel)
        let deleteWord = SKAction.removeFromParent()
        let waitTime = SKAction.wait(forDuration: 3)
        let wordSequence = SKAction.sequence([waitTime, deleteWord])
        wordLabel.run(wordSequence)
        
    }
    
    func randomNum(num_1: CGFloat, num_2: CGFloat) -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(num_1 - num_2) + min(num_1, num_2)
    }
    
    func changeScene() {
        let targetscene = GameScene_Room(size: self.size)
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







































