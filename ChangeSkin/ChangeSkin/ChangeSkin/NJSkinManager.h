//
//  NJSkinManager.h
//  ChangeSkin
//
//  Created by liujie on 2017/6/1.
//  Copyright © 2017年 liujie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface NJSkinManager : NSObject

+ (instancetype)shared;
- (void)changeImageColor:(UIColor *)color;

@end
