import Foundation
import CoreGraphics

public class SwirlDistortion: BasicOperation {
    @objc open var radius:Float = 0.5 { didSet { uniformSettings["radius"] = radius } }
    @objc open var angle:Float = 1.0 { didSet { uniformSettings["angle"] = angle } }
    public var center:Position = Position.center { didSet { uniformSettings["center"] = center } }
   
    @objc open var ocCenter:CGPoint = CGPoint(x: 0.5, y: 0.5) {
        didSet {
            center = Position(point: ocCenter)
        }
    }
    
    public init() {
        super.init(fragmentShader:SwirlFragmentShader, numberOfInputs:1)
        
        ({radius = 0.5})()
        ({angle = 1.0})()
        ({center = Position.center})()
    }
}
