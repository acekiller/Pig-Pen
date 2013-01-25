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
@synthesize isAlive = _isAlive;
@synthesize penRect = _penRect;

- (id)initWithPenRect:(CGRect)penRect
{
    self = [super initWithFile:@"pig.png"];
    self.isAlive = TRUE;
    self.penRect = penRect;
    self.rotation = 90; // Start pigs facing down
    return self;
}

- (void)wander:(float)dt
{
    // Animation times
    float turnTime = dt * 0.1;
    float moveTime = dt * 0.9;
    // Determine Pen constraint
    int minY = (self.boundingBox.size.height / 2);
    int maxY = (self.penRect.size.height) - self.boundingBox.size.height/2;
    int rangeY = maxY - minY;
    int randomY = (arc4random() % rangeY) + minY;
    // Determine where to spawn the pig along the X axis
    int minX = (self.boundingBox.size.width / 2);
    int maxX = (self.penRect.size.width) - self.boundingBox.size.width/2;
    int rangeX = maxX - minX;
    int randomX = (arc4random() % rangeX) + minX;
    // Create the action to move the pig
    CCMoveTo * actionMove = [CCMoveTo actionWithDuration:moveTime position:ccp(randomX, randomY)];
    
    //Find the angle
    float x = (randomX - self.position.x);
    float y = -(randomY - self.position.y); // y axis is in opposite direction in cocos2D
    float pigAngle = atan2f( y, x );
    CCLOG(@"y %f, x %f", y, x);
    CCLOG(@"radians %f", pigAngle);
    // Convert from radians to degrees
    pigAngle *= (180/M_PI);
    CCLOG(@"degrees %f", pigAngle);
    // Create action to rotate pig (rotate to or rotate by?)
    CCRotateTo * actionRotate = [CCRotateTo actionWithDuration:turnTime angle:pigAngle];
    
    // Run action sequence
    [self runAction: [CCSequence actions:actionRotate, actionMove, nil]];
}


- (void)killPig
{
    self.isAlive = FALSE;
}

@end
