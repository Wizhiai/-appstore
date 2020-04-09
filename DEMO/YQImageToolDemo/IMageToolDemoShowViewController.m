//
//  IMageToolDemoShowViewController.m
//  YQImageToolDemo
//
//  Created by problemchild on 16/8/11.
//  Copyright © 2016年 ProblenChild. All rights reserved.
//
#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

#import "IMageToolDemoShowViewController.h"


@interface IMageToolDemoShowViewController ()

@end

@implementation IMageToolDemoShowViewController

#pragma mark --------LazyLoad
-(UIImage *)bigIMG{
    _bigIMG = (_bigIMG)?_bigIMG:[UIImage imageNamed:@"IMG.PNG"];
    NSData *data = [self compressOriginalImage:_bigIMG toMaxDataSizeKBytes:1000];
     UIImage *tempImage =[UIImage imageWithData:data];
    tempImage = [self compressOriginalImage:tempImage toWidth:_normalIMG.size.width*0.8 height:_normalIMG.size.height*0.8];
    return tempImage;
}

-(UIImage *)normalIMG{
    _normalIMG = (_normalIMG)?_normalIMG:[UIImage imageNamed:@"DevicePhoneSilver"];
   
    return _normalIMG;
}

-(UIImage *)maskIMG{
    _maskIMG = (_maskIMG)?_maskIMG:[UIImage imageNamed:@"mask.png"];
    return _maskIMG;
}
#pragma mark - 压缩图片
- (NSData *)compressOriginalImage:(UIImage *)image toMaxDataSizeKBytes:(CGFloat)size
{
    UIImage *OriginalImage = image;
    
    // 执行这句代码之后会有一个范围 例如500m 会是 100m～500k
    NSData * data = UIImageJPEGRepresentation(image, 1.0);
    CGFloat dataKBytes = data.length/1000.0;
    CGFloat maxQuality = 0.9f;
    
    // 执行while循环 如果第一次压缩不会小雨100k 那么减小尺寸在重新开始压缩
    while (dataKBytes > size)
    {
        while (dataKBytes > size && maxQuality > 0.1f)
        {
            maxQuality = maxQuality - 0.1f;
            data = UIImageJPEGRepresentation(image, maxQuality);
            dataKBytes = data.length / 1000.0;
            if(dataKBytes <= size )
            {
                return data;
            }
        }
        OriginalImage =[self compressOriginalImage:OriginalImage toWidth:OriginalImage.size.width * 0.8 height:0.0];
        image = OriginalImage;
        data = UIImageJPEGRepresentation(image, 1.0);
        dataKBytes = data.length / 1000.0;
        maxQuality = 0.9f;
    }
    return data;
}

#pragma mark - 改变图片的大小
-(UIImage *)compressOriginalImage:(UIImage *)image toWidth:(CGFloat)targetWidth height:(CGFloat)height
{
    CGSize imageSize = image.size;
    CGFloat Originalwidth = imageSize.width;
    CGFloat Originalheight = imageSize.height;
    CGFloat targetHeight = height;
    if(height == 0)
     targetHeight = Originalheight / Originalwidth * targetWidth;
    UIGraphicsBeginImageContext(CGSizeMake(targetWidth, targetHeight));
    [image drawInRect:CGRectMake(0,0,targetWidth,  targetHeight)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
#pragma mark --------System

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.frame = [UIScreen mainScreen].bounds;
    self.view.backgroundColor = [UIColor whiteColor];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [self setup];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //--------------------------------------------------判断是pop还是push
    //    NSArray *viewControllers = self.navigationController.viewControllers;
    //    if (viewControllers.count > 1 && [viewControllers objectAtIndex:viewControllers.count-2] == self)
    //    {
    //        self.removeFlag = NO;
    //    }
    //    else if ([viewControllers indexOfObject:self] == NSNotFound)
    //    {
    //        self.removeFlag = YES;
    //    }
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    //    if (self.removeFlag == YES)
    //    {
    //        //清除各种代理，通知
    //        //        self.pickerBrowser.delegate = nil;
    //        //        self.pickerBrowser.dataSource = nil;
    //
    //        //remove所有view
    //        NSArray *subviews = [[NSArray alloc] initWithArray:self.view.subviews];
    //        for (UIView *subview in subviews)
    //        {
    //            [subview removeFromSuperview];
    //        }
    //
    //    }
}

-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


#pragma mark --------Functions
/**
 *  初始化
 */
-(void)setup{
    
    
    
    self.item1 = [[ImageToolDemoItem alloc]initWithFrame:CGRectMake(0,
                                                                    64,
                                                                    kScreenWidth/2-5,
                                                                    (kScreenHeight-64-10)/2)];
    [self.view addSubview:self.item1];
    
    self.item2 = [[ImageToolDemoItem alloc]initWithFrame:CGRectMake(kScreenWidth/2+5,
                                                                    64,
                                                                    kScreenWidth/2-5,
                                                                    (kScreenHeight-64-10)/2)];
    [self.view addSubview:self.item2];
    
    self.item3 = [[ImageToolDemoItem alloc]initWithFrame:CGRectMake(0,
                                                                    64+(kScreenHeight-64-10)/2,
                                                                    kScreenWidth/2-5,
                                                                    (kScreenHeight-64-10)/2)];
    [self.view addSubview:self.item3];
    
    self.item4 = [[ImageToolDemoItem alloc]initWithFrame:CGRectMake(kScreenWidth/2+5,
                                                                    64+(kScreenHeight-64-10)/2,
                                                                    kScreenWidth/2-5,
                                                                    (kScreenHeight-64-10)/2)];
    [self.view addSubview:self.item4];
}

@end
