import Foundation
import CoreGraphics

public class PolarPixellate: BasicOperation {
    public var pixelSize:Size = Size(width:0.05, height:0.05) { didSet { uniformSettings["pixelSize"] = pixelSize } }
    @objc open var pixelOCSize:CGSize = CGSize(width:0.05, height:0.05) { didSet { pixelSize = Size(width: Float(pixelOCSize.width), height: Float(pixelOCSize.height)) } }
    public var center:Position = Position.center { didSet { uniformSettings["center"] = center } }
    @objc open var ocCenter:CGPoint = CGPoint(x: 0.5, y: 0.5) {
        didSet {
            center = Position(point: ocCenter)
        }
    }
    
    public init() {
        super.init(fragmentShader:PolarPixellateFragmentShader, numberOfInputs:1)
        
        ({pixelSize = Size(width:0.05, height:0.05)})()
        ({center = Position.center})()
    }
}
