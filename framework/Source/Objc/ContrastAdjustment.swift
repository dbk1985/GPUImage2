import Foundation
public class ContrastAdjustment: BasicOperation {
    @objc open var contrast:Float = 1.0 { didSet { uniformSettings["contrast"] = contrast } }
    
    public init() {
        super.init(fragmentShader:ContrastFragmentShader, numberOfInputs:1)
        
        ({contrast = 1.0})()
    }
}
