#include <stdio.h>

#include <SDL2/SDL.h>

#define SCREEN_WIDTH 1024
#define SCREEN_HEIGHT 768

#define PADDLE_WIDTH  10
#define PADDLE_HEIGHT 100
#define PADDLE1_X     20
#define PADDLE2_X     (SCREEN_WIDTH - (PADDLE1_X + PADDLE_WIDTH))
#define PADDLE_Y      ((SCREEN_HEIGHT - PADDLE_HEIGHT) / 2)
#define PADDLE_SPEED  250

#define BALL_WIDTH    10
#define BALL_HEIGHT   10
#define BALL_SPEED    250
#define BALL_INITIAL_X ((SCREEN_WIDTH - BALL_WIDTH) / 2)
#define BALL_INITIAL_Y ((SCREEN_HEIGHT - BALL_HEIGHT) / 2)

int collides(int ball_x, int ball_y, int paddle_x, int paddle_y);

int main(int argc, const char * argv[]) {
    
    if (SDL_Init(SDL_INIT_VIDEO) < 0) {
        return 1;
    }
    
    SDL_Window *window;
    SDL_Renderer *renderer;
    
    if (SDL_CreateWindowAndRenderer(SCREEN_WIDTH, SCREEN_HEIGHT, 0, &window, &renderer) < 0) {
        return 1;
    }
    
    Uint32 rmask, gmask, bmask, amask;
    #if SDL_BYTEORDER == SDL_BIG_ENDIAN
        rmask = 0xff000000;
        gmask = 0x00ff0000;
        bmask = 0x0000ff00;
        amask = 0x000000ff;
    #else
        rmask = 0x000000ff;
        gmask = 0x0000ff00;
        bmask = 0x00ff0000;
        amask = 0xff000000;
    #endif
    
    SDL_Surface *paddleSurface = SDL_CreateRGBSurface(SDL_SWSURFACE, PADDLE_WIDTH, PADDLE_HEIGHT, 32, rmask, gmask, bmask, amask);
    SDL_FillRect(paddleSurface, NULL, 0xFFFFFFFF);
    SDL_Texture *paddleTexture = SDL_CreateTextureFromSurface(renderer, paddleSurface);

    SDL_Surface *ballSurface = SDL_CreateRGBSurface(SDL_SWSURFACE, BALL_WIDTH, BALL_HEIGHT, 32, rmask, gmask, bmask, amask);
    SDL_FillRect(ballSurface, NULL, 0xFFFFFFFF);
    SDL_Texture *ballTexture = SDL_CreateTextureFromSurface(renderer, ballSurface);

    // objects states
    float paddle1_x = 0, paddle1_y = 0;
    float paddle2_x = 0, paddle2_y = 0;
    float ball_x = 0, ball_y = 0;
    
    float ball_speed_x = BALL_SPEED;
    float ball_speed_y = BALL_SPEED;
    
    SDL_Rect paddle1_rect = {
        .x = 0,
        .y = 0,
        .w = PADDLE_WIDTH,
        .h = PADDLE_HEIGHT
    };

    SDL_Rect paddle2_rect = {
        .x = 0,
        .y = 0,
        .w = PADDLE_WIDTH,
        .h = PADDLE_HEIGHT
    };

    SDL_Rect ball_rect = {
        .x = 0,
        .y = 0,
        .w = BALL_WIDTH,
        .h = BALL_HEIGHT
    };

    int previous_ticks = SDL_GetTicks();
    
    int running = 1;
    int reset_game = 1;
    
    while (running) {
        
        int ticks = SDL_GetTicks();
        
        float deltaTime = (ticks - previous_ticks) / 1000.f;
        previous_ticks = ticks;
        
        SDL_Event event;
        while (SDL_PollEvent(&event)) {
            
            switch (event.type) {
                case SDL_QUIT:
                    running = 0;
                    break;

                default:
                    break;
            }
        }
        
        if (reset_game) {
            reset_game = 0;
           
            ball_x = BALL_INITIAL_X;
            ball_y = BALL_INITIAL_Y;
            ball_speed_x = rand() % 2 ? BALL_SPEED : -BALL_SPEED;
            ball_speed_y = rand() % 2 ? BALL_SPEED : -BALL_SPEED;
            
            paddle1_x = PADDLE1_X;
            paddle1_y = PADDLE_Y;
            paddle2_x = PADDLE2_X;
            paddle2_y = PADDLE_Y;
        }
        
        // Read input
        const Uint8 *keys = SDL_GetKeyboardState(NULL);
        
        // update the paddles positions
        if (keys[SDL_SCANCODE_Q]) {
            paddle1_y -= PADDLE_SPEED * deltaTime;
        } else if (keys[SDL_SCANCODE_A]) {
            paddle1_y += PADDLE_SPEED * deltaTime;
        }

        if (keys[SDL_SCANCODE_UP]) {
            paddle2_y -= PADDLE_SPEED * deltaTime;
        } else if (keys[SDL_SCANCODE_DOWN]) {
            paddle2_y += PADDLE_SPEED * deltaTime;
        }
        
        // Update the ball position
        ball_x += ball_speed_x * deltaTime;
        ball_y += ball_speed_y * deltaTime;
        
        // check collision with the goals
        if (ball_x < 0) {
            reset_game = 1;
        } else if (ball_x > SCREEN_WIDTH - BALL_WIDTH - 1) {
            reset_game = 1;
        }
        
        // check collision with the paddles
        if (collides(ball_x, ball_y, paddle1_x, paddle1_y) ||
            collides(ball_x, ball_y, paddle2_x, paddle2_y)) {
            ball_speed_x = -ball_speed_x;
        }
        
        // Check collision with the screen bounds
        if (ball_y < 0) {
            ball_y = 0;
            ball_speed_y = -ball_speed_y;
        } else if (ball_y > SCREEN_HEIGHT - 1) {
            ball_y = SCREEN_HEIGHT - 1;
            ball_speed_y = -ball_speed_y;
        }
        
        SDL_RenderClear(renderer);
        
        // Draw the paddles
        paddle1_rect.x = paddle1_x;
        paddle1_rect.y = paddle1_y;
        SDL_RenderCopy(renderer, paddleTexture, NULL, &paddle1_rect);
        
        paddle2_rect.x = paddle2_x;
        paddle2_rect.y = paddle2_y;
        SDL_RenderCopy(renderer, paddleTexture, NULL, &paddle2_rect);
        
        // Draw the ball
        ball_rect.x = ball_x;
        ball_rect.y = ball_y;
        SDL_RenderCopy(renderer, ballTexture, NULL, &ball_rect);

        SDL_RenderPresent(renderer);
    }
    
    SDL_Quit();
    
    return 0;
}

int collides(int ball_x, int ball_y, int paddle_x, int paddle_y) {
    return ball_x > paddle_x && ball_x < paddle_x + PADDLE_WIDTH &&
           ball_y > paddle_y && ball_y < paddle_y + PADDLE_HEIGHT;
}
