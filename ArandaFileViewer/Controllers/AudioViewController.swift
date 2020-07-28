//
//  AudioViewController.swift
//  ArandaFileViewer
//
//  Created by Enar GoMez on 21/07/20.
//  Copyright © 2020 Aranda. All rights reserved.
//

import UIKit
import AVFoundation

class AudioViewController: UIViewController {

    @IBOutlet weak var btnPlay: UIButton!
    @IBOutlet weak var imgAudio: UIImageView!
    @IBOutlet weak var lblAudioTime: UILabel!
    @IBOutlet weak var stackContainer: UIStackView!
    
    
    var isplay: Bool = false
    var color: UIColor = .clear
    var player: AVAudioPlayer!
    var duration = TimeInterval()
    var hasError = false
    
    //error view
    @IBOutlet weak var viewContainerError: UIView!
    @IBOutlet weak var imgError: UIImageView!
    @IBOutlet weak var lblError: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewDidDisappear(_ animated: Bool) {
        if self.isplay {
            self.player.stop()
        }
    }
    
    func configure(color:UIColor){
        self.color = color
        self.btnPlay.setTitleColor(color, for: .normal)
        self.imgAudio.image = UIImage(named: "iconAudio")!.imageWithColor(self.color)
        self.showInitialView()
    }
    
    private func showInitialView(){
        self.imgError.image = UIImage(named: "iconAudio")!.imageWithColor(self.color)
        self.lblError.text = "loading"
        self.updateView(showError: true)
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
    
    private func setPlay() {
        let imgPlay = UIImage(named: "iconPlay")!.imageWithColor(self.color)
        self.btnPlay.setTitle(Utils.stringNamed("audio_play"), for: .normal)
        self.btnPlay.setImage(imgPlay, for: .normal)
    }
    
    private func setStop() {
        let imgPlay = UIImage(named: "iconStop")!.imageWithColor(self.color)
        self.btnPlay.setTitle(Utils.stringNamed("audio_stop"), for: .normal)
        self.btnPlay.setImage(imgPlay, for: .normal)
    }
    
    @IBAction func btnPlayAction(_ sender: Any) {
        self.isplay = !self.isplay
        if self.isplay {
            self.setStop()
            self.player.play()
        }else{
            self.setPlay()
            self.player.pause()
        }
        
    }
    
    func showAudio(fileName: String)
    {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        if paths.count > 0 {
            if let dirPath = paths[0] as String? {
                let fileManager = FileManager.default
                let fileURL = URL(fileURLWithPath: dirPath).appendingPathComponent(fileName)
                if fileManager.fileExists(atPath: fileURL.path){
                    self.setupAudioPlayerWithFile(fileURL.path)
                    if !self.hasError {
                        self.updateView(showError: false)
                        self.setPlay()
                        self.lblAudioTime.text = ""
                        self.duration = self.player.duration
                        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(AudioViewController.progressSong), userInfo: nil, repeats: true)
                    }else{
                        self.lblError.text = Utils.stringNamed("Preview_not_available")
                        self.updateView(showError: true)
                    }
                }else{
                    self.lblError.text = Utils.stringNamed("Preview_not_available")
                    self.updateView(showError: true)
                }
            }
            else{
                self.lblError.text = Utils.stringNamed("Preview_not_available")
                self.updateView(showError: true)
            }
        }else{
            self.lblError.text = Utils.stringNamed("Preview_not_available")
            self.updateView(showError: true)
        }
        
        
    }

    private func setupAudioPlayerWithFile(_ file:String) {
        let url = URL(fileURLWithPath: file)
        //var audioPlayer:AVAudioPlayer?
        do {
            self.player = try AVAudioPlayer(contentsOf: url)
            self.player.delegate = self
            self.hasError = false
        } catch let error as NSError {
            NSLog("Error Audio: \(error)")
            self.hasError = true
           // audioPlayer = nil
        }
      //  return audioPlayer ?? nil
    }
    
    @objc private func progressSong()
       {
           if self.player.isPlaying
           {
               let currentTime:TimeInterval = self.player.currentTime
               
               let currentTimeInteger =  NSInteger(currentTime)
               
               let seconds = currentTimeInteger % 60
               let minutes = (currentTimeInteger / 60) % 60
               let hours = (currentTimeInteger / 3600)
               
               let timeAsText = NSString(format: "%0.2d:%0.2d:%0.2d",hours,minutes,seconds)
               
               self.lblAudioTime.text = ("\(timeAsText)")
               
           }
           else
           {
               return
           }
       }
    
}

extension AudioViewController: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        print("Audio player did finish playing: \(flag)")
        if (flag) {
            self.isplay = false
            let timeAsText = NSString(format: "%0.2d:%0.2d:%0.2d",0,0,0)
            self.lblAudioTime.text = ("\(timeAsText)")
            self.setPlay()
        }
    }
}
