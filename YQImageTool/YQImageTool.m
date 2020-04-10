//
//  YQImageTool.h
//
//  Created by problemchild on 16/3/8.
//  Copyright © 2016年 FreakyBoy. All rights reserved.
//

#import "YQImageTool.h"
#import "math.h"
#import "NSString+StringSize.h"
#define PAI 3.1415926535897932384

@implementation YQImageTool

#pragma mark --------圆角
//--------------------------------------------------圆角

//预先生成圆角图片，直接渲染到UIImageView中去，相比直接在UIImageView.layer中去设置圆角，可以缩短渲染时间。

/**
 *  在原图的四周生成圆角，得到带圆角的图片
 *
 *  @param image           原图
 *  @param width           圆角大小
 *  @param backgroundcolor 背景颜色
 *
 *  @return 新生成的图片
 */
+(UIImage *)getCornerImageAtOriginalImageCornerWithImage:(UIImage *)image
                                           andCornerWith:(CGFloat)width
                                      andBackGroundColor:(UIColor *)backgroundcolor
{
    UIGraphicsBeginImageContextWithOptions(image.size, NO, image.scale);
    
    CGRect bounds = CGRectMake(0, 0, image.size.width, image.size.height);
    CGRect rect   = CGRectMake(0, 0, image.size.width, image.size.height);
    
    [backgroundcolor set];
    UIRectFill(bounds);
    [[UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:width] addClip];
    [image drawInRect:bounds];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

/**
 *  根据Size生成圆角图片，图片会拉伸-变形
 *
 *  @param Size            最终想要的图片的尺寸
 *  @param image           原图
 *  @param width           圆角大小
 *  @param backgroundcolor 背景颜色
 *
 *  @return 新生成的图片
 */
+(UIImage *)getCornerImageFitSize:(CGSize)Size
                        WithImage:(UIImage *)image
                    andCornerWith:(CGFloat)width
               andBackGroundColor:(UIColor *)backgroundcolor
{
    UIGraphicsBeginImageContextWithOptions(Size, NO, image.scale);
    
    CGRect bounds = CGRectMake(0, 0, Size.width, Size.height);
    CGRect rect   = CGRectMake(0, 0, Size.width, Size.height);
    
    [backgroundcolor set];
    UIRectFill(bounds);
    [[UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:width] addClip];
    [image drawInRect:bounds];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

/**
 *  根据Size生成圆角图片，图片会自适应填充，伸展范围以外的部分会被裁剪掉-不会变形
 *
 *  @param Size            最终想要的图片的尺寸
 *  @param image           原图
 *  @param width           圆角大小
 *  @param backgroundcolor 背景颜色
 *
 *  @return 新生成的图片
 */
+(UIImage *)getCornerImageFillSize:(CGSize)Size
                         WithImage:(UIImage *)image
                     andCornerWith:(CGFloat)width
                andBackGroundColor:(UIColor *)backgroundcolor

{
    UIGraphicsBeginImageContextWithOptions(Size, NO, image.scale);
    
    CGFloat bili_imageWH = image.size.width/image.size.height;
    CGFloat bili_SizeWH  = Size.width/Size.height;
    
    CGRect bounds;
    
    if (bili_imageWH > bili_SizeWH) {
        CGFloat bili_SizeH_imageH = Size.height/image.size.height;
        CGFloat height = image.size.height*bili_SizeH_imageH;
        CGFloat width = height * bili_imageWH;
        CGFloat x = -(width - Size.width)/2;
        CGFloat y = 0;
        bounds = CGRectMake(x, y, width, height);
    }else{
        CGFloat bili_SizeW_imageW = Size.width/image.size.width;
        CGFloat width = image.size.width * bili_SizeW_imageW;
        CGFloat height = width / bili_imageWH;
        CGFloat x = 0;
        CGFloat y = -(height - Size.height)/2;
        bounds = CGRectMake(x, y, width, height);
    }
    CGRect rect   = CGRectMake(0, 0, Size.width, Size.height);
    
    [backgroundcolor set];
    UIRectFill(bounds);
    [[UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:width] addClip];
    [image drawInRect:bounds];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}
+ (UIImage *)imageWithText:(NSString *)text
                  textFont:(NSInteger)fontSize
                 textColor:(UIColor *)textColor
                 textFrame:(CGRect)textFrame
               originImage:(UIImage *)image
    imageLocationViewFrame:(CGRect)viewFrame {
    
    if (!text)      {  return image;   }
    if (!fontSize)  {  fontSize = 17;   }
    if (!textColor) {  textColor = [UIColor blackColor];   }
    if (!image)     {  return nil;  }
    if (viewFrame.size.height==0 || viewFrame.size.width==0 || textFrame.size.width==0 || textFrame.size.height==0 ){return nil;}
 
    NSString *mark = text;
    CGFloat height = [mark sizeWithPreferWidth:textFrame.size.width font:[UIFont systemFontOfSize:fontSize]].height; // 此分类方法要导入头文件
    if ((height + textFrame.origin.y) > viewFrame.size.height) { // 文字高度超出父视图的宽度
        height = viewFrame.size.height - textFrame.origin.y;
    }
    
//    CGFloat w = image.size.width;
//    CGFloat h = image.size.height;
    UIGraphicsBeginImageContext(viewFrame.size);
    [image drawInRect:CGRectMake(0, 0, viewFrame.size.width, viewFrame.size.height)];
    NSDictionary *attr = @{NSFontAttributeName: [UIFont systemFontOfSize:fontSize], NSForegroundColorAttributeName : textColor };
    //位置显示
    [mark drawInRect:CGRectMake(textFrame.origin.x, textFrame.origin.y, textFrame.size.width, height) withAttributes:attr];
    
    UIImage *aimg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return aimg;
}

- (UIImage *)imageWithText:(NSString *)text
                  textFont:(NSInteger)fontSize
                 textColor:(UIColor *)textColor
                 textFrame:(CGRect)textFrame
               originImage:(UIImage *)image
    imageLocationViewFrame:(CGRect)viewFrame {
    
    if (!text)      {  return image;   }
    if (!fontSize)  {  fontSize = 17;   }
    if (!textColor) {  textColor = [UIColor blackColor];   }
    if (!image)     {  return nil;  }
    if (viewFrame.size.height==0 || viewFrame.size.width==0 || textFrame.size.width==0 || textFrame.size.height==0 ){return nil;}
 
    NSString *mark = text;
    CGFloat height = [mark sizeWithPreferWidth:textFrame.size.width font:[UIFont systemFontOfSize:fontSize]].height; // 此分类方法要导入头文件
    if ((height + textFrame.origin.y) > viewFrame.size.height) { // 文字高度超出父视图的宽度
        height = viewFrame.size.height - textFrame.origin.y;
    }
    
//    CGFloat w = image.size.width;
//    CGFloat h = image.size.height;
    UIGraphicsBeginImageContext(viewFrame.size);
    [image drawInRect:CGRectMake(0, 0, viewFrame.size.width, viewFrame.size.height)];
    NSDictionary *attr = @{NSFontAttributeName: [UIFont systemFontOfSize:fontSize], NSForegroundColorAttributeName : textColor };
    //位置显示
    [mark drawInRect:CGRectMake(textFrame.origin.x, textFrame.origin.y, textFrame.size.width, height) withAttributes:attr];
    
    UIImage *aimg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return aimg;
}


#pragma mark --------水印
//--------------------------------------------------水印
/**
 *  生成带水印的图片
 *
 *  @param backImage  背景图片
 *  @param waterImage 水印图片
 *  @param waterRect  水印位置及大小
 *  @param alpha      水印透明度
 *  @param waterScale 水印是否根据Rect改变长宽比
 *
 *  @return 新生成的图片
 */
+(UIImage *)GetWaterPrintedImageWithBackImage:(UIImage *)backImage
                                andWaterImage:(UIImage *)waterImage
                                       inRect:(CGRect)waterRect
                                        alpha:(CGFloat)alpha
                                   waterScale:(BOOL)waterScale
{
    float ws = 0.1 ;
      float hs = 0.1452 ;
    UIImageView *parentView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, waterImage.size.width, waterImage.size.height)];
    UIImageView *backIMGV = [[UIImageView alloc]init];
    backIMGV.backgroundColor = [UIColor clearColor];
    
    
    
    
    
    backIMGV.frame = CGRectMake(ws * waterImage.size.width,
                                hs * waterImage.size.height,
                                waterImage.size.width - ws * waterImage.size.width*2,
                               waterImage.size.height - hs * waterImage.size.height*2);
    backIMGV.contentMode = UIViewContentModeScaleToFill;
    backIMGV.image = backImage;
    [parentView addSubview:backIMGV];
    
    
    
    UIImageView *waterIMGV = [[UIImageView alloc]init];
//    waterIMGV.backgroundColor = [UIColor clearColor];
    waterIMGV.frame = CGRectMake(0,
                                 0,
                                 waterImage.size.width,
                                 waterImage.size.height);
 
        waterIMGV.contentMode = UIViewContentModeScaleToFill;

    waterIMGV.alpha = alpha;
    waterIMGV.image = waterImage;
    
    [parentView addSubview:waterIMGV];
    
    UIImage *outImage = [self imageWithUIView:parentView];
    
    return outImage;
}

