//
//  Enumerations.swift
//  ArandaFileViewer
//
//  Created by Enar GoMez on 27/07/20.
//  Copyright © 2020 Aranda. All rights reserved.
//

import Foundation

import Foundation


public enum AFVFileType: String{
    case Video = "public.movie"
    case Image = "public.image"
    case Audio = "public.audio"
    case Document = "document"
    case Unknown = "unknown"
}

enum AFVErrorEnum {
    case AFVError
}
