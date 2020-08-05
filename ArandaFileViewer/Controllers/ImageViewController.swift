//
//  ImageViewController.swift
//  ArandaFileViewer
//
//  Created by Enar GoMez on 26/07/20.
//  Copyright © 2020 Aranda. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {
    
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblImageName: UILabel!
    @IBOutlet weak var viewImageContainer: UIView!
    
    var imgError: UIImage!
    var fileName = ""
    var hasError = false
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imgError = UIImage(named: "iconImageError", in: Utils.getBundle(), compatibleWith: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        self.prepareView()
    }
    
    func loadImage(withPath:String){
        let fileManager = FileManager.default
        let writePath = URL(fileURLWithPath: withPath)
        self.lblImageName.text = writePath.lastPathComponent
        if fileManager.fileExists(atPath: writePath.path){
            imgView.image = UIImage(contentsOfFile: writePath.path)
        }else{
            self.hasError = true
            self.loadImage(image: self.imgError)
        }

    }
    
    func loadImage(fileName: String){
        self.lblImageName.text = fileName
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        if paths.count > 0 {
            if let dirPath = paths[0] as String? {
                let writePath = URL(fileURLWithPath: dirPath).appendingPathComponent(fileName)
                self.loadImage(withPath: writePath.path)
            }
            else{
                self.hasError = true
                self.loadImage(image: self.imgError)
            }
        }else{
            self.hasError = true
            self.loadImage(image: self.imgError)
        }
    }
    
    func loadImage(image: UIImage, fileName: String = ""){
        self.lblImageName.text = fileName
        if self.hasError {
           imgView.backgroundColor = Utils.hexStringToUIColor(hex: "#8b8b8b")
        }
        self.imgView.image = image
    }
    
    private func prepareView(){
        
        Utils.setRoundedCornesButton(self.viewContainer, color: Utils.hexStringToUIColor(hex: "#f8f8f8"), size: 5)
        viewContainer.backgroundColor = Utils.hexStringToUIColor(hex: "#f8f8f8")
        Utils.setRoundedCornesButton(self.imgView, color: .clear, size: 5)
        Utils.setRoundedCornesButton(self.viewContainer, color: .clear, size: 5)
    }
    
}
