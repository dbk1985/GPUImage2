import Foundation
import CoreGraphics
public class BulgeDistortion: BasicOperation {
    @objc open var radius:Float = 0.25 { didSet { uniformSettings["radius"] = radius } }
    @objc open var scale:Float = 0.5 { didSet { uniformSettings["scale"] = scale } }
    public var center:Position = Position.center { didSet { uniformSettings["center"] = center } }
    @objc open var ocCenter:CGPoint = CGPoint(x: 0.5, y: 0.5) { didSet { center = Position(point: ocCenter) } }
    
    public init() {
        super.init(fragmentShader:BulgeDistortionFragmentShader, numberOfInputs:1)
        
        ({radius = 0.25})()
        ({scale = 0.5})()
        ({center = Position.center})()
    }
}
