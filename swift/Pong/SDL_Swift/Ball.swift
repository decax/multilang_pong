import Foundation

class Ball {
    static let Width = 10
    static let Height = 10

    let renderer: SDL.Renderer
    let surface: SDL.Surface
    let texture: SDL.Texture
    
    var positionX = 0.0
    var positionY = 0.0
    
    var speedX = 0.0 // pixels per seconds
    var speedY = 0.0
    
    let maxSpeed = 150.0
    
    init(renderer: SDL.Renderer, x: Int, y: Int) {
        
        self.renderer = renderer
        surface = SDL.Surface(width: Ball.Width, height: Ball.Height, pixelFormat: .rgba8888)
        surface.Fill(color: Color(red: 255, green: 255, blue: 255))
        
        texture = SDL.Texture(renderer: renderer, fromSurface: surface)

        reset(x: x, y: y)        
    }
    
    func reset(x: Int, y: Int) {
        positionX = Double(x)
        positionY = Double(y)
        
        speedX = maxSpeed * (Int.random(in: 0...1) == 0 ? -1.0 : 1.0)
        speedY = maxSpeed * (Int.random(in: 0...1) == 0 ? -1.0 : 1.0)
    }
    
    func update(elapsedTime: Double) {
        positionX = positionX + speedX * elapsedTime
        positionY = positionY + speedY * elapsedTime
    }
    
    func draw() {
        let rect = Rectangle(x: Int(positionX), y: Int(positionY), width: Ball.Width, height: Ball.Height)
        
        renderer.copy(texture: texture, destinationRect: rect)
    }
}
