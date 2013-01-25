//
//  Pig.m
//  Pig Pen
//
//  Created by Joseph Miller on 1/18/13.
//
//

#import "Pig.h"

#define k_wander_time 3.0
#define fps 60

@implementation Pig

@synthesize name = _name;
@synthesize isAlive = _isAlive;
@synthesize penRect = _penRect;
@synthesize speed = _speed;

- (id)initWithPenRect:(CGRect)penRect
{
    self = [super initWithFile:@"pig.png"];
    self.isAlive = TRUE;
    self.penRect = penRect;
    self.rotation = 90; // Start pigs facing down
    self.speed = 1 * fps;
    return self;
}

- (void)wander
{
    //float dt = k_wander_time;
    // Determine where to spawn the pig within the pen rect
    int minY = (self.boundingBox.size.height / 2);
    int maxY = (self.penRect.size.height) - self.boundingBox.size.height/2;
    int rangeY = maxY - minY;
    int randomY = (arc4random() % rangeY) + minY;
    int minX = (self.boundingBox.size.width / 2);
    int maxX = (self.penRect.size.width) - self.boundingBox.size.width/2;
    int rangeX = maxX - minX;
    int randomX = (arc4random() % rangeX) + minX;
    // Determine movement speed
    float dt = ccpDistance(self.boundingBox.origin, ccp(randomX, randomY)) / self.speed;
    // Animation times
    float moveTime = dt;
    // Create the action to move the pig
    CCMoveTo * actionMove = [CCMoveTo actionWithDuration:moveTime position:ccp(randomX, randomY)];
    
    //Find the angle
    float x = (randomX - self.position.x);
    float y = -(randomY - self.position.y); // y axis is in opposite direction in cocos2D
    float pigAngle = atan2f( y, x );
    // Convert from radians to degrees
    pigAngle *= (180/M_PI);
    //  Determine rotation speed
    float amountRotated = pigAngle - self.rotation;
    float rotationSpeed = self.speed * 4;
    float turnTime = abs(amountRotated) / rotationSpeed;
    
    // Create action to rotate pig (rotate to or rotate by?)
    CCRotateTo * actionRotate = [CCRotateTo actionWithDuration:turnTime angle:pigAngle];
    
    // create action to call function again
    CCCallFuncN * repeat = [CCCallFuncN actionWithTarget:self selector:@selector(completedMove:)];
    
    // Run action sequence
    [self runAction: [CCSequence actions:actionRotate, actionMove, repeat, nil]];
}

- (void)completedMove:(id) sender
{
    [self wander];
}

- (void)killPig
{
    self.isAlive = FALSE;
}

@end
