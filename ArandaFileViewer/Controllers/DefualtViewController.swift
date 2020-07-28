//
//  DefualtViewController.swift
//  ArandaFileViewer
//
//  Created by Enar GoMez on 27/07/20.
//  Copyright © 2020 Aranda. All rights reserved.
//

import UIKit

class DefualtViewController: UIViewController {

    @IBOutlet weak var imgError: UIImageView!
    @IBOutlet weak var lblError: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.lblError.text = Utils.stringNamed("Preview_not_available")
        
    }
    

}
