import Foundation
public class RGBAdjustment: BasicOperation {
    @objc open var red:Float = 1.0 { didSet { uniformSettings["redAdjustment"] = red } }
    @objc open var blue:Float = 1.0 { didSet { uniformSettings["blueAdjustment"] = blue } }
    @objc open var green:Float = 1.0 { didSet { uniformSettings["greenAdjustment"] = green } }
    
    public init() {
        super.init(fragmentShader:RGBAdjustmentFragmentShader, numberOfInputs:1)
        
        ({red = 1.0})()
        ({blue = 1.0})()
        ({green = 1.0})()
    }
}
