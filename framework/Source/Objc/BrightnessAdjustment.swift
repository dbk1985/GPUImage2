import Foundation
public class BrightnessAdjustment: BasicOperation {
    @objc open var brightness:Float = 0.0 { didSet { uniformSettings["brightness"] = brightness } }
    
    public init() {
        super.init(fragmentShader:BrightnessFragmentShader, numberOfInputs:1)

        ({brightness = 1.0})()
    }
}
