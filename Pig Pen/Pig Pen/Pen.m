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
		
		// create and initialize a Label
		CCLabelTTF *label = [CCLabelTTF labelWithString:@"Pen" fontName:@"Marker Felt" fontSize:24];

		// position the label on the center of the screen
		label.position =  ccp( penSize.width /2 , penSize.height - label.boundingBox.size.height );
		
		// add the label as a child to this Layer
		[self addChild: label];
        
        // Initialize array to hold pigs
        _pigs = [[NSMutableArray alloc] init];
        
        // Put pigs on screen
        [self addPigs:k_number_of_pigs];
        
        // Schedule game logic every second and update as often as possible
        [self schedule:@selector(updatePigs:) interval:k_animation_interval];

	}
	return self;
    
}

- (void)setPenWidth:(CGFloat)width andHeight:(CGFloat)height {
    penSize.width = width;
    penSize.height = height;
}

-(void)addPigs:(int)pigs2add
{
    for (int i = 1; i <= pigs2add; i++)
    {
        NSString * pigName = [[NSString alloc] initWithFormat:@"Pig%i", i];
        Pig * pig = [[Pig alloc] initWithName:pigName];
        NSLog(@"%@", pig.name);
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
    int minY = pig.contentSize.height / 2;
    int maxY = penSize.height - pig.contentSize.height/2;
    int rangeY = maxY - minY;
    int randomY = (arc4random() % rangeY) + minY;
    // Determine where to spawn the pig along the X axis
    int minX = pig.contentSize.width / 2;
    int maxX = penSize.width - pig.contentSize.width/2;
    int rangeX = maxX - minX;
    int randomX = (arc4random() % rangeX) + minX;
    //Find the angle
    float pigAngle = atan2f((randomY - pig.position.y), (randomX - pig.position.x));
    CCLOG(@"radians %f", pigAngle);
    // Convert from radians to degrees
    pigAngle *= (180/M_PI);
    CCLOG(@"degrees %f", pigAngle);
    
    // Create the action to move the pig
    CCMoveTo * actionMove = [CCMoveTo actionWithDuration:moveTime position:ccp(randomX, randomY)];
    
    // Create action to rotate pig
    CCRotateTo * actionRotate = [CCRotateTo actionWithDuration:turnTime angle:pigAngle];
    
    // Run action sequence
    [pig runAction: [CCSequence actions:actionRotate, actionMove, nil]];
}

-(void)movePigs
{
    for (Pig *pig in _pigs) {
        if ([pig isAlive]) {
            [self movePig:pig];
        }
    }
}

// Move pig Loop
-(void)updatePigs:(ccTime)dt
{
    [self movePigs];
}

@end
