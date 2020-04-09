//
//  WaterVC.m
//  YQImageToolDemo
//
//  Created by problemchild on 16/8/11.
//  Copyright © 2016年 ProblenChild. All rights reserved.
//

#import "WaterVC.h"

@interface WaterVC ()

@end

@implementation WaterVC

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    
    self.item1.IMGV.image = self.normalIMG;
    self.item1.titleStr.text = @"原图";
    
    self.item2.IMGV.image = self.bigIMG;
    self.item2.titleStr.text = @"水印图";
    float ws = 0.1 ;
    float hs = 0.143 ;
    self.item3.IMGV.image = [YQImageTool GetWaterPrintedImageWithBackImage:self.normalIMG
                                                             andWaterImage:self.bigIMG
                                                                    inRect:CGRectMake(self.normalIMG.size.width * ws,
                                                                                      self.normalIMG.size.height * hs,
                                                                                     self.normalIMG.size.width - self.normalIMG.size.width*2*ws,
                                                                           self.normalIMG.size.height-           self.normalIMG.size.height * (2*hs))
                                                                     alpha:1
                                                                waterScale:YES];
    self.item3.titleStr.text = @"参数waterScale为YES";
    
    
    self.item4.IMGV.image = [YQImageTool GetWaterPrintedImageWithBackImage:self.normalIMG
                                                             andWaterImage:self.bigIMG
                                                                    inRect:CGRectMake(50,
                                                                                      50,
                                                                                      200,
                                                                                      200)
                                                                     alpha:0.6
                                                                waterScale:NO];
    self.item4.titleStr.text = @"参数waterScale为NO";
    
    
}

@end