+(UIImage *)GetWaterPrintedImageWithBackImageIphone11:(UIImage *)backImage
                                andWaterImage:(UIImage *)waterImage
                                       inRect:(CGRect)waterRect
                                        alpha:(CGFloat)alpha
                                   waterScale:(BOOL)waterScale
{
    float ws = 0.09 ;
      float hs = 0.048 ;
    UIImageView *parentView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, waterImage.size.width, waterImage.size.height)];
    UIImageView *backIMGV = [[UIImageView alloc]init];
    backIMGV.backgroundColor = [UIColor clearColor];
    
    
    
    
    
    backIMGV.frame = CGRectMake(ws * waterImage.size.width,
                                hs * waterImage.size.height,
                                waterImage.size.width - ws * waterImage.size.width*2,
                               waterImage.size.height - hs * waterImage.size.height*2);
    backIMGV.contentMode = UIViewContentModeScaleToFill;
    backIMGV.image = backImage;
    backIMGV.layer.cornerRadius = 10 ;
    [parentView addSubview:backIMGV];
    
    
    
    UIImageView *waterIMGV = [[UIImageView alloc]init];
//    waterIMGV.backgroundColor = [UIColor clearColor];
    waterIMGV.frame = CGRectMake(0,
                                 0,
                                 waterImage.size.width,
                                 waterImage.size.height);
  
        waterIMGV.contentMode = UIViewContentModeScaleToFill;
 
    waterIMGV.alpha = alpha;
    waterIMGV.image = waterImage;
    
    [parentView addSubview:waterIMGV];
    
    UIImage *outImage = [self imageWithUIView:parentView];
    
    return outImage;
}


