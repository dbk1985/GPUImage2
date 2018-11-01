//
//  ColorExtension.swift
//  GPUImage_iOS_OC
//
//  Created by wzkj on 2018/11/1.
//  Copyright © 2018 Sunset Lake Software LLC. All rights reserved.
//

import UIKit

extension UIColor {
    /*
    var r: CGFloat = 0;
    var g: CGFloat = 0;
    var b: CGFloat = 0;
    var a: CGFloat = 0;
    
    UIColor.red.getRed(&r, green: &g, blue: &b, alpha: &a);
    print("RGB分量---" + "r:" + String(describing: r) + " g:" + String(describing: g) + " b:" + String(describing: b) + " a:" + String(describing: a));
    
    var hh: CGFloat = 0;
    var ss: CGFloat = 0;
    var bb: CGFloat = 0;
    var aa: CGFloat = 0;
    
    UIColor.red.getHue(&hh, saturation: &ss, brightness: &bb, alpha: &aa);
    
    print("HSB分量---" + "hh:" + String(describing: hh) + " ss:" + String(describing: ss) + " bb:" + String(describing: bb) + " aa:" + String(describing: aa));
    
    var www: CGFloat = 0;
    var aaa: CGFloat = 0;
    
    UIColor.red.getWhite(&www, alpha: &aaa);
    
    print("灰度分量---" + "www:" + String(describing: www) + " aaa:" + String(describing: aaa));
    */
    
    func aplColorToGpuColor() -> Color {
        var r: CGFloat = 0;
        var g: CGFloat = 0;
        var b: CGFloat = 0;
        var a: CGFloat = 0;
        
        self.getRed(&r, green: &g, blue: &b, alpha: &a);
        return Color(red: Float(r), green: Float(g), blue: Float(b), alpha: Float(a))
    }
}
