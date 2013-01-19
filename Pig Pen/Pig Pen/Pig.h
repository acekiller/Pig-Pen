//
//  Pig.h
//  Pig Pen
//
//  Created by Joseph Miller on 1/18/13.
//
//

#import "CCSprite.h"

@interface Pig : CCSprite

@property (retain, nonatomic) NSString * name;

- (id)initWithName:(NSString *)name;

@end
