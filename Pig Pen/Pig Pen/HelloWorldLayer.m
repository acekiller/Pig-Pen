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
		
        // Initialize arrays
        _pigs = [[NSMutableArray alloc] init];
        
        // put a sprite on the screen
        CCSprite *pig = [CCSprite spriteWithFile:@"pig.png"];
        pig.position = ccp(pig.contentSize.width/2, size.height/2);
        [self addChild:pig];
        [_pigs addObject:pig];
        [self addPigs:20];
        // schedule game logic every second and update as often as possible
        [self schedule:@selector(gameLogic:) interval:1.0];
	}
	return self;
}
#pragma mark Game methods
- (void) addPig {
    CCSprite * pig = [CCSprite spriteWithFile:@"pig.png"];
    
    // Tag pig and add to array of monsters
    pig.tag =1;
    [_pigs addObject:pig];
    
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

    // Create the pig at the position
    pig.position = ccp(randomX, randomY);
    [self addChild:pig];
    
    // Determine speed of the pig
    int minDuration = 2.0;
    int maxDuration = 4.0;
    int rangeDuration = maxDuration - minDuration;
    int randomDuration = (arc4random() % rangeDuration) + minDuration;
    
    // Create the actions
    CCMoveTo * actionMove = [CCMoveTo actionWithDuration:randomDuration
                                                position:ccp(randomX, randomY)];
    [pig runAction:actionMove];
}

-(void)addPigs:(int)pigs2add
{
    for (int i = 1; i <= pigs2add; i++)
    {
        NSLog(@"pig %d", i);
        [self addPig];
    }

}

-(void)movePig:(CCSprite *)pig
{
    NSLog(@"Move pig");
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
    
    // Determine speed of the pig
    int minDuration = 2.0;
    int maxDuration = 4.0;
    int rangeDuration = maxDuration - minDuration;
    int randomDuration = (arc4random() % rangeDuration) + minDuration;
    
    // Angle
    CGFloat dx = 0, dy = 0;
    CGFloat rads = atan2(dy, dx);
    
    // Create the actions
    CCMoveTo * actionMove = [CCMoveTo actionWithDuration:1
                                                position:ccp(randomX, randomY)];
    [pig runAction:actionMove];
}

-(void)movePigs
{
    NSLog(@"Move pigs");
    for (CCSprite *pig in _pigs) {
        [self movePig:pig];
        NSLog(@"pig moved");
    }
}

-(void)gameLogic:(ccTime)dt
{
    NSLog(@"Game Loop");
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

#pragma mark GameKit delegate

-(void) achievementViewControllerDidFinish:(GKAchievementViewController *)viewController
{
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}

-(void) leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController
{
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}
@end