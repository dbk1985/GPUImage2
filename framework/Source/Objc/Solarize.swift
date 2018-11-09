import Foundation
public class Solarize: BasicOperation {
    @objc open var threshold:Float = 0.5 { didSet { uniformSettings["threshold"] = threshold } }
    
    public init() {
        super.init(fragmentShader:SolarizeFragmentShader, numberOfInputs:1)
        
        ({threshold = 0.5})()
    }
}
