import UIKit
import SpriteKitSeeThrough
import SpriteKit

class ViewController: UIViewController {
    var gestureRecognizer: UITapGestureRecognizer!
    let sceneView = SKView(frame: CGRect(x: 0, y: 30, width: 300, height: 300))
    var mask: InvertedCircleMaskNode!
    
    override func viewDidLoad() {
        setupGestureRecognizer()
        setupView()
    }
    
    func setupView() {
        let scene = SKScene(size: CGSize(width: 300, height: 300))
        sceneView.showsFPS = true
        sceneView.presentScene(scene)
        
        scene.scaleMode = .resizeFill
        
        
        let behind = SKShapeNode(rect: CGRect(x: scene.size.width * 0.5 - 40, y: scene.size.height * 0.5 - 40, width: 80, height: 80))
        behind.fillColor = .white
        
        var walls = [SKNode]()
        
        for n in 0...20 {
            let wall = SKShapeNode(circleOfRadius: 25)
            wall.fillColor = .cyan
            wall.strokeColor = .red
            wall.position = CGPoint(x: n * 30,
                                    y: n * 30)
            walls.append(wall)
        }
        
        let cropNode = SKCropNode()
        
        for wall in walls {
            cropNode.addChild(wall)
        }
        
        let radius: CGFloat = 60.0
        mask = InvertedCircleMaskNode(sceneSize: scene.size,
                                      circleCenter: CGPoint(x: scene.size.width * 0.3, y: scene.size.width * 0.3),
                                      radius: radius)
        
        
        scene.addChild(behind)
        scene.addChild(cropNode)
        
        cropNode.maskNode = mask

        view.addSubview(sceneView)
    }
    
    func setupGestureRecognizer() {
        gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(gestureDidOccur(sender:)))
        sceneView.addGestureRecognizer(gestureRecognizer)
    }
    
    func gestureDidOccur(sender: UITapGestureRecognizer) {
        let touchPosition = sender.location(ofTouch: 0, in: sceneView)
        mask.circleCenter = CGPoint(x: touchPosition.x, y: sceneView.frame.height - touchPosition.y)
    }
}

