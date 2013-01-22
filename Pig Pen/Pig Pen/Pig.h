//
//  Pig.h
//  Pig Pen
//
//  Created by Joseph Miller on 1/18/13.
//
//

#import "CCSprite.h"

@interface Pig : CCSprite
{
    BOOL _alive;
    CGRect _penRect;
}

@property (retain, nonatomic) NSString * name;

- (id)initWithPenRect:(CGRect)penRect;

- (void)wander:(float)dt;
- (BOOL)isAlive;
- (void)killPig;

@end
