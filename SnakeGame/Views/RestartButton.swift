import SpriteKit

class RestartButton: SKLabelNode {
    var action: (() -> Void)?

    init(text: String, action: @escaping () -> Void) {
        super.init()
        self.text = text
        self.fontSize = 30
        self.fontColor = .blue
        self.position = CGPoint(x: 0, y: 0)
        self.action = action
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("Init(coder:) has not been implemented")
    }

    override func mouseDown(with event: NSEvent) {
        fontColor = .red
    }

    override func mouseUp(with event: NSEvent) {
        fontColor = .blue
        action?()
    }
}
