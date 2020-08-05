//
//  ArandaWiewer.swift
//  ArandaFileViewer
//
//  Created by Enar GoMez on 27/07/20.
//  Copyright © 2020 Aranda. All rights reserved.
//

import UIKit

public class ArandaFileViewer {
    
    var audioVC: AudioViewController!
    var videoVC: VideoViewController!
    var imageVC: ImageViewController!
    var documentVC: DocumentViewController!
    
    public init() {}
    
    public func addAudioController(parent:AnyObject, container: UIView, color: UIColor, fileName: String){
        self.startController(fileType: AFVFileType.Audio)
        if self.audioVC != nil {
            parent.addChild(self.audioVC)
            audioVC.view.frame = container.frame
            container.addSubview(audioVC.view)
            audioVC.didMove(toParent: (parent.self as! UIViewController))
            self.audioVC.configure(color: color)
            self.audioVC.showAudio(fileName: fileName)
        }else{
            defaultView(parent: parent as! UIViewController, container: container)
        }
    }
    
    public func addVideoController(parent:AnyObject, container: UIView, color: UIColor, fileName: String){
        
        self.startController(fileType: AFVFileType.Video)
        if self.videoVC != nil {
            parent.addChild(self.videoVC)
            videoVC.view.frame = container.frame
            videoVC.view.frame.origin.x = 0
            videoVC.view.frame.origin.y = 0
            container.addSubview(videoVC.view)
            videoVC.didMove(toParent: (parent.self as! UIViewController))
            self.videoVC.configure(color: color)
            self.videoVC.setFileName(fileName: fileName)
        }else{
            defaultView(parent: parent as! UIViewController, container: container)
        }
    }
    
    public func addVideoControllerWithPath(parent:AnyObject, container: UIView, color: UIColor, path:String){
        
        self.startController(fileType: AFVFileType.Video)
        if self.videoVC != nil {
            parent.addChild(self.videoVC)
            videoVC.view.frame = container.frame
            videoVC.view.frame.origin.x = 0
            videoVC.view.frame.origin.y = 0
            container.addSubview(videoVC.view)
            videoVC.didMove(toParent: (parent.self as! UIViewController))
            self.videoVC.configure(color: color)
            self.videoVC.setPath(path: path)
        }else{
            defaultView(parent: parent as! UIViewController, container: container)
        }
    }
    
    public func addImageController(parent:AnyObject, container: UIView, fileName: String){
        self.startController(fileType: AFVFileType.Image)
        if self.imageVC != nil {
            parent.addChild(self.imageVC)
            imageVC.view.frame = container.frame
            imageVC.view.frame.origin.x = 0
            imageVC.view.frame.origin.y = 0
            container.addSubview(imageVC.view)
            imageVC.didMove(toParent: (parent.self as! UIViewController))
            self.imageVC.loadImage(fileName: fileName)
            
        }else{
            defaultView(parent: parent as! UIViewController , container: container)
        }
    }
    
    public func addImageControllerWithImage(parent:AnyObject, container: UIView, image: UIImage, fileName: String){
        self.startController(fileType: AFVFileType.Image)
        if self.imageVC != nil {
            parent.addChild(self.imageVC)
            imageVC.view.frame = container.frame
            imageVC.view.frame.origin.x = 0
            imageVC.view.frame.origin.y = 0
            container.addSubview(imageVC.view)
            imageVC.didMove(toParent: (parent.self as! UIViewController))
            self.imageVC.loadImage(image: image, fileName: fileName)
            
        }else{
            defaultView(parent: parent as! UIViewController , container: container)
        }
    }
    
    public func addDocumentController(parent:AnyObject, container: UIView, fileName: String){
        self.startController(fileType: AFVFileType.Document)
        if self.documentVC != nil {
            parent.addChild(self.documentVC)
            documentVC.view.frame = container.frame
            documentVC.view.frame.origin.x = 0
            documentVC.view.frame.origin.y = 0
            container.addSubview(documentVC.view)
            documentVC.didMove(toParent: (parent.self as! UIViewController))
            documentVC.loadDocument(fileName: fileName)
        }else{
            defaultView(parent: parent as! UIViewController, container: container)
        }
    }
    
    public func addDocumentControllerWithPath(parent:AnyObject, container: UIView, path: String){
        self.startController(fileType: AFVFileType.Document)
        if self.documentVC != nil {
            parent.addChild(self.documentVC)
            documentVC.view.frame = container.frame
            documentVC.view.frame.origin.x = 0
            documentVC.view.frame.origin.y = 0
            container.addSubview(documentVC.view)
            documentVC.didMove(toParent: (parent.self as! UIViewController))
            documentVC.loadDocumentInPath(path: path)
        }else{
            defaultView(parent: parent as! UIViewController, container: container)
        }
    }
    
    public func startController(fileType: AFVFileType){
        let storyboard = UIStoryboard(name: "Viewer", bundle: Utils.getBundle())
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
    private func defaultView(parent:UIViewController, container: UIView){
        let storyboard = UIStoryboard(name: "Viewer", bundle: nil)
        let defaultVC = storyboard.instantiateViewController(withIdentifier: "DefualtViewController") as? DefualtViewController
        parent.addChild(defaultVC!)
        defaultVC!.view.frame = container.frame
        container.addSubview(defaultVC!.view)
        defaultVC!.didMove(toParent: parent.self)
    
    }
  
}
