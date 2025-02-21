// GameController.swift
import Foundation

class GameController {
    private var snake: Snake
    private var food: Food
    private var gameLogic: SnakeGameLogic

    var score: Int
    var isGameOver: Bool = false

    init() {
        self.snake = Snake()
        self.food = Food(x: 5, y: 5)
        self.gameLogic = SnakeGameLogic()
        self.score = 0
    }

    func update() {
        if isGameOver {
            return
        }
        
        snake.move()
        
        if snake.body[0] == food.position {
            snake.grow()
            score += 10  // Increase score when snake eats food
            spawnFood()
        }
        
        if gameLogic.checkCollision(snake: snake) {
            isGameOver = true
            return
        }
    }

    func resetGame() {
        snake = Snake()
        food = Food(x: 5, y: 5)
        score = 0
        isGameOver = false
    }

    func spawnFood() {
        // Generate new food position
        food = Food(x: Int.random(in: 1...18), y: Int.random(in: 1...18))
    }
}
