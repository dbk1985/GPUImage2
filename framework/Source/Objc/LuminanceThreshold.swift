import Foundation
public class LuminanceThreshold: BasicOperation {
    @objc open var threshold:Float = 0.5 { didSet { uniformSettings["threshold"] = threshold } }
    
    public init() {
        super.init(fragmentShader:LuminanceThresholdFragmentShader, numberOfInputs:1)
        
        ({threshold = 0.5})()
    }
}
