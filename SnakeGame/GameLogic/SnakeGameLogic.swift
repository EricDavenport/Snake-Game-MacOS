import Foundation

class SnakeGameLogic {
    func checkCollision(snake: Snake) -> Bool {
        let head = snake.body[0]

        if head.x < 0 || head.y < 0 || head.x >= gridSize || head.y >= gridSize {
            return true
        }

        if snake.body[1...].contains(where: { $0 == head }) {
            return true
        }

        return false
    }
}
