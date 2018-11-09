//
//  DZCIFilter.swift
//  GPUImage
//
//  Created by wzkj on 2018/11/6.
//  Copyright © 2018 Sunset Lake Software LLC. All rights reserved.
//

import UIKit
import CoreImage
import CoreGraphics

public class DZCIFilter: ImageProcessingOperation {
    /** 滤镜 */
    var ciFilter:CIFilter!
    
    public var maximumInputs: UInt = 1
    
    public var sources: SourceContainer = SourceContainer()
    public var targets: TargetContainer = TargetContainer()
    
    var storedFramebuffer:Framebuffer?
    
    var smoothlyScaleOutput:Bool = false
    var orientation:ImageOrientation = .portrait
    var contentMode: UIViewContentMode = UIViewContentMode.scaleAspectFit
    
    public var backgroundColor = Color.black
    
    public init(filter: CIFilter, smoothlyScaleOutput:Bool = false, orientation:ImageOrientation = .portrait, contentMode: UIViewContentMode = .scaleAspectFit) {
        ciFilter = filter
        self.smoothlyScaleOutput = smoothlyScaleOutput
        self.orientation = orientation
        self.contentMode = contentMode
    }
    
    public func newFramebufferAvailable(_ framebuffer: Framebuffer, fromSourceIndex: UInt) {
        storedFramebuffer?.unlock()
        storedFramebuffer = framebuffer
        
        let renderFramebuffer = sharedImageProcessingContext.framebufferCache.requestFramebufferWithProperties(orientation:framebuffer.orientation, size:framebuffer.size)
        renderFramebuffer.lock()
        renderFramebuffer.activateFramebufferForRendering()
        clearFramebufferWithColor(Color.red)
        renderQuadWithShader(sharedImageProcessingContext.passthroughShader, uniformSettings:ShaderUniformSettings(), vertexBufferObject:sharedImageProcessingContext.standardImageVBO, inputTextures:[framebuffer.texturePropertiesForOutputRotation(.noRotation)])

//        let imageByteSize = Int(framebuffer.size.width * framebuffer.size.height * 4)
//        let imageData = UnsafeMutablePointer<UInt8>.allocate(capacity: imageByteSize)
//        glReadPixels(0, 0, framebuffer.size.width, framebuffer.size.height, GLenum(GL_RGBA), GLenum(GL_UNSIGNED_BYTE), imageData)
//        renderFramebuffer.unlock()
//
//        guard let dataProvider = CGDataProvider(dataInfo:nil, data:imageData, size:imageByteSize, releaseData: dataProviderReleaseCallback) else {fatalError("Could not allocate a CGDataProvider")}
        
        let imageByteSize = Int(framebuffer.size.width * framebuffer.size.height * 4)
        let imageUnsafeMutablePointer = UnsafeMutablePointer<GLubyte>.allocate(capacity: imageByteSize)
        let imageUnsafeMutableRawPointer = UnsafeMutableRawPointer(imageUnsafeMutablePointer)
        glReadPixels(0, 0, framebuffer.size.width, framebuffer.size.height, GLenum(GL_RGBA), GLenum(GL_UNSIGNED_BYTE), imageUnsafeMutableRawPointer)
        renderFramebuffer.unlock()
       
        // dataProviderReleaseCallback 会自动释放imageUnsafeMutableRawPointer的内存
        guard let dataProvider = CGDataProvider(dataInfo:nil, data:imageUnsafeMutableRawPointer, size:imageByteSize, releaseData: dataProviderReleaseCallback) else {fatalError("Could not allocate a CGDataProvider")}
        let defaultRGBColorSpace = CGColorSpaceCreateDeviceRGB()
        let cgImage = CGImage(width:Int(framebuffer.size.width), height:Int(framebuffer.size.height), bitsPerComponent:8, bitsPerPixel:32, bytesPerRow:4 * Int(framebuffer.size.width), space:defaultRGBColorSpace, bitmapInfo:CGBitmapInfo() /*| CGImageAlphaInfo.Last*/, provider:dataProvider, decode:nil, shouldInterpolate:false, intent:.defaultIntent)!
        let ciInputimage:CIImage = CIImage(cgImage: cgImage)
        ciFilter.setValue(ciInputimage, forKey: kCIInputImageKey)
        if let outputImage = ciFilter.outputImage {
            let ciContext: CIContext = CIContext(options: nil)
            let cgImage:CGImage = ciContext.createCGImage(outputImage, from: ciInputimage.extent)!
            
            /*
            clearBackground()
            let inputBounds = ciInputimage.extent;
            let drawableBounds = CGRect(x: 0, y: 0, width: Int(framebuffer.size.width), height: Int(framebuffer.size.height))
            let targetBounds = imageBoundsForContentMode(fromRect: inputBounds, toRect: drawableBounds)
            sharedImageProcessingCIContext.draw(outputImage, in: targetBounds, from: inputBounds)
             */
            let outputImageData:UnsafeMutablePointer = UnsafeMutablePointer<GLubyte>(mutating:CFDataGetBytePtr(cgImage.dataProvider?.data))
           
            let format = GL_BGRA
            sharedImageProcessingContext.runOperationSynchronously{
                glBindTexture(GLenum(GL_TEXTURE_2D), renderFramebuffer.texture)
                if (smoothlyScaleOutput) {
                    glTexParameteri(GLenum(GL_TEXTURE_2D), GLenum(GL_TEXTURE_MIN_FILTER), GL_LINEAR_MIPMAP_LINEAR)
                }
                
                glTexImage2D(GLenum(GL_TEXTURE_2D), 0, GL_RGBA, framebuffer.size.width, framebuffer.size.height, 0, GLenum(format), GLenum(GL_UNSIGNED_BYTE), outputImageData)
                
                if (smoothlyScaleOutput) {
                    glGenerateMipmap(GLenum(GL_TEXTURE_2D))
                }
                glBindTexture(GLenum(GL_TEXTURE_2D), 0)
            }
        }
        
        updateTargetsWithFramebuffer(renderFramebuffer)
    }
    
