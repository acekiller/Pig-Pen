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

- (id)initWithPenRect:(CGRect)penRect
{
    self = [super initWithFile:@"pig.png"];
    _alive = TRUE;
    _penRect = penRect;
    return self;
}

- (void)wander:(float)dt
{
    // Animation times
    float turnTime = dt * 0.2;
    float moveTime = dt * 0.8;
    // Determine Pen constraint
    int minY = (self.boundingBox.size.height / 2);
    int maxY = (_penRect.size.height) - self.boundingBox.size.height/2;
    int rangeY = maxY - minY;
    int randomY = (arc4random() % rangeY) + minY;
    // Determine where to spawn the pig along the X axis
    int minX = (self.boundingBox.size.width / 2);
    int maxX = (_penRect.size.width) - self.boundingBox.size.width/2;
    int rangeX = maxX - minX;
    int randomX = (arc4random() % rangeX) + minX;
    // Create the action to move the pig
    CCMoveTo * actionMove = [CCMoveTo actionWithDuration:moveTime position:ccp(randomX, randomY)];
    
    //Find the angle
    float pigAngle = atan2f((randomY - self.position.y), (randomX - self.position.x));
    CCLOG(@"radians %f", pigAngle);
    // Convert from radians to degrees
    pigAngle *= (180/M_PI);
    CCLOG(@"degrees %f", pigAngle);
    // Create action to rotate pig (rotate to or rotate by?)
    CCRotateTo * actionRotate = [CCRotateBy actionWithDuration:turnTime angle:pigAngle];
    
    // Run action sequence
    [self runAction: [CCSequence actions:actionRotate, actionMove, nil]];
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