+(UIImage *)GetWaterPrintedImageWithBackImageIphone11Pro:(UIImage *)backImage
                                andWaterImage:(UIImage *)waterImage
                                       inRect:(CGRect)waterRect
                                        alpha:(CGFloat)alpha
                                   waterScale:(BOOL)waterScale
{
    float ws = 0.09 ;
         float hs = 0.046 ;
    UIImageView *parentView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, waterImage.size.width+200, waterImage.size.height+400)];
    parentView.image = [UIImage imageNamed:@"background.jpg"];
    parentView.contentMode = UIViewContentModeScaleToFill;

    UIImageView *backIMGV = [[UIImageView alloc]init];
    backIMGV.backgroundColor = [UIColor clearColor];
    
    
    
    
    
    backIMGV.frame = CGRectMake(300 +ws * waterImage.size.width,
                             100+   hs * waterImage.size.height,
                                waterImage.size.width - ws * waterImage.size.width*2,
                               waterImage.size.height - hs * waterImage.size.height*2);
    backIMGV.contentMode = UIViewContentModeScaleToFill;
    backIMGV.image = backImage;
    backIMGV.layer.cornerRadius = 10 ;
    [parentView addSubview:backIMGV];
    
    
    
    UIImageView *waterIMGV = [[UIImageView alloc]init];
