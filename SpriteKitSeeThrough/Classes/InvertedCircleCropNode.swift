import SpriteKit

/// `InvertedCircleMaskNode` allows you to create a SpriteKit node that can act as an inverted circular mask.
/// It can be used, for example, to be able to allow the player to see behind walls if your character is behind a wall.
///
/// This is possible by using an image of a transparent (alpha 0) circle within a rectangle of the size of the scene. 
/// Behind the scenes, this little library will pre-generate this image for you given a position and radius so you don't 
/// have to create any assets manually.
open class InvertedCircleMaskNode: SKNode {
    /// Position of the mask's inverted circle within the rectangle
    public var circleCenter: CGPoint {
        get { return circle.position }
        set {
            circle.position = newValue
            setupChildren()
        }
    }
    
    /// Convenience method that sets the node's `position` attribute from the center (as opposed to bottom-left origin)
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

    /// Use init(size:circleCenter:circleRadius)
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented. Use init(size:circleCenter:circleRadius) instead.")
    }

    /// - parameter size: Size of the rectange box of the mask
    /// - parameter circleCenter: Position of the mask's inverted circle within the rectangle
    /// - parameter circleRadius: Size of the circle
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
