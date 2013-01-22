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
}

-(id)initWithRect:(CGRect)rect;

-(void)setPenRect:(CGRect)rect;
-(void)addPigs:(int)pigs2add;

@end
