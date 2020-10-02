import Foundation

struct SDL {

    struct System: OptionSet {
        let rawValue: Int
        
        static let timer          = System(rawValue: 0x01)
        static let audio          = System(rawValue: 0x10)
        static let video          = System(rawValue: 0x20)
        static let joystick       = System(rawValue: 0x200)
        static let haptic         = System(rawValue: 0x1000)
        static let gameController = System(rawValue: 0x2000)
        static let events         = System(rawValue: 0x4000)
        static let noParachute    = System(rawValue: 0x100000)

        static let Everything: System = [.timer, .audio, .video, .joystick, .haptic, .gameController, .events]
    }

    /**
     Initializes the subsystems specified by systems.
     
     - Parameter systems: The system to be initialized
     
        
     # Example
     ```
     SDL_Init(system: [.video, .gameController, .events]
     ```
     
     */
    static func Init(system: System) {
        SDL_Init(CUnsignedInt(system.rawValue))
    }

    /**
     Cleans up all initialized subsystems.
     You should call it upon all exit conditions.
     */
    static func Quit() {
        SDL_Quit()
    }
    
    static func ShowSimpleMessageBox(title: String, message: String) {
        SDL_ShowSimpleMessageBox(0, title, message, nil);
    }
}

struct Point {
    var x: Int
    var y: Int
}

struct Size {
    var width: Int
    var height: Int
}

struct Rectangle {
    var x: Int
    var y: Int
    var width: Int
    var height: Int
    
    static func +=(left: inout Rectangle, offset: Point) {
        
        left.x += offset.x
        left.y += offset.y
    }
}

struct Color {
    var red: UInt8
    var green: UInt8
    var blue: UInt8
    var alpha: UInt8
    
    init(red: UInt8, green: UInt8, blue: UInt8, alpha: UInt8) {
        self.red = red
        self.green = green
        self.blue = blue
        self.alpha = alpha
    }
    
    init(red: UInt8, green: UInt8, blue: UInt8) {
        self.init(red: red, green: green, blue: blue, alpha: 255)
    }
    
    static var white = Color(red: 255, green: 255, blue: 255)
    static var black = Color(red: 0, green: 0, blue: 0)
    static var red_ = Color(red: 255, green: 0, blue: 0)
    static var green_ = Color(red: 0, green: 255, blue: 0)
    static var blue_ = Color(red: 0, green: 0, blue: 255)
}
