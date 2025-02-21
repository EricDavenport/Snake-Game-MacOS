import SpriteKit

extension SKShapeNode {
    func setPosition(x: Int, y: Int) {
        self.position = CGPoint(x: x * 30, y: y * 30)
    }
}
