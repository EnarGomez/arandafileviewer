//
//  ViewController.swift
//  ArandaFileViewer
//
//  Created by Enar GoMez on 20/07/20.
//  Copyright © 2020 Aranda. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var container: UIView!
    @IBOutlet weak var pickerView: UIPickerView!
    
//    var audioVC: AudioViewController!
//    var videoVC: VideoViewController!
//    var imageVC: ImageViewController!
//    var documentVC: DocumentViewController!
    let arandaWiewer: ArandaFileViewer = ArandaFileViewer()
    
    let arrOptions = ["default","test m4a", "test mp3", "test avi", "error", "video2.mp4", "video1.MOV", "imagen1.jpg", "imagen2.png" , "imagen3.gif", "imagen4.tiff", "Investigación alternativas a FFMPeg.doc","comandosPOC.txt","Evaluación Periodo Prueba -Jhonattan.xlsx","Analisis de Uso WebView.pdf" ]
    var optionSelected = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //self.startAudioViewController()
        //self.addController()
    }
    
    func prepareView(){
        self.removeView()
        if self.optionSelected != 0 {
            if optionSelected <= 4 {
                self.arandaWiewer.addAudioController(parent: self, container: self.container, fileName: getpath())
//                self.addAudioController(path: self.getpath())
            }else if optionSelected > 4 && optionSelected <= 6 {
                self.arandaWiewer.addVideoController(parent: self, container: self.container, fileName: self.arrOptions[optionSelected])
//                self.addVideoController()
            }else if optionSelected > 6 && optionSelected <= 10 {
                self.arandaWiewer.addImageController(parent: self, container: self.container, fileName: self.arrOptions[optionSelected])
//                self.addImageController()
            }else{
                self.arandaWiewer.addDocumentController(parent: self, container: self.container, fileName: self.arrOptions[optionSelected], path: "")
//                self.addDocumentController()
            }
        }
    }
    
    func getpath() -> String{
        
        if optionSelected == 1 {
            return "test1.m4a"
//            return Utils.getPathFromFile("test1.m4a")
        }else if optionSelected == 2 {
            return "test2.mp3"
//            return Utils.getPathFromFile("test2.mp3")
        }else if optionSelected == 3 {
            return "test3.wav"
//            return Utils.getPathFromFile("test3.wav")
        }else{
            return ""
        }
    }

//    func addAudioController(path: String){
//        self.startAudioViewController()
//        if self.audioVC != nil {
//            addChild(self.audioVC)
//            audioVC.view.frame = self.container.frame
//            self.container.addSubview(audioVC.view)
//            audioVC.didMove(toParent: self)
//            self.audioVC.configure(color: .red)
//            self.audioVC.showAudio(path)
//        }
//    }
//
//    func addVideoController(){
//        self.startVideoViewController()
//        if self.videoVC != nil {
//            addChild(self.videoVC)
//            videoVC.view.frame = self.container.frame
//            self.container.addSubview(videoVC.view)
//            videoVC.didMove(toParent: self)
//            self.videoVC.configure(color: .red, fileName: self.arrOptions[optionSelected])
//           // self.audioVC.showAudio(path)
//        }
//    }
//
//    func addImageController(){
//        self.startImageViewController()
//        if self.imageVC != nil {
//            addChild(self.imageVC)
//            imageVC.view.frame = self.container.frame
//            self.container.addSubview(imageVC.view)
//            imageVC.didMove(toParent: self)
//
//            self.imageVC.loadImage(fileName: self.arrOptions[optionSelected])
//        }
//    }
//
//    func addDocumentController(){
//        self.startDocumentViewController()
//        if self.documentVC != nil {
//            addChild(self.documentVC)
//            documentVC.view.frame = self.container.frame
//            self.container.addSubview(documentVC.view)
//            documentVC.didMove(toParent: self)
//            documentVC.loadDocument(fileName: self.arrOptions[optionSelected])
//            //self.imageVC.loadImage(fileName: self.arrOptions[optionSelected])
//        }
//    }
    
    func removeView(){
        for view in self.container.subviews {
            view.removeFromSuperview()
        }
    }
    

//    func startAudioViewController() {
//        let storyboard = UIStoryboard(name: "Viewer", bundle: nil)
//        self.audioVC  = storyboard.instantiateViewController(withIdentifier: "AudioViewController") as? AudioViewController
//
//    }
//
//    func startVideoViewController() {
//        let storyboard = UIStoryboard(name: "Viewer", bundle: nil)
//        self.videoVC  = storyboard.instantiateViewController(withIdentifier: "VideoViewController") as? VideoViewController
//
//    }
//
//    func startImageViewController() {
//        let storyboard = UIStoryboard(name: "Viewer", bundle: nil)
//        self.imageVC  = storyboard.instantiateViewController(withIdentifier: "ImageViewController") as? ImageViewController
//
//    }
//
//    func startDocumentViewController() {
//        let storyboard = UIStoryboard(name: "Viewer", bundle: nil)
//        self.documentVC  = storyboard.instantiateViewController(withIdentifier: "DocumentViewController") as? DocumentViewController
//
//    }
}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.arrOptions.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.arrOptions[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.optionSelected = row
        self.prepareView()
    }
}
