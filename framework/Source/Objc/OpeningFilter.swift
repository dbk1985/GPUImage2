import Foundation
public class OpeningFilter: OperationGroup {
    @objc open var radius:UInt {
        didSet {
            erosion.radius = radius
            dilation.radius = radius
        }
    }
    let erosion = Erosion()
    let dilation = Dilation()
    
    public override init() {
        radius = 1
        super.init()
        
        self.configureGroup{input, output in
            input --> self.erosion --> self.dilation --> output
        }
    }
}
