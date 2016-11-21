import UIKit

class CircleMaskView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup() {
        let outerWidth: CGFloat = frame.width
        let outerHeight: CGFloat = frame.height
        
        backgroundColor = UIColor.clear
        
        let pathRect = CGRect(x: 0,
                              y: 0,
                              width: outerWidth,
                              height: outerHeight)
        
        let path = UIBezierPath(roundedRect: pathRect,
                                cornerRadius: 0)

        let circleRect = CGRect(x: 0,
                                y: 0,
                                width: frame.width,
                                height: frame.height)
        
        let circlePath = UIBezierPath(roundedRect: circleRect,
                                      cornerRadius: frame.width)
        
        path.append(circlePath)
        path.usesEvenOddFillRule = true
        
        let fillLayer = CAShapeLayer()
        fillLayer.path = path.cgPath
        fillLayer.fillRule = kCAFillRuleEvenOdd
        fillLayer.fillColor = UIColor.black.cgColor
        fillLayer.opacity = 1.0
        layer.addSublayer(fillLayer)
    }
}
