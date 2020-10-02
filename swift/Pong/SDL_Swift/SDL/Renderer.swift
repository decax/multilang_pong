//
//  Renderer.swift
//  SDL_Swift
//
//  Created by Dominic Hudon on 18-02-04.
//  Copyright © 2018 Dominic Hudon. All rights reserved.
//

import Foundation

extension SDL {
    class Renderer {
        //typedef struct SDL_RendererInfo
        //{
        //    const char *name;           /**< The name of the renderer */
        //    Uint32 flags;               /**< Supported ::SDL_RendererFlags */
        //    Uint32 num_texture_formats; /**< The number of available texture formats */
        //    Uint32 texture_formats[16]; /**< The available texture formats */
        //    int max_texture_width;      /**< The maximum texture width */
        //    int max_texture_height;     /**< The maximum texture height */
        //} SDL_RendererInfo;
        struct Info {
            var name: String
            var textureFormats: [Int]
            var maxTextureWidth: Int
            var maxTextureHeight: Int
        }
        
        class func GetDriversInfos() -> [Info] {
            var rendererInfos = [Renderer.Info]()
            
            let numRenderDrivers = SDL_GetNumRenderDrivers()
            for i in 0..<numRenderDrivers {
                var rendererInfo = SDL_RendererInfo(name: nil, flags: 0, num_texture_formats: 0, texture_formats: (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0), max_texture_width: 0, max_texture_height: 0)
                SDL_GetRenderDriverInfo(i, &rendererInfo)
                
                let ri = Renderer.Info(name: String(cString: rendererInfo.name), textureFormats: [0], maxTextureWidth: Int(rendererInfo.max_texture_width), maxTextureHeight: Int(rendererInfo.max_texture_height))
                rendererInfos.append(ri)
            }
            
            return rendererInfos
        }
        
        struct Flag : OptionSet {
            let rawValue: Int
            
            static let software      = Flag(rawValue: Int(SDL_RENDERER_SOFTWARE.rawValue))
            static let accelerated   = Flag(rawValue: Int(SDL_RENDERER_ACCELERATED.rawValue))
            static let presentVSync  = Flag(rawValue: Int(SDL_RENDERER_PRESENTVSYNC.rawValue))
            static let targetTexture = Flag(rawValue: Int(SDL_RENDERER_TARGETTEXTURE.rawValue))
        }
        
        var renderer: OpaquePointer
        
        init(window: Window, flags: Flag) {
            renderer = SDL_CreateRenderer(window.window, -1, UInt32(flags.rawValue))
        }
        
        deinit {
            SDL_DestroyRenderer(renderer)
        }
        
        func clear() {
            SDL_RenderClear(renderer)
        }
        
        func present() {
            SDL_RenderPresent(renderer)
        }
        
        var drawColor: Color {
            get {
                var r: UInt8 = 0
                var g: UInt8 = 0
                var b: UInt8 = 0
                var a: UInt8 = 0
                
                SDL_GetRenderDrawColor(renderer, &r, &g, &b, &a);
                
                return Color(red: r, green: g, blue: b, alpha: a)
            }
            set(color) {
                SDL_SetRenderDrawColor(renderer, color.red, color.green, color.blue, color.alpha);
            }
        }
        
        func getDrawColor() -> Color {
            var r: UInt8 = 0
            var g: UInt8 = 0
            var b: UInt8 = 0
            var a: UInt8 = 0

            SDL_GetRenderDrawColor(renderer, &r, &g, &b, &a);
            
            return Color(red: r, green: g, blue: b, alpha: a)
        }
        
        func setDrawColor(color: Color) {
            SDL_SetRenderDrawColor(renderer, color.red, color.green, color.blue, color.alpha);
        }

    //    SDL_BLENDOPERATION_ADD              = 0x1,  /**< dst + src: supported by all renderers */
    //    SDL_BLENDOPERATION_SUBTRACT         = 0x2,  /**< dst - src : supported by D3D9, D3D11, OpenGL, OpenGLES */
    //    SDL_BLENDOPERATION_REV_SUBTRACT     = 0x3,  /**< src - dst : supported by D3D9, D3D11, OpenGL, OpenGLES */
    //    SDL_BLENDOPERATION_MINIMUM          = 0x4,  /**< min(dst, src) : supported by D3D11 */
    //    SDL_BLENDOPERATION_MAXIMUM          = 0x5   /**< max(dst, src) : supported by D3D11 */
        
    //    SDL_BLENDMODE_NONE = 0x00000000,     /**< no blending
    //                      dstRGBA = srcRGBA */
    //    SDL_BLENDMODE_BLEND = 0x00000001,    /**< alpha blending
    //     dstRGB = (srcRGB * srcA) + (dstRGB * (1-srcA))
    //     dstA = srcA + (dstA * (1-srcA)) */
    //    SDL_BLENDMODE_ADD = 0x00000002,      /**< additive blending
    //     dstRGB = (srcRGB * srcA) + dstRGB
    //     dstA = dstA */
    //    SDL_BLENDMODE_MOD = 0x00000004,      /**< color modulate
    //     dstRGB = srcRGB * dstRGB
    //     dstA = dstA */
    //    SDL_BLENDMODE_INVALID = 0x7FFFFFFF

        enum BlendMode: Int {
            case none  = 0
            case blend = 1
            case add   = 2
            case mod   = 4
        }
        
        var drawBlendMode: BlendMode {
            get {
                var mode: SDL_BlendMode = SDL_BLENDMODE_NONE
                
                SDL_GetRenderDrawBlendMode(renderer, &mode)
                
                return BlendMode(rawValue: Int(mode.rawValue))!
            }
            
            set(mode) {
                SDL_SetRenderDrawBlendMode(renderer, SDL_BlendMode(UInt32(mode.rawValue)))
            }
        }
        
        func copy(texture: Texture, position: Point) {
            var dstRectangle = SDL_Rect(x: Int32(position.x), y: Int32(position.y), w: Int32(texture.width), h: Int32(texture.height))
            
            SDL_RenderCopy(renderer, texture.texture, nil, &dstRectangle)
        }
        
        func copy(texture: Texture, destinationRect: Rectangle) {
            var dstRectangle = SDL_Rect(x: Int32(destinationRect.x), y: Int32(destinationRect.y), w: Int32(destinationRect.width), h: Int32(destinationRect.height))
            
            SDL_RenderCopy(renderer, texture.texture, nil, &dstRectangle)
        }
    }
}