//    waterIMGV.backgroundColor = [UIColor clearColor];
    waterIMGV.frame = CGRectMake(300,
                                 100,
                                 waterImage.size.width,
                                 waterImage.size.height);
    
        waterIMGV.contentMode = UIViewContentModeScaleToFill;
   
    waterIMGV.alpha = alpha;
    waterIMGV.image = waterImage;
   
    [parentView addSubview:waterIMGV];
    
    UIImage *outImage = [self imageWithUIView:parentView];
    
    outImage = [self imageWithText:@"搜索更快wqdqdqdqwdqwd带我去多群无大青蛙大青蛙多" textFont:18 textColor:[UIColor whiteColor] textFrame:CGRectMake(50, 100, 400, 30) originImage:outImage imageLocationViewFrame:parentView.frame];
    
    return outImage;
}
//UIViewContentModeScaleToFill


+(UIImage *)GetWaterPrintedImageWithBackImageIpadSliverGold:(UIImage *)backImage
                                andWaterImage:(UIImage *)waterImage
                                    
{
    float ws = 0.080 ;
         float hs = 0.105 ;
    UIImageView *parentView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, waterImage.size.width, waterImage.size.height)];
    UIImageView *backIMGV = [[UIImageView alloc]init];
    backIMGV.backgroundColor = [UIColor clearColor];
    
    
    
    
    
    backIMGV.frame = CGRectMake(ws * waterImage.size.width,
                                hs * waterImage.size.height,
                                waterImage.size.width - ws * waterImage.size.width*2,
                               waterImage.size.height - hs * waterImage.size.height*2);
    backIMGV.contentMode = UIViewContentModeScaleToFill;
    backIMGV.image = backImage;
//    backIMGV.layer.cornerRadius = 10 ;
    [parentView addSubview:backIMGV];
    
    
    
    UIImageView *waterIMGV = [[UIImageView alloc]init];
//    waterIMGV.backgroundColor = [UIColor clearColor];
    waterIMGV.frame = CGRectMake(0,
                                 0,
                                 waterImage.size.width,
                                 waterImage.size.height);
  
    
    waterIMGV.image = waterImage;
        waterIMGV.contentMode = UIViewContentModeScaleToFill;
    [parentView addSubview:waterIMGV];
    
    UIImage *outImage = [self imageWithUIView:parentView];
     outImage = [self imageWithText:@"搜索更快wqdqdqdqwdqwd带我去多群无大青蛙大青蛙多" textFont:38 textColor:[UIColor whiteColor] textFrame:CGRectMake(50, 100, 800, 100) originImage:outImage imageLocationViewFrame:parentView.frame];
    return outImage;
}






#pragma mark --------根据遮罩图形状裁剪
//--------------------------------------------------根据遮罩图形状裁剪
/**
 *  根据遮罩图片的形状，裁剪原图，并生成新的图片
 原图与遮罩图片宽高最好都是1：1。若比例不同，则会居中。
 若因比例问题达不到效果，可用下面的UIview转UIImage的方法，先制作1：1的UIview，然后转成UIImage使用此功能
 *
 *  @param MaskImage 遮罩图片：遮罩图片最好是要显示的区域为纯黑色，不显示的区域为透明色。
 *  @param Backimage 准备裁剪的图片
 *
 *  @return 新生成的图片
 */
