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

    @IBOutlet weak var viewPlayContraintHeight: NSLayoutConstraint!
    @IBOutlet weak var btnPlay: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var viewBtnPlay: UIView!
    
   var imgVideo: UIImageView!
   var lblVideoName: UILabel!
   var viewContainer: UIView!
    
    var playerContainerView: UIView!
    var isplay: Bool = false
    var color: UIColor = .clear
    var fileName: String = ""
    var path: String = ""
    var hasError = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
        
    func configure(color:UIColor){
        self.color = color
    }
    
    func setFileName(fileName:String){
        self.fileName = fileName
    }
    
    func setPath(path:String){
        self.path = path
        let url = URL(fileURLWithPath: self.path)
        self.fileName = url.lastPathComponent
    }
   
    private func updateView(){
        lblVideoName.text = self.fileName
        self.btnPlay.setTitleColor(color, for: .normal)
        Utils.setRoundedCornesButton(self.viewBtnPlay, color: self.color, size: 5)
        Utils.setRoundedCornesButton(self.viewContainer, color: Utils.hexStringToUIColor(hex: "#f8f8f8"), size: 5)
        Utils.setRoundedCornesButton(self.imgVideo, color: .clear, size: 5)
        viewContainer.backgroundColor = Utils.hexStringToUIColor(hex: "#f8f8f8")
        imgVideo.backgroundColor = Utils.hexStringToUIColor(hex: "#8b8b8b")
        
        if self.hasError{
            self.imgVideo.image = UIImage(named: "iconImageError", in: Utils.getBundle(), compatibleWith: nil)
        }else{
            self.imgVideo.image = UIImage(named: "iconVideo", in: Utils.getBundle(), compatibleWith: nil)
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
        let url: URL
        if path != "" {
            url = URL(fileURLWithPath: self.path)
        }else{
            url = Utils.createNewPath(lastPath: self.fileName)
        }
        if url.path != "" {
            let player = AVPlayer(url: url)
            let playerViewController = AVPlayerViewController()
            playerViewController.player = player
            self.present(playerViewController, animated: true) {
              playerViewController.player!.play()
            }
            hasError = false
        }else{
            self.hasError = true
            updateView()
        }
    }

    
}



extension VideoViewController: UITableViewDelegate, UITableViewDataSource {
    
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
        self.lblVideoName = cell.viewWithTag(2) as? UILabel
        self.imgVideo = cell.viewWithTag(3) as? UIImageView
        self.updateView()
        
        return cell
    }
    
}
