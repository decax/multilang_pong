import Foundation

class Paddle {
    let paddleWidth = 10
    let paddleHeight = 100

    let width: Int
    let height: Int
    
    let renderer: SDL.Renderer
    let surface: SDL.Surface
    let texture: SDL.Texture
    
    let positionX: Double
    var positionY = 0.0
    var speed = 0.0 // pixels per seconds
    
    let maxSpeed = 150.0
    
    init(renderer: SDL.Renderer, x: Int, y: Int) {
        
        positionX = Double(x)
        positionY = Double(y)
        
        width = paddleWidth
        height = paddleHeight
        
        self.renderer = renderer
        surface = SDL.Surface(width: paddleWidth, height: paddleHeight, pixelFormat: .rgba8888)
        surface.Fill(color: Color(red: 255, green: 255, blue: 255))
        
        texture = SDL.Texture(renderer: renderer, fromSurface: surface)
    }
    
    func moveDown() {
        speed = maxSpeed
    }
    
    func moveUp() {
        speed = -maxSpeed
    }
    
    func stopMove() {
        speed = 0.0
    }
    
    func update(elapsedTime: Double) {
        positionY = positionY + speed * elapsedTime
        
//        print("\(positionY)")
    }
    
    func draw() {
        let rect = Rectangle(x: Int(positionX), y: Int(positionY), width: width, height: height)
        
        renderer.copy(texture: texture, destinationRect: rect)
    }
}
