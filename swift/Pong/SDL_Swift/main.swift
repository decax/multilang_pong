import Foundation

print("SDL Version: \(SDL.GetVersion())")

SDL.Init(system: [.video, .audio, .events])
SDL_Image.Init()

for driver in SDL.Renderer.GetDriversInfos() {
    print("\(driver.name) min: \(driver.maxTextureWidth) max: \(driver.maxTextureHeight)")
}

let screenWidth = 1024
let screenHeight = 768

let paddleWidth = 10
let paddleHeight = 100
let paddle1X = 20
let paddle2X = screenWidth - (paddle1X + paddleWidth)
let paddleY = (screenHeight - paddleHeight) / 2

let ballX = (screenWidth - Ball.Width) / 2
let ballY = (screenHeight - Ball.Height) / 2

var window = SDL.Window(title: "Swift Pong", x: 100, y: 100, width: screenWidth, height: screenHeight);
var renderer = SDL.Renderer(window: window, flags: .software)

renderer.drawColor = Color.black
let _ = renderer.drawColor

let paddle1 = Paddle(renderer: renderer, x: paddle1X, y: paddleY)
let paddle2 = Paddle(renderer: renderer, x: paddle2X, y: paddleY)
let ball = Ball(renderer: renderer, x: ballX, y: ballY)

//let surface2 = SDL.Surface(filename: "Axel.png")!
//
////let texture = SDL.Texture(renderer: renderer, fromSurface: surface)
//let texture2 = SDL.Texture(renderer: renderer, fromSurface: surface2)
//let texture3 = SDL.Texture(renderer: renderer, filename: "Axel.png")!

var offset = 150

var running = true
let keyboard = SDL.Keyboard()

var previousTime = SDL.GetTicks()

while running {
    
    let now = SDL.GetTicks()
    let elapsedTime = Double(now - previousTime) / 1000.0
    previousTime = now

    if let event = SDL.PollEvent() {
        
        switch event.id {
        
        case .quit:
            running = false
        
        case .keyDown:
            if let keyboardEvent = event as? SDL.KeyboardEvent {
                
                switch keyboardEvent.keySym.scancode {
               
                case .escape:
                    running = false

                case .enter:
                    SDL.ShowSimpleMessageBox(title: "patate", message: "salut patate")
                    
                case .q:
                    paddle1.moveUp();
                    
                case .a:
                    paddle1.moveDown();

                case .up:
                    paddle2.moveUp()

                case .down:
                    paddle2.moveDown()
                    
                default:
                    offset /= 2
                }
                
                if keyboardEvent.keySym.mod.contains([.leftShift, .rightShift]) {
                    print("LEFT & RIGHT SHIIIIIIFT")
                }
            }
        
        case .keyUp:
            if let keyboardEvent = event as? SDL.KeyboardEvent {
               
                switch keyboardEvent.keySym.scancode {
                
                case .q:
                    fallthrough
                case .a:
                    paddle1.stopMove()

                case .up:
                    fallthrough
                case .down:
                    paddle2.stopMove()

                default:
                    ()
                }
            }
            
        default:
            ()
        }
    }

    paddle1.update(elapsedTime: elapsedTime)
    paddle2.update(elapsedTime: elapsedTime)
    ball.update(elapsedTime: elapsedTime)

    renderer.clear()
    
//    renderer.copy(texture: texture, position: Point(x: 50, y: 50))
//    renderer.copy(texture: texture2, destinationRect: Rectangle(x: 200, y: 0, width: Int(texture2.width / 4), height: Int(texture2.height / 4)))
//
//    renderer.drawBlendMode = .none
//    texture3.alphaMod = 85
//
//    var rect = Rectangle(x: 0, y: 200, width: Int(texture3.width / 4), height: Int(texture3.height / 4))
//
//    rect.x = 200 - offset
//    texture3.colorMod = Color.red_
//    renderer.copy(texture: texture3, destinationRect: rect)
//
//    rect.x = 200
//    texture3.colorMod = Color.green_
//    renderer.copy(texture: texture3, destinationRect: rect)
//
//    rect.x = 200 + offset
//    texture3.colorMod = Color.blue_
//    renderer.copy(texture: texture3, destinationRect: rect)
//
    paddle1.draw()
    paddle2.draw()
    ball.draw()
    
    renderer.present()
    
    SDL.Delay(ms: 1)
}

SDL_Image.Quit()
SDL.Quit()
