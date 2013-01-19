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
}

@property (retain, nonatomic) NSString * name;

- (id)initWithName:(NSString *)name;
- (BOOL)isAlive;
- (void)killPig;

@end
