import SpriteKit
import GameplayKit

class GameScene: SKScene {
    private let gridSize = 20
    private let cellSize: CGFloat = 30

    private var snake = [(x: Int, y: Int)]()
    private var direction = (x: 1, y: 0) // moving right at the start
    private var foodPosition = (x: 5, y: 5)

    private var snakeNodes: [SKShapeNode] = []
    private var foodNode: SKShapeNode!

    private var restartButton: SKLabelNode!

    private var gameOver = false
    private var moveInterval: TimeInterval = 0.2
    private var lastMoveTime: TimeInterval = 0

    override func didMove(to view: SKView) {
        backgroundColor = .black
        resetGame()
    }

    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        if !gameOver && currentTime - lastMoveTime >= moveInterval {
            moveSnake()
            lastMoveTime = currentTime
        }
    }

    private func resetGame() {
        // remove old nodes
        removeAllChildren()
        snakeNodes.removeAll()

        let midStart = gridSize / 2
        snake = [(x: midStart, y: midStart)]
        direction = (x: 0, y: 1)
        gameOver = false
        moveInterval = 0.2

        // Draw snake
        for segment in snake {
            addSnakeSegment(at: segment)
        }

        spawnFood()
    }

    private func moveSnake() {
        guard !gameOver else { return }

        let newHead = (x: snake[0].x + direction.x, y: snake[0].y + direction.y)

        // check for wall collision
        if newHead.x < 0 || newHead.y < 0 || newHead.x >= gridSize || newHead.y >= gridSize {
            gameOver = true
            showGameOver()
            return
        }

        // check for self collision
        if snake.contains(where: { $0 == newHead }) {
            gameOver = true
            showGameOver()
            return
        }

        // move snake
        snake.insert(newHead, at: 0)

        // check if eating food
        if newHead == (
            x: Int(foodNode.position.x / cellSize),
            y: Int(foodNode.position.y / cellSize)) {
            spawnFood()
            print(snakeNodes.count)
        } else {
            snake.removeLast()
        }

        updateSnakeNodes()
    }

    private func addSnakeSegment(at position: (x: Int, y: Int)) {
        let node = SKShapeNode(rectOf: CGSize(width: cellSize, height: cellSize))
        node.fillColor = .green
        node.position = CGPoint(
            x: CGFloat(position.x) * cellSize,
            y: CGFloat(position.y) * cellSize
        )
        addChild(node)
        snakeNodes.append(node)
    }

    private func updateSnakeNodes() {
        while snakeNodes.count < snake.count {
            // add missing nodes when the snake grows
            let newSegment = SKShapeNode(rectOf: CGSize(width: cellSize, height: cellSize))
            newSegment.fillColor = .green
            addChild(newSegment)
            snakeNodes.append(newSegment)
        }

        for (index, segment) in snakeNodes.enumerated() {
            if index < snake.count {
                let position = snake[index]
                segment.position = CGPoint(x: CGFloat(position.x) * cellSize, y: CGFloat(position.y) * cellSize)
            }
        }
    }

    private func spawnFood() {
        let minX = 1, maxX = gridSize - 2
        let minY = 1, maxY = gridSize - 2
        let foodX = Int.random(in: minX...maxX)
        let foodY = Int.random(in: minY...maxY)

        foodNode?.removeFromParent()

        // create new food node
        let node = SKShapeNode(rectOf: CGSize(width: cellSize, height: cellSize))
        node.fillColor = .red
        node.position = CGPoint(x: CGFloat(foodX) * cellSize, y: CGFloat(foodY) * cellSize)

        foodNode = node
        addChild(node)
    }

    private func showGameOver() {
        let label = SKLabelNode(text: "GAME OVER!")
        label.fontSize = 40
        label.fontColor = .red
        label.position = CGPoint(x: size.width / 2, y: size.height / 2)
        addChild(label)

        // restart button
        restartButton = SKLabelNode(text: "Restart")
        restartButton.fontSize = 30
        restartButton.fontColor = .blue
        restartButton.position = CGPoint(x: size.width / 2, y: size.height / 2 - 50)
        restartButton.name = "restartButton"  // for click detection
        addChild(restartButton)
    }



    override func mouseDown(with event: NSEvent) {
        let location = event.location(in: self)
        let nodesAtPoint = nodes(at: location)

        for node in nodesAtPoint {
            if node.name == "restartButton" {
                resetGame()
                return
            }
        }
    }

    override func keyDown(with event: NSEvent) {
        switch event.keyCode {
            case 123:
                if direction.x == 0 { direction = (-1, 0) }  // left arrow
            case 124:
                if direction.x == 0 { direction = (1, 0)}  // right arrow
            case 125:
                if direction.y == 0 { direction = (0, -1)} // down arrow
            case 126:
                if direction.y == 0 { direction = (0, 1)} // up arrow
            default:
                break
        }
    }



}
