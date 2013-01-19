//
//  HelloWorldLayer.m
//  Pig Pen
//
//  Created by Joseph Miller on 1/5/13.
//  Copyright __MyCompanyName__ 2013. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer.h"

// Needed to obtain the Navigation Controller
#import "AppDelegate.h"

// Import custom classes
#import "Pig.h"

#pragma mark - HelloWorldLayer

// HelloWorldLayer implementation
@implementation HelloWorldLayer

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HelloWorldLayer *layer = [HelloWorldLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
	if( (self=[super init]) ) {
		
		// create and initialize a Label
		CCLabelTTF *label = [CCLabelTTF labelWithString:@"Pig Pen" fontName:@"Marker Felt" fontSize:24];

		// ask director for the window size
		CGSize size = [[CCDirector sharedDirector] winSize];
	
		// position the label on the center of the screen
		label.position =  ccp( size.width /2 , size.height - label.boundingBox.size.height/2 );
		
		// add the label as a child to this Layer
		[self addChild: label];
		
        // Initialize array to hold pigs
        _pigs = [[NSMutableArray alloc] init];
        
        // Put pigs on screen
        [self addPigs:20];
        
        // Schedule game logic every second and update as often as possible
        [self schedule:@selector(gameLogic:) interval:1.0];
	}
	return self;
}
#pragma mark Game methods

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
    // Pen constraint (whole screen)
    CGSize winSize = [CCDirector sharedDirector].winSize;
    
    // Determine where to spawn the pig along the Y axis
    int minY = pig.contentSize.height / 2;
    int maxY = winSize.height - pig.contentSize.height/2;
    int rangeY = maxY - minY;
    int randomY = (arc4random() % rangeY) + minY;
    // Determine where to spawn the pig along the X axis
    int minX = pig.contentSize.width / 2;
    int maxX = winSize.width - pig.contentSize.width/2;
    int rangeX = maxX - minX;
    int randomX = (arc4random() % rangeX) + minX;
    
    // Create the actions
    CCMoveTo * actionMove = [CCMoveTo actionWithDuration:1
                                                position:ccp(randomX, randomY)];
    [pig runAction:actionMove];
}

-(void)movePigs
{
    for (CCSprite *pig in _pigs) {
        [self movePig:pig];
    }
}

// Game Loop
-(void)gameLogic:(ccTime)dt
{
    [self movePigs];
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}

@end
