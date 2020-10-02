//
//  Texture.swift
//  SDL_Swift
//
//  Created by Dominic Hudon on 18-02-04.
//  Copyright © 2018 Dominic Hudon. All rights reserved.
//

import Foundation

extension SDL {

    class Texture {
        var texture: OpaquePointer
        var width: UInt
        var height: UInt
        
        init(renderer: Renderer, fromSurface: Surface) {
            texture = SDL_CreateTextureFromSurface(renderer.renderer, fromSurface.surface)
            width = fromSurface.width
            height = fromSurface.height
        }
        
        init?(renderer: Renderer, filename: String) {
            guard let texture = IMG_LoadTexture(renderer.renderer, filename) else { return nil }
            
            var width = Int32()
            var height = Int32()
            
            guard SDL_QueryTexture(texture, nil, nil, &width, &height) >= 0 else { return nil }
            
            self.texture = texture
            self.width = UInt(width)
            self.height = UInt(height)
        }
        
        deinit {
            SDL_DestroyTexture(texture)
        }
        
        var colorMod: Color {
            get {
               return Color.white
            }
            
            set(color) {
                SDL_SetTextureColorMod(texture, color.red, color.green, color.blue)
            }
        }
        
        var alphaMod: UInt8 {
            get {
                var alpha: UInt8 = 0
                
                SDL_GetTextureAlphaMod(texture, &alpha)

                return alpha;
            }
            
            set(alpha) {
                SDL_SetTextureAlphaMod(texture, alpha)
            }
        }
    }
}
