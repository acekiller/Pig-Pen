//
//  Pig.m
//  Pig Pen
//
//  Created by Joseph Miller on 1/18/13.
//
//

#import "Pig.h"

// Needed to obtain the Navigation Controller
#import "AppDelegate.h"

@implementation Pig

@synthesize name = _name;

- (id)initWithName:(NSString *)name
{
    self = [super initWithFile:@"pig.png"];
    self.name = name;
    _alive = TRUE;
    return self;
}


-(void)movePig:(float)dt
{
    // Animation times
    float turnTime = dt * 0.2;
    float moveTime = dt * 0.8;
    // Determine Pen constraint
    // Determine where to spawn the pig along the Y axis
    // Determine where to spawn the pig along the X axis
    //Find the angle
    // Convert from radians to degrees    
    // Create the action to move the pig
    // Create action to rotate pig (rotate to or rotate by?)
    // Run action sequence
}

- (BOOL)isAlive
{
    return _alive;
}

- (void)killPig
{
    _alive = FALSE;
}

@end
