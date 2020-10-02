//
//  Surface.swift
//  SDL_Swift
//
//  Created by Dominic Hudon on 18-02-04.
//  Copyright © 2018 Dominic Hudon. All rights reserved.
//

import Foundation

extension SDL {

    class Surface {
        
        var surface: UnsafeMutablePointer<SDL_Surface>
        var width: UInt
        var height: UInt
        
        struct PixelFormat : OptionSet {
            let rawValue: Int
            
            static let rgba8888 = PixelFormat(rawValue: Int(SDL_PIXELFORMAT_RGBA8888.rawValue))
        }
        
        init(width: Int, height: Int, depth: Int, rmask: Int, gmask: Int, bmask: Int, amask: Int) {
            surface = SDL_CreateRGBSurface(0, CInt(width), CInt(height), CInt(depth), CUnsignedInt(rmask), CUnsignedInt(gmask), CUnsignedInt(bmask), CUnsignedInt(amask))
            
            self.width = UInt(surface.pointee.w)
            self.height = UInt(surface.pointee.h)
        }
        
        init(width: Int, height: Int, pixelFormat: PixelFormat) {
            
            var depth = 0
            
            switch pixelFormat {
            case .rgba8888:
                depth = 32
            
            default:
                depth = 0
            }
            
            surface = SDL_CreateRGBSurfaceWithFormat(0, CInt(width), CInt(height), CInt(depth), UInt32(pixelFormat.rawValue))
            
            self.width = UInt(width)
            self.height = UInt(height)
        }
        
        init?(filename: String) {
            guard let surface = IMG_Load(filename) else { return nil }

            self.surface = surface
            self.width = UInt(self.surface.pointee.w)
            self.height = UInt(self.surface.pointee.h)
        }
        
        deinit {
            SDL_FreeSurface(surface)
        }
        
        func Fill(color: Color) {
            let r32 = UInt32(color.red) << 24
            let g32 = UInt32(color.green) << 16
            let b32 = UInt32(color.blue) << 8
            let a32 = UInt32(color.alpha) << 0
            let c = r32 + g32 + b32 + a32
            
            SDL_FillRect(surface, nil, c);
        }
        
        func FillRect(rectangle: Rectangle, color: Color) {
            
            var rect = SDL_Rect(x: Int32(rectangle.x), y: Int32(rectangle.y), w: Int32(rectangle.width), h: Int32(rectangle.height))
            
            // Expression was too complex to be solved in reasonable time; consider breaking up the expression into distinct sub-expressions
            //let c = UInt32(color.red) << 24 + UInt32(color.green) << 16 + UInt32(color.blue) << 8 + UInt32(color.alpha)
            
            let r32 = UInt32(color.red) << 24
            let g32 = UInt32(color.green) << 16
            let b32 = UInt32(color.blue) << 8
            let a32 = UInt32(color.alpha) << 0
            let c = r32 + g32 + b32 + a32
            
            SDL_FillRect(surface, &rect, c);
        }
    }
}
