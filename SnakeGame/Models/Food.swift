struct Food {
    var position: (x: Int, y: Int)

    init(x: Int, y: Int) {
        self.position = (x, y)
    }

    mutating func spawn(in gridSize: Int) {
        let minX = 1, maxX = gridSize - 2
        let minY = 1, maxY = gridSize - 2
        position.x = Int.random(in: minX...maxX)
        position.y = Int.random(in: minY...maxY)
    }
}
