//
//  SunView.h
//  Bluster 2
//
//  Created by Max von Hippel on 1/2/17.
//  Copyright © 2017 Max von Hippel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SunStyleKit.h"

@interface SunView : UIView

- (void)drawCanvas2WithSunRayAngle: (CGFloat)sunRayAngle point: (CGPoint)point scale: (CGFloat)scale;

@end
