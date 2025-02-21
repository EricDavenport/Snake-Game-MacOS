// GameScene.swift
import SpriteKit
import GameplayKit

class GameScene: SKScene {
    private var gameController: GameController!
    private var scoreLabel: SKLabelNode!

    override func didMove(to view: SKView) {
        gameController = GameController()
        setupUI()
    }

    func setupUI() {
        // Setup Restart Button
        let restartButton = RestartButton(text: "Restart") {
            self.gameController.resetGame()
        }
        self.addChild(restartButton)

        // Setup Score Label
        scoreLabel = SKLabelNode(text: "Score: 0")
        scoreLabel.fontSize = 30
        scoreLabel.fontColor = .white
        scoreLabel.position = CGPoint(x: 100, y: self.size.height - 40)
        addChild(scoreLabel)
    }

    override func update(_ currentTime: TimeInterval) {
        gameController.update()
        scoreLabel.text = "Score: \(gameController.score)"
    }
}
