//
//  Pen.h
//  Pig Pen
//
//  Created by Joe Miller on 1/20/13.
//
//

#import "CCLayer.h"

@interface Pen : CCLayer
{
    NSMutableArray * _pigs;
    CGSize penSize;
}

- (void)setPenWidth:(CGFloat)width andHeight:(CGFloat)height;

@end