    public func transmitPreviousImage(to target: ImageConsumer, atIndex: UInt) {
        sources.sources[0]?.transmitPreviousImage(to:self, atIndex:0)
    }
    
    /** private */
    // 清除背景色
    func clearBackground(){
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        
        UIColor.black.getRed(&r, green: &g, blue: &b, alpha:&a)
        glClearColor(GLfloat(a), GLfloat(b), GLfloat(b), GLfloat(a))
        glClear(GLbitfield(GL_COLOR_BUFFER_BIT))
    }
    
    func aspectFit(fromRect: CGRect, toRect: CGRect) -> CGRect {
        let fromAspectRatio = fromRect.size.width / fromRect.size.height;
        let toAspectRatio = toRect.size.width / toRect.size.height;
        
        var fitRect = toRect
        
        if (fromAspectRatio > toAspectRatio) {
            fitRect.size.height = toRect.size.width / fromAspectRatio;
            fitRect.origin.y += (toRect.size.height - fitRect.size.height) * 0.5;
        } else {
            fitRect.size.width = toRect.size.height  * fromAspectRatio;
            fitRect.origin.x += (toRect.size.width - fitRect.size.width) * 0.5;
        }
        
        return fitRect.integral
    }
    
    func aspectFill(fromRect: CGRect, toRect: CGRect) -> CGRect {
        let fromAspectRatio = fromRect.size.width / fromRect.size.height;
        let toAspectRatio = toRect.size.width / toRect.size.height;
        
        var fillRect = toRect
        
        if (fromAspectRatio > toAspectRatio) {
            fillRect.size.width = toRect.size.height  * fromAspectRatio;
            fillRect.origin.x += (toRect.size.width - fillRect.size.width) * 0.5;
        } else {
            fillRect.size.height = toRect.size.width / fromAspectRatio;
            fillRect.origin.y += (toRect.size.height - fillRect.size.height) * 0.5;
        }
        
        return fillRect.integral
    }
    
    func imageBoundsForContentMode(fromRect: CGRect, toRect: CGRect) -> CGRect {
        switch contentMode {
        case .scaleAspectFit:
            return aspectFit(fromRect: fromRect, toRect: toRect)
        case .scaleAspectFill:
            return aspectFill(fromRect: fromRect, toRect: toRect)
        default:
            return fromRect
        }
    }
}
