import SpriteKit

open class InvertedCircleMaskNode: SKNode {
    public var circleCenter: CGPoint {
        set {
            circle.position = newValue
            setupChildren()
        }
        get { return circle.position }
    }
    
    private var circle: SKSpriteNode!
    private var sceneSize: CGSize!
    private var radius: CGFloat!
    private var diameter: CGFloat {
        return radius * 2
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public init(sceneSize: CGSize, circleCenter: CGPoint, radius: CGFloat) {
        super.init()
        
        self.sceneSize = sceneSize
        self.radius = radius
        
        let view = CircleMaskView(frame: CGRect(x: 0, y: 0, width: diameter, height: diameter))
        let image = UIImage(view: view)
        let texture = SKTexture(image: image)
        
        circle = SKSpriteNode(texture: texture,
                              color: SKColor.clear,
                              size: CGSize(width: diameter, height: diameter))
        circle.position = circleCenter

        setupChildren()
    }
    
    func setupChildren() {
        removeAllChildren()
        
        let width = sceneSize.width
        let height = sceneSize.height
        
        let circleTop = circleCenter.y + radius
        let circleBottom = circleCenter.y - radius
        let circleLeft = circleCenter.x - radius
        let circleRight = circleCenter.x + radius
        
        let a = SKShapeNode(rect: CGRect(x: 0,
                                         y: 0,
                                         width: circleLeft,
                                         height: height))
        
        
        let b = SKShapeNode(rect: CGRect(x: circleLeft,
                                         y: circleTop,
                                         width: diameter,
                                         height: height - circleTop))
        
        let c = SKShapeNode(rect: CGRect(x: circleLeft,
                                         y: 0,
                                         width: diameter,
                                         height: circleBottom))
        
        let d = SKShapeNode(rect: CGRect(x: circleRight,
                                         y: 0,
                                         width: width - circleRight,
                                         height: height))
        
        for node in [a, b, c, d] {
            node.fillColor = .black
            node.strokeColor = .black
            addChild(node)
        }
        
        addChild(circle)
    }
}
