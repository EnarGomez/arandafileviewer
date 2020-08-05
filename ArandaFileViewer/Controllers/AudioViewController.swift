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
    
    @IBOutlet weak var viewPlayContraintHeight: NSLayoutConstraint!
    @IBOutlet weak var btnPlay: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var viewBtnPlay: UIView!
    
    var imgAudio: UIImageView!
    var lblAudioTime: UILabel!
    var lblAudioName: UILabel!
    var viewContainer: UIView!
    
    var isplay: Bool = false
    var color: UIColor = .clear
    var player: AVAudioPlayer!
    var duration = TimeInterval()
    var hasError = false
    var fileName = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.separatorStyle = .none
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
        self.tableView.separatorStyle = .none
       
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
        self.btnPlay.tintColor = color
    }
    
    private func updateView(){
        lblAudioName.text = self.fileName
        Utils.setRoundedCornesButton(self.viewBtnPlay, color: self.color, size: 5)
        Utils.setRoundedCornesButton(self.viewContainer, color: Utils.hexStringToUIColor(hex: "#f8f8f8"), size: 5)
        Utils.setRoundedCornesButton(self.imgAudio, color: .clear, size: 5)
        viewContainer.backgroundColor = Utils.hexStringToUIColor(hex: "#f8f8f8")
        imgAudio.backgroundColor = Utils.hexStringToUIColor(hex: "#8b8b8b")
        
        if self.hasError {
            self.imgAudio.image = UIImage(named: "iconImageError", in: Utils.getBundle(), compatibleWith: nil)
            self.lblAudioTime.text = Utils.stringNamed("Preview_not_available")
            self.viewPlayContraintHeight.constant = 0
        }else{
            self.imgAudio.image = UIImage(named: "iconAudio", in: Utils.getBundle(), compatibleWith: nil)
            self.lblAudioTime.text = ""

            Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(AudioViewController.progressSong), userInfo: nil, repeats: true)
        }
    }
    
    private func setPlay() {
        self.btnPlay.setTitle(Utils.stringNamed("audio_play"), for: .normal)
    }
    
    private func setStop() {
        self.btnPlay.setTitle(Utils.stringNamed("audio_stop"), for: .normal)
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
        self.fileName = fileName
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        if paths.count > 0 {
            if let dirPath = paths[0] as String? {
                let fileManager = FileManager.default
                let fileURL = URL(fileURLWithPath: dirPath).appendingPathComponent(fileName)
                if fileManager.fileExists(atPath: fileURL.path){
                    self.setupAudioPlayerWithFile(fileURL.path)
                    if !self.hasError {
                       
                        self.setPlay()
                       
                        self.duration = self.player.duration
                    }else{
                        self.hasError = true
                    }
                }else{
                    self.hasError = true
                }
            }
            else{
                self.hasError = true
            }
        }else{
             self.hasError = true
        }
        
        
    }
    
    private func setupAudioPlayerWithFile(_ file:String) {
        let url = URL(fileURLWithPath: file)
        do {
            self.player = try AVAudioPlayer(contentsOf: url)
            self.player.delegate = self
            self.hasError = false
        } catch let error as NSError {
            NSLog("Error Audio: \(error)")
            self.hasError = true
        }
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

extension AudioViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 320
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellImage", for: indexPath)
        self.viewContainer = cell.viewWithTag(1)
        self.lblAudioTime = cell.viewWithTag(4) as? UILabel
        self.lblAudioName = cell.viewWithTag(2) as? UILabel
        self.imgAudio = cell.viewWithTag(3) as? UIImageView
        self.updateView()
        
        return cell
    }
    
}
