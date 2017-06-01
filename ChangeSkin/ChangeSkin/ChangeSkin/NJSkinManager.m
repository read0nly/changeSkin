//
//  NJSkinManager.m
//  ChangeSkin
//
//  Created by liujie on 2017/6/1.
//  Copyright © 2017年 liujie. All rights reserved.
//

#import "NJSkinManager.h"
#import "NJUIImageUtil.h"
@interface NJSkinManager(){
    NSArray * _imageNames;
}
@end

@implementation NJSkinManager

+ (instancetype)shared{
    static NJSkinManager * manager ;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[NJSkinManager alloc] init];
    });
    return manager;
}

- (instancetype)init{
    if (self = [super init]) {
        _imageNames = @[@"atm",@"image",@"set"];
    }
    return self;
}
#pragma mark - interface methods 
- (void)changeImageColor:(UIColor *)color{
    if (!color) {
        return;
    }
    for (int i = 0; i < _imageNames.count; ++i) {
        NSString * imageName = _imageNames[i];
        ///从bundle加载图片
        UIImage * sImg = [UIImage imageWithContentsOfFile:[self pathOfImageName:imageName]];
        UIImage * dImg = [NJUIImageUtil changeImageColorWithImage:sImg color:color];
        ///修改颜色的图片写入bundle
        NSError * error = nil;
        [UIImagePNGRepresentation(dImg) writeToFile:[self pathOfImageName:imageName] options:NSDataWritingAtomic error:&error];
        if (error) {
            NSLog(@"%@",error.description);
        }else{
            NSLog(@"%@",[self pathOfImageName:imageName]);
        }
    }
}

#pragma mark - private methods

- (NSString *)pathOfImageName:(NSString *)imgName {
    NSString * bundlePath = [[NSBundle mainBundle].resourcePath stringByAppendingPathComponent:@"sources.bundle"];
    NSBundle * bundle = [NSBundle bundleWithPath:bundlePath];
    NSString * img_path = [bundle pathForResource:imgName ofType:@"png"];
    return img_path;
}

@end
