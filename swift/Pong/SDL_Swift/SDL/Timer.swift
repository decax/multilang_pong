//
//  Timer.swift
//  SDL_Swift
//
//  Created by Dominic Hudon on 18-02-04.
//  Copyright © 2018 Dominic Hudon. All rights reserved.
//

import Foundation

extension SDL {

static func GetTicks() -> UInt {
    return UInt(SDL_GetTicks())
}

static func Delay(ms: UInt) {
    SDL_Delay(CUnsignedInt(ms))
}
//typedef Uint32 (SDLCALL * SDL_TimerCallback) (Uint32 interval, void *param);

//extern DECLSPEC SDL_TimerID SDLCALL SDL_AddTimer(Uint32 interval, SDL_TimerCallback callback, void *param);
static func AddTimer(interval: UInt, callback: @escaping ((UInt) -> UInt)) -> Int {
//    let unmanaged = Unmanaged.passRetained(callback)
//    let timerId = SDL_AddTimer(UInt32(interval), { (_ interval, _ param) -> CUnsignedInt in
//        return CUnsignedInt(callback(UInt(interval)))
//    }, nil)
//
//    return Int(timerId)
    return 0
}

static func RemoveTimer(id: Int) {
    SDL_RemoveTimer(CInt(id))
}


}
