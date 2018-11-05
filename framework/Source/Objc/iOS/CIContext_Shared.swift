//
//  CIContext_Shared.swift
//  GPUImage
//
//  Created by wzkj on 2018/11/5.
//  Copyright © 2018 Sunset Lake Software LLC. All rights reserved.
//

import Foundation
import CoreImage

public let sharedImageProcessingCIContext = CIContext(eaglContext: sharedImageProcessingContext.context)
