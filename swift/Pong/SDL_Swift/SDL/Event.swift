//
//  Event.swift
//  SDL_Swift
//
//  Created by Dominic Hudon on 18-02-18.
//  Copyright © 2018 Dominic Hudon. All rights reserved.
//

import Foundation

extension SDL {
    
    struct Kind: RawRepresentable, Equatable {
        var rawValue: SDL_EventType
        
        // Application events
        static let quit    = Kind(rawValue: SDL_QUIT)
        
        // These application events have special meaning on iOS
        static let appTerminating         = Kind(rawValue: SDL_APP_TERMINATING)
        static let appLowMemory           = Kind(rawValue: SDL_APP_LOWMEMORY)
        static let appWillEnterBackground = Kind(rawValue: SDL_APP_WILLENTERBACKGROUND)
        static let appDidEnterBackground  = Kind(rawValue: SDL_APP_DIDENTERBACKGROUND)
        static let appWillEnterForeground = Kind(rawValue: SDL_APP_WILLENTERFOREGROUND)
        static let appDidEnterForeground  = Kind(rawValue: SDL_APP_DIDENTERFOREGROUND)
        
        // Window events
        static let windowEvent = Kind(rawValue: SDL_WINDOWEVENT)
        static let systemEvent = Kind(rawValue: SDL_SYSWMEVENT)

        // Keyboard events
        static let keyDown       = Kind(rawValue: SDL_KEYDOWN)
        static let keyUp         = Kind(rawValue: SDL_KEYUP)
        static let textEditing   = Kind(rawValue: SDL_TEXTEDITING)
        static let textInput     = Kind(rawValue: SDL_TEXTINPUT)
        static let keymapChanged = Kind(rawValue: SDL_KEYMAPCHANGED)
        
        // Mouse events
        static let mouseMotion     = Kind(rawValue: SDL_MOUSEMOTION)
        static let mouseButtonDown = Kind(rawValue: SDL_MOUSEBUTTONDOWN)
        static let mouseButtonUp   = Kind(rawValue: SDL_MOUSEBUTTONUP)
        static let mouseWheel      = Kind(rawValue: SDL_MOUSEWHEEL)
    }
    
    class Event {
        var id: Kind
        
        init(id: Kind) {
            self.id = id
        }
    }
    
//    typedef struct SDL_WindowEvent
//    {
//        Uint32 type;        /**< ::SDL_WINDOWEVENT */
//        Uint32 timestamp;   /**< In milliseconds, populated using SDL_GetTicks() */
//        Uint32 windowID;    /**< The associated window */
//        Uint8 event;        /**< ::SDL_WindowEventID */
//        Uint8 padding1;
//        Uint8 padding2;
//        Uint8 padding3;
//        Sint32 data1;       /**< event dependent data */
//        Sint32 data2;       /**< event dependent data */
//    } SDL_WindowEvent;
    
    class WindowEvent: Event {
        
        var timestamp: UInt
        
        init(internalEvent e: SDL_WindowEvent) {
        
            timestamp = UInt(e.timestamp)
            
            super.init(id: .windowEvent)
        }
    }
    
//    typedef struct SDL_KeyboardEvent
//    {
//        Uint32 type;        /**< ::SDL_KEYDOWN or ::SDL_KEYUP */
//        Uint32 timestamp;   /**< In milliseconds, populated using SDL_GetTicks() */
//        Uint32 windowID;    /**< The window with keyboard focus, if any */
//        Uint8 state;        /**< ::SDL_PRESSED or ::SDL_RELEASED */
//        Uint8 repeat;       /**< Non-zero if this is a key repeat */
//        Uint8 padding2;
//        Uint8 padding3;
//        SDL_Keysym keysym;  /**< The key that was pressed or released */
//    } SDL_KeyboardEvent;
    
    class KeyboardEvent: Event {
        
        enum State {
            case pressed, released
        }
        
        var state: State
        var keySym: Keysym
        
        init(internalEvent e: SDL_KeyboardEvent) {
            state = e.state == SDL_PRESSED ? .pressed : .released
            keySym = Keysym(scancode: Scancode(rawValue: e.keysym.scancode), keycode: Keycode(rawValue: Int(e.keysym.sym)), mod: Keymod(rawValue: Int(e.keysym.mod)))
            
            super.init(id: SDL_EventType(e.type) == SDL_KEYDOWN ? .keyDown : .keyUp)
        }
    }
    
    static func PollEvent() -> Event? {
        var e: SDL_Event = SDL_Event(type: 0)
        
        let retVal = SDL_PollEvent(&e)
        if retVal == 0 {
            return nil
        }
        
        switch SDL_EventType(e.type) {
        
        case SDL_QUIT:
            return Event(id: .quit)
            
        case SDL_KEYDOWN:
            return KeyboardEvent(internalEvent: e.key)
            
        case SDL_KEYUP:
            return KeyboardEvent(internalEvent: e.key)
        
        default:
            ()
        }
        
        return nil
    }
}
