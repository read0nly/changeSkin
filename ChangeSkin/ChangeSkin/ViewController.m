//
//  ViewController.m
//  ChangeSkin
//
//  Created by liujie on 2017/5/31.
//  Copyright © 2017年 liujie. All rights reserved.
//

#import "ViewController.h"
#import "NJSkinManager.h"

@interface ViewController ()

@property (nonatomic,strong)UIImageView * imageView;//
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _imageView =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    _imageView.center = self.view.center;
    _imageView.image = [UIImage imageNamed:@"image"];
    [self.view addSubview:_imageView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    
    UIColor * randomColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];
    [[NJSkinManager shared] changeImageColor:randomColor];
}


@end
