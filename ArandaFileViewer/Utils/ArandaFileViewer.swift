//
//  ArandaWiewer.swift
//  ArandaFileViewer
//
//  Created by Enar GoMez on 27/07/20.
//  Copyright © 2020 Aranda. All rights reserved.
//

import UIKit

class ArandaFileViewer {
    
    var audioVC: AudioViewController!
    var videoVC: VideoViewController!
    var imageVC: ImageViewController!
    var documentVC: DocumentViewController!
    
    func addAudioController(parent:ViewController, container: UIView, fileName: String){
        self.startController(fileType: AFVFileType.Audio)
        if self.audioVC != nil {
            parent.addChild(self.audioVC)
            audioVC.view.frame = container.frame
            container.addSubview(audioVC.view)
            audioVC.didMove(toParent: parent.self)
            self.audioVC.configure(color: .red)
            self.audioVC.showAudio(fileName: fileName)
        }else{
            defaultView(parent: parent, container: container)
        }
    }
    
    func addVideoController(parent:ViewController, container: UIView, fileName: String){
        self.startController(fileType: AFVFileType.Video)
        if self.videoVC != nil {
            parent.addChild(self.videoVC)
            videoVC.view.frame = container.frame
            container.addSubview(videoVC.view)
            videoVC.didMove(toParent: parent.self)
            self.videoVC.configure(color: .red, fileName: fileName)
        }else{
            defaultView(parent: parent, container: container)
        }
    }
    
    func addImageController(parent:ViewController, container: UIView, fileName: String){
        self.startController(fileType: AFVFileType.Image)
        if self.imageVC != nil {
            parent.addChild(self.imageVC)
            imageVC.view.frame = container.frame
            container.addSubview(imageVC.view)
            imageVC.didMove(toParent: parent.self)
            self.imageVC.loadImage(fileName: fileName)
        }else{
            defaultView(parent: parent, container: container)
        }
    }
    
    func addDocumentController(parent:ViewController, container: UIView, fileName: String, path: String){
        self.startController(fileType: AFVFileType.Document)
        if self.documentVC != nil {
            parent.addChild(self.documentVC)
            documentVC.view.frame = container.frame
            container.addSubview(documentVC.view)
            documentVC.didMove(toParent: parent.self)
            if path == "" {
                documentVC.loadDocument(fileName: fileName)
            }else{
                documentVC.loadDocumentInPath(path: path)
            }
        }else{
            defaultView(parent: parent, container: container)
        }
    }
    
    private func startController(fileType: AFVFileType){
        let storyboard = UIStoryboard(name: "Viewer", bundle: nil)
        switch fileType {
        case .Audio:
            self.audioVC  = storyboard.instantiateViewController(withIdentifier: "AudioViewController") as? AudioViewController
            break
        case .Video:
            self.videoVC  = storyboard.instantiateViewController(withIdentifier: "VideoViewController") as? VideoViewController
            break
        case .Image:
            self.imageVC  = storyboard.instantiateViewController(withIdentifier: "ImageViewController") as? ImageViewController
            break
        case .Document:
            self.documentVC  = storyboard.instantiateViewController(withIdentifier: "DocumentViewController") as? DocumentViewController
            break
        default:
            break
        }
    }
    
    
    /// Contruye los controlladores desde el storyboard
    /// - Parameters:
    ///   - parent: controllador donde presentara la vista
    ///   - container: vista contenedora del controlador
    private func defaultView(parent:ViewController, container: UIView){
        let storyboard = UIStoryboard(name: "Viewer", bundle: nil)
        let defaultVC = storyboard.instantiateViewController(withIdentifier: "DefualtViewController") as? DefualtViewController
        parent.addChild(defaultVC!)
        defaultVC!.view.frame = container.frame
        container.addSubview(defaultVC!.view)
        defaultVC!.didMove(toParent: parent.self)
    
    }
  
}
