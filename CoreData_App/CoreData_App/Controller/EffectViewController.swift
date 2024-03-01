//
//  EffectViewController.swift
//  CoreData_App
//
//  Created by Macbook on 27/04/2023.
//

import UIKit
import Lottie

class EffectViewController: UIViewController {

    @IBOutlet weak var viewmountain: UIView!
    @IBOutlet weak var myViewSnowman: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
       createPlayer()
        createAnimation()
        createAnimations()
    }
    
    private func createPlayer() {
        let player = CAEmitterLayer()
        player.emitterPosition = CGPoint(x: view.center.x, y: -50)
        let cell = CAEmitterCell()
        cell.scale = 0.02
        cell.emissionRange = .pi * 2
        cell.lifetime = 10
        cell.birthRate = 100
        cell.velocity = 150
        
        cell.contents = UIImage(named: "tuyet")!.cgImage
        
        player.emitterCells = [cell]
        view.layer.addSublayer(player)
    }
    
    func createAnimation() {
        let aniView = LottieAnimationView(name: "tree")
        aniView.contentMode = .scaleAspectFill
        aniView.center = self.myViewSnowman.center
        aniView.frame = self.myViewSnowman.bounds
        aniView.loopMode = .loop
        aniView.play()
        self.myViewSnowman.addSubview(aniView)
    }
    
    func createAnimations() {
        let aniView = LottieAnimationView(name: "mountains")
        aniView.contentMode = .scaleToFill
        aniView.center = self.viewmountain.center
        aniView.frame = self.viewmountain.bounds
        aniView.loopMode = .loop
        aniView.play()
        self.viewmountain.addSubview(aniView)
    }

}
