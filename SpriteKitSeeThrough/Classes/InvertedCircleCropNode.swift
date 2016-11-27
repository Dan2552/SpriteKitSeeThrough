import SpriteKit

open class InvertedCircleMaskNode: SKNode {
    public var circleCenter: CGPoint {
        get { return circle.position }
        set {
            circle.position = newValue
            setupChildren()
        }
    }
    
    public var rectangleCenter: CGPoint {
        get {
            return CGPoint(x: position.x + (size.width * 0.5),
                           y: position.y + (size.height * 0.5))
        }
        
        set {
            position = CGPoint(x: newValue.x - (size.width * 0.5),
                               y: newValue.y - (size.height * 0.5))
        }
    }
    
    /// Size of the rectange box (i.e. the mask itself)
    public var size: CGSize {
        didSet { setupChildren() }
    }
    
    private var circle: SKSpriteNode!
    private let radius: CGFloat
    private var diameter: CGFloat {
        return radius * 2
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented. Use init(size:circleCenter:circleRadius) instead.")
    }

    public init(size: CGSize,
                circleCenter: CGPoint = CGPoint(x: 0, y: 0),
                circleRadius: CGFloat) {
        self.size = size
        self.radius = circleRadius

        super.init()
        
        let view = CircleMaskView(frame: CGRect(x: 0, y: 0, width: diameter, height: diameter))
        let image = UIImage(view: view)
        let texture = SKTexture(image: image)
        
        circle = SKSpriteNode(texture: texture,
                              color: SKColor.clear,
                              size: CGSize(width: diameter, height: diameter))
        
        self.circleCenter = circleCenter
    }
    
    private func setupChildren() {
        guard circle != nil else { return }
        
        removeAllChildren()
        
        let width = size.width
        let height = size.height
        
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
