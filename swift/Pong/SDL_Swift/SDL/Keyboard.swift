//
//  Keyboard.swift
//  SDL_Swift
//
//  Created by Dominic Hudon on 18-02-20.
//  Copyright © 2018 Dominic Hudon. All rights reserved.
//

import Foundation

extension SDL {
    struct Scancode: RawRepresentable, Equatable {
        let rawValue: SDL_Scancode

        static let a = Scancode(rawValue: SDL_SCANCODE_A)
        static let b = Scancode(rawValue: SDL_SCANCODE_B)
        static let c = Scancode(rawValue: SDL_SCANCODE_C)
        static let d = Scancode(rawValue: SDL_SCANCODE_D)
        static let e = Scancode(rawValue: SDL_SCANCODE_E)
        static let f = Scancode(rawValue: SDL_SCANCODE_F)
        static let g = Scancode(rawValue: SDL_SCANCODE_G)
        static let h = Scancode(rawValue: SDL_SCANCODE_H)
        static let i = Scancode(rawValue: SDL_SCANCODE_I)
        static let j = Scancode(rawValue: SDL_SCANCODE_J)
        static let k = Scancode(rawValue: SDL_SCANCODE_K)
        static let l = Scancode(rawValue: SDL_SCANCODE_L)
        static let m = Scancode(rawValue: SDL_SCANCODE_M)
        static let n = Scancode(rawValue: SDL_SCANCODE_N)
        static let o = Scancode(rawValue: SDL_SCANCODE_O)
        static let p = Scancode(rawValue: SDL_SCANCODE_P)
        static let q = Scancode(rawValue: SDL_SCANCODE_Q)
        static let r = Scancode(rawValue: SDL_SCANCODE_R)
        static let s = Scancode(rawValue: SDL_SCANCODE_S)
        static let t = Scancode(rawValue: SDL_SCANCODE_T)
        static let u = Scancode(rawValue: SDL_SCANCODE_U)
        static let v = Scancode(rawValue: SDL_SCANCODE_V)
        static let w = Scancode(rawValue: SDL_SCANCODE_W)
        static let x = Scancode(rawValue: SDL_SCANCODE_X)
        static let y = Scancode(rawValue: SDL_SCANCODE_Y)
        static let z = Scancode(rawValue: SDL_SCANCODE_Z)

        static let escape   = Scancode(rawValue: SDL_SCANCODE_ESCAPE)
        static let enter    = Scancode(rawValue: SDL_SCANCODE_RETURN)

        static let right    = Scancode(rawValue: SDL_SCANCODE_RIGHT)
        static let left     = Scancode(rawValue: SDL_SCANCODE_LEFT)
        static let down     = Scancode(rawValue: SDL_SCANCODE_DOWN)
        static let up       = Scancode(rawValue: SDL_SCANCODE_UP)
    }
    
    struct Keycode: RawRepresentable, Equatable {
        let rawValue: Int
        
        static let enter       = Keycode(rawValue: SDLK_RETURN)
        static let escape      = Keycode(rawValue: SDLK_ESCAPE)
        static let backspace   = Keycode(rawValue: SDLK_BACKSPACE)
        static let tab         = Keycode(rawValue: SDLK_TAB)
        static let space       = Keycode(rawValue: SDLK_SPACE)
        static let exclaim     = Keycode(rawValue: SDLK_EXCLAIM)
        static let doubleQuote = Keycode(rawValue: SDLK_QUOTEDBL)
        static let hash        = Keycode(rawValue: SDLK_HASH)
        static let percent     = Keycode(rawValue: SDLK_PERCENT)
        static let dollar      = Keycode(rawValue: SDLK_DOLLAR)
        
        static let down        = Keycode(rawValue: SDLK_DOWN)
        static let up          = Keycode(rawValue: SDLK_UP)
        static let left        = Keycode(rawValue: SDLK_LEFT)
        static let right       = Keycode(rawValue: SDLK_RIGHT)

        //        SDLK_AMPERSAND = '&',
        //        SDLK_QUOTE = '\'',
        //        SDLK_LEFTPAREN = '(',
        //        SDLK_RIGHTPAREN = ')',
        //        SDLK_ASTERISK = '*',
        //        SDLK_PLUS = '+',
        //        SDLK_COMMA = ',',
        //        SDLK_MINUS = '-',
    }
    
    struct Keymod: OptionSet {
        let rawValue: Int

        static let none         = Keymod(rawValue: Int(KMOD_NONE.rawValue))
        static let leftShift    = Keymod(rawValue: Int(KMOD_LSHIFT.rawValue))
        static let rightShift   = Keymod(rawValue: Int(KMOD_RSHIFT.rawValue))
        static let leftControl  = Keymod(rawValue: Int(KMOD_LCTRL.rawValue))
        static let rightControl = Keymod(rawValue: Int(KMOD_RCTRL.rawValue))
        static let leftAlt      = Keymod(rawValue: Int(KMOD_LALT.rawValue))
        static let rightAlt     = Keymod(rawValue: Int(KMOD_RALT.rawValue))
        static let leftGui      = Keymod(rawValue: Int(KMOD_LGUI.rawValue))
        static let rightGui     = Keymod(rawValue: Int(KMOD_RGUI.rawValue))
        static let num          = Keymod(rawValue: Int(KMOD_NUM.rawValue))
        static let caps         = Keymod(rawValue: Int(KMOD_CAPS.rawValue))
        static let mode         = Keymod(rawValue: Int(KMOD_MODE.rawValue))
    }
    
    
    //    typedef struct SDL_Keysym
    //    {
    //        SDL_Scancode scancode;      /**< SDL physical key code - see ::SDL_Scancode for details */
    //        SDL_Keycode sym;            /**< SDL virtual key code - see ::SDL_Keycode for details */
    //        Uint16 mod;                 /**< current key modifiers */
    //        Uint32 unused;
    //    } SDL_Keysym;
    struct Keysym {
        var scancode: Scancode
        var keycode: Keycode
        var mod: Keymod
    }
    
    class Keyboard {
        
        private var keyStates = [Bool](repeating: false, count: 255)
        
        subscript(key: Scancode) -> Bool {
            return keyStates[Int(key.rawValue.rawValue)]
        }
        
        func update() {
            let states = SDL_GetKeyboardState(nil)

            for i in 0..<255 {
                keyStates[i] = states![i] == 1
            }
        }
    }
}
