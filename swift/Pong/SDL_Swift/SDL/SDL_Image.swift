//
//  SDL_Image.swift
//  SDL_Swift
//
//  Created by Dominic Hudon on 18-02-10.
//  Copyright © 2018 Dominic Hudon. All rights reserved.
//

import Foundation

//typedef enum
//{
//    IMG_INIT_JPG = 0x00000001,
//    IMG_INIT_PNG = 0x00000002,
//    IMG_INIT_TIF = 0x00000004,
//    IMG_INIT_WEBP = 0x00000008
//} IMG_InitFlags;
struct SDL_Image {

static func Init() {
    IMG_Init(Int32(IMG_INIT_PNG.rawValue))
}

static func Quit() {
    IMG_Quit()
}
    
}
