//
//  GameViewController.swift
//  SeisWave
//
//  Created by Jianhang Yin on 4/9/18.
//  Copyright © 2018 Jianhang. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import AVFoundation

class GameViewController: UIViewController {
    
    var bgmAudio = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let filePath = Bundle.main.path(forResource: "bgm", ofType: "mp3")
        let bgmNSURL = NSURL(fileURLWithPath: filePath!)
        
        do {
            bgmAudio = try AVAudioPlayer(contentsOf: bgmNSURL as URL)
        } catch {
            return print("Cannot find the file")
        }
        bgmAudio.volume = 0.5
        bgmAudio.numberOfLoops = -1
        bgmAudio.play()
        
        if let view = self.view as! SKView? {
            
            let scene = GameScene_Menu(size: CGSize(width: 1536, height: 2048))
            scene.scaleMode = .aspectFill
            view.presentScene(scene)
            view.ignoresSiblingOrder = true
            view.showsFPS = false
            view.showsNodeCount = false
            view.showsPhysics = false
            
        }
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
