import Foundation
import CoreGraphics

public class StretchDistortion: BasicOperation {
    public var center:Position = Position.center { didSet { uniformSettings["center"] = center } }
    @objc open var ocCenter:CGPoint = CGPoint(x: 0.5, y: 0.5) {
        didSet {
            center = Position(point: ocCenter)
        }
    }
    
    public init() {
        super.init(fragmentShader:StretchDistortionFragmentShader, numberOfInputs:1)
        
        ({center = Position.center})()
    }
}
