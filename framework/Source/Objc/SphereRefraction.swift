import Foundation
import CoreGraphics

public class SphereRefraction: BasicOperation {
    @objc open var radius:Float = 0.25 { didSet { uniformSettings["radius"] = radius } }
    @objc open var refractiveIndex:Float = 0.71 { didSet { uniformSettings["refractiveIndex"] = refractiveIndex } }
    public var center:Position = Position.center { didSet { uniformSettings["center"] = center } }
    @objc open var ocCenter:CGPoint = CGPoint(x: 0.5, y: 0.5) {
        didSet {
            center = Position(point: ocCenter)
        }
    }
    
    public init() {
        super.init(fragmentShader:SphereRefractionFragmentShader, numberOfInputs:1)
        
        ({radius = 0.25})()
        ({refractiveIndex = 0.71})()
        ({center = Position.center})()
        
        self.backgroundColor = Color(red:0.0, green:0.0, blue:0.0, alpha:0.0)
    }
}
