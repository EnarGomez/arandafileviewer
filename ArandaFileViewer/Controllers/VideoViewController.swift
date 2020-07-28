//
//  VideoViewController.swift
//  ArandaFileViewer
//
//  Created by Enar GoMez on 23/07/20.
//  Copyright © 2020 Aranda. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class VideoViewController: UIViewController {

   @IBOutlet weak var btnPlay: UIButton!
   @IBOutlet weak var imgVideo: UIImageView!
   @IBOutlet weak var lblVideoName: UILabel!
   @IBOutlet weak var stackContainer: UIStackView!

    //error view
    @IBOutlet weak var viewContainerError: UIView!
    @IBOutlet weak var imgError: UIImageView!
    @IBOutlet weak var lblError: UILabel!
    
    var playerContainerView: UIView!
    var isplay: Bool = false
    var color: UIColor = .clear
    var fileName: String = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
        
    func configure(color:UIColor, fileName:String){
        self.color = color
        self.imgVideo.image = UIImage(named: "iconVideo")!.imageWithColor(self.color)
        self.fileName = fileName
        self.setPlay()
        self.showInitialView()
        
    }
    
    private func setPlay() {
        self.lblVideoName.text = self.fileName
        self.btnPlay.setTitleColor(color, for: .normal)
        let imgPlay = UIImage(named: "iconPlay")!.imageWithColor(self.color)
        self.btnPlay.setTitle(Utils.stringNamed("audio_play"), for: .normal)
        self.btnPlay.setImage(imgPlay, for: .normal)
    }
    
    private func showInitialView(){
        self.imgError.image = UIImage(named: "iconVideo")!.imageWithColor(self.color)
        self.lblError.text = self.fileName
        self.updateView(showError: false)
    }
    
    private func updateView(showError:Bool){
        if showError{
            self.stackContainer.isHidden = true
            self.viewContainerError.isHidden = false
        }else{
            self.stackContainer.isHidden = false
            self.viewContainerError.isHidden = true
        }
    }
    
    @IBAction func btnPlayAction(_ sender: Any) {
        if !self.isplay {
            playVideo()
        }
        self.isplay = !self.isplay
    }
    
    func playVideo() {
         self.startVideoFrom()
     }

     // Play Video from path
    func startVideoFrom() {
        
        let url = Utils.createNewPath(lastPath: self.fileName) 
        if url.path != "" {
            let player = AVPlayer(url: url)
            let playerViewController = AVPlayerViewController()
            playerViewController.player = player
            self.present(playerViewController, animated: true) {
              playerViewController.player!.play()
            }
        }else{
            updateView(showError: true)
        }
    }

    
}