+(UIImage *)creatImageWithMaskImage:(UIImage *)MaskImage andBackimage:(UIImage *)Backimage{
    
    CGRect rect;
    
    if (Backimage.size.height>Backimage.size.width) {
        rect = CGRectMake(0,
                          (Backimage.size.height-Backimage.size.width),
                          Backimage.size.width*2,
                          Backimage.size.width*2);
    }else{
        rect = CGRectMake((Backimage.size.width-Backimage.size.height),
                          0,
                          Backimage.size.height*2,
                          Backimage.size.height*2);
    }
    
    UIImage *cutIMG = [UIImage imageWithCGImage:CGImageCreateWithImageInRect([Backimage CGImage], rect)];
    
    //遮罩图
    CGImageRef maskImage = MaskImage.CGImage;
    //原图
    CGImageRef originImage = cutIMG.CGImage;
    
    CGContextRef mainViewContentContext;
    CGColorSpaceRef colorSpace;
    
    colorSpace = CGColorSpaceCreateDeviceRGB();
    
    mainViewContentContext = CGBitmapContextCreate (NULL,
                                                    rect.size.width,
                                                    rect.size.height,
                                                    8,
                                                    0,
                                                    colorSpace,
                                                    kCGImageAlphaPremultipliedLast);
    
    CGColorSpaceRelease(colorSpace);
    if (mainViewContentContext==NULL)
    {
        NSLog(@"error");
    }
    
    CGContextClipToMask(mainViewContentContext,
                        CGRectMake(0, 0,
                                   rect.size.width,
                                   rect.size.height),
                        maskImage);
    
    CGContextDrawImage(mainViewContentContext,
                       CGRectMake(0, 0,
                                  rect.size.width,
                                  rect.size.height),
                       originImage);
    
    CGImageRef mainViewContentBitmapContext = CGBitmapContextCreateImage(mainViewContentContext);
    CGContextRelease(mainViewContentContext);
    UIImage *theImage = [UIImage imageWithCGImage:mainViewContentBitmapContext];
    CGImageRelease(mainViewContentBitmapContext);
    
    return theImage;
    
}

#pragma mark --------缩略图
//--------------------------------------------------缩略图
/**
 *  得到图片的缩略图
 *
 *  @param image 原图
 *  @param Size  想得到的缩略图尺寸
 *  @param Scale Scale为YES：原图会根据Size进行拉伸-会变形，Scale为NO：原图会根据Size进行填充-不会变形
 *
 *  @return 新生成的图片
 */
