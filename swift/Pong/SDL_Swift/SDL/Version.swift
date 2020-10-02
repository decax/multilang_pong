//
//  Version.swift
//  SDL_Swift
//
//  Created by Dominic Hudon on 18-02-04.
//  Copyright © 2018 Dominic Hudon. All rights reserved.
//

import Foundation

extension SDL {

struct Version {
    var major: Int
    var minor: Int
    var patch: Int
}

static func GetVersion() -> Version {
    var version = SDL_version(major: 0, minor: 0, patch: 0)
    
    SDL_GetVersion(&version)
    return Version(major: Int(version.major), minor: Int(version.minor), patch: Int(version.patch))
}

}
