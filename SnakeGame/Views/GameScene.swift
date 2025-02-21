// GameScene.swift
import SpriteKit
import GameplayKit

class GameScene: SKScene {
    private var gameController: GameController!
    private var scoreLabel: SKLabelNode!
    private var gameOverLabel: SKLabelNode!
    private var restartButton: RestartButton!

    override func didMove(to view: SKView) {
        gameController = GameController()
        setupUI()
    }

    func setupUI() {
        // Setup Restart Button


        // Setup Score Label
        scoreLabel = SKLabelNode(text: "Score: 0")
        scoreLabel.fontSize = 30
        scoreLabel.fontColor = .white
        scoreLabel.position = CGPoint(x: 100, y: self.size.height - 40)
        addChild(scoreLabel)
        
        // Setup Game Over Label (initially hidden)
        gameOverLabel = SKLabelNode(text: "Game Over!")
        gameOverLabel.fontSize = 50
        gameOverLabel.fontColor = .red
        gameOverLabel.position = CGPoint(x: self.size.width/2, y: self.size.height/2 + 50)
        gameOverLabel.isHidden = true
        addChild(gameOverLabel)
        
        // Setup Restart Button (initially hidden)
        restartButton = RestartButton(text: "Restart Game", action: { [weak self] in
            self?.restartGame()
        })
        restartButton.position = CGPoint(x: self.size.width/2, y: self.size.height/2 - 50)
        restartButton.isHidden = true
        addChild(restartButton)
    }

    override func update(_ currentTime: TimeInterval) {
        gameController.update()
        scoreLabel.text = "Score: \(gameController.score)"
        
        if gameController.isGameOver {
            showGameOver()
        }
    }

    func showGameOver() {
        gameOverLabel.isHidden = false
        restartButton.isHidden = false
    }

    func restartGame() {
        gameOverLabel.isHidden = true
        restartButton.isHidden = true
        gameController.resetGame()
    }
}
