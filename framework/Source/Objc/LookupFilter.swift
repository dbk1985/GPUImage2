// PictureInput isn't defined yet on Linux, so  this operation is inoperable there
#if !os(Linux)
import Foundation
public class LookupFilter: BasicOperation {
    @objc open var intensity:Float = 1.0 { didSet { uniformSettings["intensity"] = intensity } }
    @objc open var lookupImage:PictureInput? { // TODO: Check for retain cycles in all cases here
        didSet {
            lookupImage?.addTarget(self, atTargetIndex:1)
            lookupImage?.processImage()
        }
    }
    
    public init() {
        super.init(fragmentShader:LookupFragmentShader, numberOfInputs:2)
        
        ({intensity = 1.0})()
    }
}
#endif