+(UIImage *)getThumbImageWithImage:(UIImage *)image andSize:(CGSize)Size Scale:(BOOL)Scale{
    
    UIGraphicsBeginImageContextWithOptions(Size, NO, image.scale);
    CGRect rect = CGRectMake(0, 0, Size.width, Size.height);
    
    if (!Scale) {
        CGFloat bili_imageWH = image.size.width/image.size.height;
        CGFloat bili_SizeWH  = Size.width/Size.height;
        
        if (bili_imageWH > bili_SizeWH) {
            CGFloat bili_SizeH_imageH = Size.height/image.size.height;
            CGFloat height = image.size.height*bili_SizeH_imageH;
            CGFloat width = height * bili_imageWH;
            CGFloat x = -(width - Size.width)/2;
            CGFloat y = 0;
            rect = CGRectMake(x, y, width, height);
        }else{
            CGFloat bili_SizeW_imageW = Size.width/image.size.width;
            CGFloat width = image.size.width * bili_SizeW_imageW;
            CGFloat height = width / bili_imageWH;
            CGFloat x = 0;
            CGFloat y = -(height - Size.height)/2;
            rect = CGRectMake(x, y, width, height);
        }
    }
    
    [[UIColor clearColor] set];
    UIRectFill(rect);
    [image drawInRect:rect];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

#pragma mark --------生成阴影
//--------------------------------------------------生成阴影
/**
 *  生成带阴影的图片
 *
 *  @param image     原图
 *  @param offset    横纵方向的偏移
 *  @param blurWidth 模糊程度
 *  @param Alpha     阴影透明度
 *  @param Color     阴影颜色
 *
 *  @return 新生成的图片
 */
+(UIImage *)creatShadowImageWithOriginalImage:(UIImage *)image
                              andShadowOffset:(CGSize)offset
                                 andBlurWidth:(CGFloat)blurWidth
                                     andAlpha:(CGFloat)Alpha
                                     andColor:(UIColor *)Color
{
    CGFloat width  = (image.size.width+offset.width+blurWidth*4);
    CGFloat height = (image.size.height+offset.height+blurWidth*4);
    if(offset.width<0){
        width  = (image.size.width-offset.width+blurWidth*4);
    }
    if(offset.height<0){
        height = (image.size.height-offset.height+blurWidth*4);
    }
    
    UIView *RootBackView = [[UIView alloc]initWithFrame:CGRectMake(0,0,
                                                                   width,
                                                                   height)];
    RootBackView.backgroundColor = [UIColor clearColor];
    
    UIImageView *ImageView = [[UIImageView alloc]initWithFrame:CGRectMake(blurWidth*2,
                                                                          blurWidth*2,
                                                                          image.size.width,
                                                                          image.size.height)];
    if(offset.width<0){
        ImageView.frame = CGRectMake(blurWidth*2-offset.width,
                                     ImageView.frame.origin.y,
                                     ImageView.frame.size.width,
                                     ImageView.frame.size.height);
    }
    if(offset.height<0){
        ImageView.frame = CGRectMake(ImageView.frame.origin.x,
                                     blurWidth*2-offset.height,
                                     ImageView.frame.size.width,
                                     ImageView.frame.size.height);
    }
    ImageView.backgroundColor = [UIColor clearColor];
    ImageView.layer.shadowOffset = CGSizeMake(offset.width, offset.height);
    ImageView.layer.shadowRadius = blurWidth;
    ImageView.layer.shadowOpacity = Alpha;
    ImageView.layer.shadowColor  = Color.CGColor;
    ImageView.image = image;
    
    [RootBackView addSubview:ImageView];
    
    UIImage *newImage = [self imageWithUIView:RootBackView];
    return newImage;
}

#pragma mark --------旋转
//--------------------------------------------------旋转
/**
 *  得到旋转后的图片
 *
 *  @param image 原图
 *  @param Angle 角度（0~360）
 *
 *  @return 新生成的图片
 */
+(UIImage  *)GetRotationImageWithImage:(UIImage *)image
                                 Angle:(CGFloat)Angle
{
    
    UIView *RootBackView = [[UIView alloc] initWithFrame:CGRectMake(0,0,
                                                                    image.size.width,
                                                                    image.size.height)];
    CGAffineTransform t = CGAffineTransformMakeRotation( Angle* M_PI / 180);
    RootBackView.transform = t;
    CGSize rotatedSize = RootBackView.frame.size;
    
    UIGraphicsBeginImageContextWithOptions(rotatedSize, NO, image.scale);
    
    CGContextRef theContext = UIGraphicsGetCurrentContext();
    
    CGContextTranslateCTM(theContext, rotatedSize.width/2, rotatedSize.height/2);
    CGContextRotateCTM(theContext, Angle * M_PI / 180);
    CGContextScaleCTM(theContext, 1.0, -1.0);
    
    CGContextDrawImage(theContext,
                       CGRectMake(-image.size.width / 2,
                                  -image.size.height / 2,
                                  image.size.width,
                                  image.size.height),
                       [image CGImage]);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}


#pragma mark --------裁剪
//--------------------------------------------------裁剪
/**
 *  裁剪图片
 注：若裁剪范围超出原图尺寸，则会用背景色填充缺失部位
 *
 *  @param image     原图
 *  @param Point     坐标
 *  @param Size      大小
 *  @param backColor 背景色
 *
 *  @return 新生成的图片
 */
+(UIImage *)cutImageWithImage:(UIImage *)image
                      atPoint:(CGPoint)Point
                     withSize:(CGSize)Size
              backgroundColor:(UIColor *)backColor
{
    UIGraphicsBeginImageContextWithOptions(Size, NO, image.scale);
    CGRect bounds = CGRectMake(0, 0, Size.width, Size.height);
    CGRect rect   = CGRectMake(-Point.x, -Point.y,
                               image.size.width,
                               image.size.height);
    
    [backColor set];
    UIRectFill(bounds);
    [image drawInRect:rect];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}

#pragma mark --------UIView转图片，提前渲染
//--------------------------------------------------UIView转图片，提前渲染
/**
 *  把UIView渲染成图片
 *
 *  @param view 想渲染的UIView
 *
 *  @return 渲染出的图片
 */
+(UIImage *)imageWithUIView:(UIView *)view
{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, [UIScreen mainScreen].scale);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    [view.layer renderInContext:ctx];
    
    UIImage* tImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return tImage;
}

@end
