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
    
    var imgError: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imgError = UIImage(named: "iconImageError")
    }
    
    
    func loadImage(withPath:String){
        let fileManager = FileManager.default
        let writePath = URL(fileURLWithPath: withPath)
        if fileManager.fileExists(atPath: writePath.path){
            imgView.image = UIImage(contentsOfFile: writePath.path)
        }else{
            self.loadImage(image: self.imgError)
        }

    }
    
    func loadImage(fileName: String){
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        if paths.count > 0 {
            if let dirPath = paths[0] as String? {
                let fileManager = FileManager.default
                let writePath = URL(fileURLWithPath: dirPath).appendingPathComponent(fileName)
                if fileManager.fileExists(atPath: writePath.path){
                    imgView.image = UIImage(contentsOfFile: writePath.path)
                }else{
                    self.loadImage(image: self.imgError)
                }
            }
            else{
                self.loadImage(image: self.imgError)
            }
        }else{
            self.loadImage(image: self.imgError)
        }
    }
    
    func loadImage(image: UIImage){
        self.imgView.image = image
    }
    
}
