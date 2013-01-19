//
//  Pig.m
//  Pig Pen
//
//  Created by Joseph Miller on 1/18/13.
//
//

#import "Pig.h"

@implementation Pig

@synthesize name = _name;

- (id)initWithName:(NSString *)name
{
    self = [super initWithFile:@"pig.png"];
    self.name = name;
    return self;
}

@end
