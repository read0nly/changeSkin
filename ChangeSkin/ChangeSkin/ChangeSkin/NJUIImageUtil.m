//
//  UIImageUtil.m
//  ChangeSkin
//
//  Created by liujie on 2017/5/31.
//  Copyright © 2017年 liujie. All rights reserved.
//

#import "NJUIImageUtil.h"


#define Mask8(x) ( (x) & 0xFF )
#define R(x) ( Mask8(x) )
#define G(x) ( Mask8(x >> 8 ) )
#define B(x) ( Mask8(x >> 16) )
#define A(x) ( Mask8(x >> 24) )
#define RGBAMake(r, g, b, a) ( Mask8(r) | Mask8(g) << 8 | Mask8(b) << 16 | Mask8(a) << 24 )

@implementation NJUIImageUtil


+ (UIImage *)changeImageColorWithImage:(UIImage *)image color:(UIColor *)color{
    /// 异常处理
    if (!image) {
        return [[UIImage alloc] init];
    }
    if (!color) {
        return image;
    }
    ///要设置的颜色的rgb值
    UInt32 R,G,B;
    const CGFloat * components = CGColorGetComponents(color.CGColor);
    R = (UInt32)(components[0] *255);
    G = (UInt32)(components[1] *255);
    B = (UInt32)(components[2] *255);
    
    NSUInteger width = CGImageGetWidth(image.CGImage);
    NSUInteger height = CGImageGetHeight(image.CGImage);
    //创建颜色空间
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    ///创建新的图片（开辟内存空间）
    UInt32 * imagePixels = (UInt32 *)calloc(width * height, sizeof(UInt32));
    ///创建上下文
    CGContextRef contextRef = CGBitmapContextCreate(imagePixels, width, height, 8, 4 * width, colorSpace, kCGImageAlphaPremultipliedLast|kCGBitmapByteOrder32Big);
    ///根据上下文  绘制图片
    CGContextDrawImage(contextRef, CGRectMake(0, 0, width, height), image.CGImage);
    
    for (int y = 0; y < height; ++y) {
        for (int x = 0; x < width; ++x) {
            ///获取当前遍历的指针（指针位移）
            UInt32 * currentPixels = imagePixels + (y * width) + x;
            UInt32 thisA;
            thisA = A(*currentPixels);
            if (thisA > 0) {
                *currentPixels = RGBAMake(R, G, B, thisA);
            }
        }
    }
    ///获取图片 释放内存
    CGImageRef cgImage =CGBitmapContextCreateImage(contextRef);
    CGContextRelease(contextRef);
    CGColorSpaceRelease(colorSpace);
    free(imagePixels);
    UIImage * resultUIImage = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
    return resultUIImage;
}
@end
