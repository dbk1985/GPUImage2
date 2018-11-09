#if os(Linux)
import Glibc
#if GLES
    import COpenGLES.gles2
    #else
    import COpenGL
#endif
#else
import UIKit
#if GLES
    import OpenGLES
    #else
    import OpenGL.GL3
#endif
#endif

import Foundation

public class AverageColorExtractor: BasicOperation {
    public var extractedColorCallback:((Color) -> ())?
    #if !os(Linux)
    @objc open var extractedColorOCCallback:((UIColor) -> ())? {
        didSet {
            extractedColorCallback = { (color) in
                let color = UIColor(red: CGFloat(color.redComponent), green: CGFloat(color.greenComponent), blue: CGFloat(color.blueComponent), alpha: CGFloat(color.alphaComponent))
                self.extractedColorOCCallback!(color)
            }
        }
    }
    #endif
    
    public init() {
        super.init(vertexShader:AverageColorVertexShader, fragmentShader:AverageColorFragmentShader)
    }

    override func renderFrame() {
        averageColorBySequentialReduction(inputFramebuffer:inputFramebuffers[0]!, shader:shader, extractAverageOperation:extractAverageColorFromFramebuffer)
        releaseIncomingFramebuffers()
    }
    
    func extractAverageColorFromFramebuffer(_ framebuffer:Framebuffer) {
        var data = [UInt8](repeating:0, count:Int(framebuffer.size.width * framebuffer.size.height * 4))
        glReadPixels(0, 0, framebuffer.size.width, framebuffer.size.height, GLenum(GL_RGBA), GLenum(GL_UNSIGNED_BYTE), &data)
        renderFramebuffer = framebuffer
        framebuffer.resetRetainCount()

        let totalNumberOfPixels = Int(framebuffer.size.width * framebuffer.size.height)

        var redTotal = 0, greenTotal = 0, blueTotal = 0, alphaTotal = 0
        for currentPixel in 0..<totalNumberOfPixels {
            redTotal += Int(data[currentPixel * 4])
            greenTotal += Int(data[(currentPixel * 4) + 1])
            blueTotal += Int(data[(currentPixel * 4) + 2])
            alphaTotal += Int(data[(currentPixel * 4) + 3])
        }
        
        let returnColor = Color(red:Float(redTotal) / Float(totalNumberOfPixels) / 255.0, green:Float(greenTotal) / Float(totalNumberOfPixels) / 255.0, blue:Float(blueTotal) / Float(totalNumberOfPixels) / 255.0, alpha:Float(alphaTotal) / Float(totalNumberOfPixels) / 255.0)
        
        extractedColorCallback?(returnColor)
    }
}

func averageColorBySequentialReduction(inputFramebuffer:Framebuffer, shader:ShaderProgram, extractAverageOperation:(Framebuffer) -> ()) {
    var uniformSettings = ShaderUniformSettings()
    let inputSize = Size(inputFramebuffer.size)
    let numberOfReductionsInX = floor(log(Double(inputSize.width)) / log(4.0))
    let numberOfReductionsInY = floor(log(Double(inputSize.height)) / log(4.0))
    let reductionsToHitSideLimit = Int(floor(min(numberOfReductionsInX, numberOfReductionsInY)))
    inputFramebuffer.lock()
    var previousFramebuffer = inputFramebuffer
    for currentReduction in 0..<reductionsToHitSideLimit {
        let currentStageSize = Size(width:Float(floor(Double(inputSize.width) / pow(4.0, Double(currentReduction) + 1.0))), height:Float(floor(Double(inputSize.height) / pow(4.0, Double(currentReduction) + 1.0))))
        let currentFramebuffer = sharedImageProcessingContext.framebufferCache.requestFramebufferWithProperties(orientation:previousFramebuffer.orientation, size:GLSize(currentStageSize))
        currentFramebuffer.lock()
        uniformSettings["texelWidth"] = 0.25 / currentStageSize.width
        uniformSettings["texelHeight"] = 0.25 / currentStageSize.height
        
        currentFramebuffer.activateFramebufferForRendering()
        renderQuadWithShader(shader, uniformSettings:uniformSettings, vertexBufferObject:sharedImageProcessingContext.standardImageVBO, inputTextures:[previousFramebuffer.texturePropertiesForTargetOrientation(currentFramebuffer.orientation)])
        previousFramebuffer.unlock()
        previousFramebuffer = currentFramebuffer
    }
    
    extractAverageOperation(previousFramebuffer)
}
