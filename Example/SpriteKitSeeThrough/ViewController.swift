import UIKit
import SpriteKitSeeThrough
import SpriteKit

class ViewController: UIViewController {
    var gestureRecognizer: UITapGestureRecognizer!
    var sceneView: SKView!
    var mask: InvertedCircleMaskNode!
    
    override func viewDidLoad() {
        setupView()
        setupGestureRecognizer()
    }
    
    func setupView() {
        sceneView = SKView(frame: view.frame)
        let scene = SKScene(size: view.frame.size)
        sceneView.showsFPS = true
        sceneView.presentScene(scene)
        
        scene.scaleMode = .resizeFill

        let behind = SKShapeNode(rect: CGRect(x: scene.size.width * 0.5 - 40, y: 125, width: 80, height: 80))
        behind.fillColor = .white

        let cropNode = SKCropNode()
        
        for n in 0...11 {
            let wall = SKShapeNode(circleOfRadius: 25)
            wall.fillColor = .cyan
            wall.strokeColor = .red
            wall.position = CGPoint(x: n * 30,
                                    y: n * 30)
            
            cropNode.addChild(wall)
        }

        let radius: CGFloat = 60.0
        mask = InvertedCircleMaskNode(size: scene.size,
                                      circleCenter: CGPoint(x: scene.size.width * 0.3, y: scene.size.width * 0.3),
                                      circleRadius: radius)
        
        
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

