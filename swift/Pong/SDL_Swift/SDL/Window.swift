import Foundation

extension SDL {

    class Window {
        var window: OpaquePointer
        
        var title: String {
            set(text) {
                SDL_SetWindowTitle(window,text)
            }
            
            get {
                return String(cString: SDL_GetWindowTitle(window))
            }
        }
        
        /// Create a window
        ///
        /// Usage:
        ///
        ///     let window = Window(title: "Title of the window", x: 10, y: 20, width: 1024, height: 768)
        ///
        /// - Parameters:
        ///     - title: The title of the window
        ///     - x: Horizontal position
        ///     - y: Vertical position
        ///     - width: Width of the window
        ///     - height: Height of the window
        init(title: String, x: Int, y: Int, width: Int, height: Int) {
            window = SDL_CreateWindow(title, CInt(x), CInt(y), CInt(width), CInt(height), 0)
        }
        
        deinit {
            SDL_DestroyWindow(window)
        }
    }
}
