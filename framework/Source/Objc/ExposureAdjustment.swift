import Foundation
public class ExposureAdjustment: BasicOperation {
    @objc open var exposure:Float = 0.0 { didSet { uniformSettings["exposure"] = exposure } }
    
    public init() {
        super.init(fragmentShader:ExposureFragmentShader, numberOfInputs:1)
        
        ({exposure = 0.0})()
    }
}
