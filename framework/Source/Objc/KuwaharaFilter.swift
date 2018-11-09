import Foundation
public class KuwaharaFilter: BasicOperation {
    @objc open var radius:Int = 3 { didSet { uniformSettings["radius"] = radius } }
    
    public init() {
        super.init(fragmentShader:KuwaharaFragmentShader, numberOfInputs:1)
        
        ({radius = 3})()
    }
}
