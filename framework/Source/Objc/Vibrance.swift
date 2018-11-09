import Foundation
public class Vibrance: BasicOperation {
    @objc open var vibrance:Float = 0.0 { didSet { uniformSettings["vibrance"] = vibrance } }
    
    public init() {
        super.init(fragmentShader:VibranceFragmentShader, numberOfInputs:1)
        
        ({vibrance = 0.0})()
    }
}
