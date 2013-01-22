//
//  Pen.m
//  Pig Pen
//
//  Created by Joe Miller on 1/20/13.
//
//

#import "Pen.h"

// Needed to obtain the Navigation Controller
#import "AppDelegate.h"

// Imprt math for determining angle
#import "math.h"
// Import custom pig class
#import "Pig.h"

#define k_animation_interval 3.0
#define k_number_of_pigs 1

@implementation Pen

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
	if( (self=[super init]) ) {
        // Initialize array to hold pigs
        _pigs = [[NSMutableArray alloc] init];
	}
	return self;    
}

-(id)initWithRect:(CGRect)rect
{
    if( (self=[self init]) ) {
		// Set the size of the pen
        [self setPenRect:rect];

        // Put pigs in the pen
        [self addPigs:k_number_of_pigs];
        
        // Schedule pig animation
        [self schedule:@selector(updatePigs:) interval:k_animation_interval];
	}
	return self;
}

-(void)setPenRect:(CGRect)rect
{
    penRect = rect;
    self.contentSize = rect.size;
    [self setPosition:(CGPointMake(rect.origin.x, rect.origin.y))];
    [self drawPen];
}

-(void)drawPen
{
    float fenceThickness = 5.0;
    float width = penRect.size.width - (fenceThickness * 2);
    float height = penRect.size.height - (fenceThickness * 2);
    ccColor4B penColor = ccc4(200, 155, 100, 255);
    ccColor4B fenceColor = ccc4(100, 50, 0, 255);
    
    CCLayerColor * fenceColorLayer = [[CCLayerColor alloc] initWithColor:fenceColor width:penRect.size.width  height:penRect.size.height];
    CCLayerColor * penColorLayer = [[CCLayerColor alloc] initWithColor:penColor width:width height:height];
    [penColorLayer setPosition:(CGPointMake(fenceThickness, fenceThickness))];
    
    [self addChild:fenceColorLayer];
    [self addChild:penColorLayer];
}

-(void)addPigs:(int)pigs2add
{
    for (int i = 1; i <= pigs2add; i++)
    {
        NSString * pigName = [[NSString alloc] initWithFormat:@"Pig%i", i];
        Pig * pig = [[Pig alloc] initWithName:pigName];
        NSLog(@"%@", pig.name);
        float centerX = (penRect.size.width / 2);
        float centerY = (penRect.size.height / 2);
        CGPoint centerPoint = CGPointMake(centerX, centerY);
        [pig setPosition:centerPoint];
        NSLog(@"x%f y%f", centerPoint.x, centerPoint.y);
        [self addChild:pig];
        [_pigs addObject:pig];
    }
    
}

-(void)movePig:(CCSprite *)pig
{
    // Animation times
    float turnTime = k_animation_interval * 0.2;
    float moveTime = k_animation_interval * 0.8;
    // Pen constraint is penSize    
    // Determine where to spawn the pig along the Y axis
    int minY = (pig.contentSize.height / 2);
    int maxY = (self.boundingBox.size.height) - pig.contentSize.height/2;
    int rangeY = maxY - minY;
    int randomY = (arc4random() % rangeY) + minY;
    // Determine where to spawn the pig along the X axis
    int minX = (pig.contentSize.width / 2);
    int maxX = (self.boundingBox.size.width) - pig.contentSize.width/2;
    int rangeX = maxX - minX;
    int randomX = (arc4random() % rangeX) + minX;
    // Create the action to move the pig
    CCMoveTo * actionMove = [CCMoveTo actionWithDuration:moveTime position:ccp(randomX, randomY)];
    
    //Find the angle
    float pigAngle = atan2f((randomY - pig.position.y), (randomX - pig.position.x));
    CCLOG(@"radians %f", pigAngle);
    // Convert from radians to degrees
    pigAngle *= (180/M_PI);
    CCLOG(@"degrees %f", pigAngle);
    // Create action to rotate pig (rotate to or rotate by?)
    CCRotateTo * actionRotate = [CCRotateBy actionWithDuration:turnTime angle:pigAngle];
    
    // Run action sequence
    [pig runAction: [CCSequence actions:actionRotate, actionMove, nil]];
}

-(void)movePigs
{
    for (Pig *pig in _pigs) {
        if ([pig isAlive]) {
            [self movePig:pig];
        } else {
            [self removePig:pig];
        }
    }
}

-(void)removePig:(Pig *)pig2remove
{
    // Remove pig
    
}

// Move pig Loop
-(void)updatePigs:(ccTime)dt
{
    [self movePigs];
}

@end
