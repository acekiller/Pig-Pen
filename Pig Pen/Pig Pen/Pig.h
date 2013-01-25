//
//  Pig.h
//  Pig Pen
//
//  Created by Joseph Miller on 1/18/13.
//
//

//#import "CCSprite.h"
#import "cocos2d.h"

@interface Pig : CCSprite

@property (strong, nonatomic) NSString * name;
@property (nonatomic) BOOL isAlive;
@property (nonatomic) CGRect penRect;

- (id)initWithPenRect:(CGRect)penRect;

- (void)wander;
- (void)killPig;

@end
