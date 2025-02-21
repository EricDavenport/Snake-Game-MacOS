struct Snake {
    var body: [(x: Int, y: Int)] = [(x: 10, y: 10)]
    var direction: (x: Int, y: Int) = (x: 1, y: 0)

    mutating func move() {
        let head = body[0]
        let newHead = (x: head.x + direction.x, y: head.y + direction.y)
        body.insert(newHead, at: 0)
    }

    mutating func grow() {
        let tail = body.last!
        body.append(tail)
    }

    func head() -> (x: Int, y: Int) {
        return body[0]
    }


}
