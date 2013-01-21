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
#import "Pen.h"

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
        
        // Add pens
        Pen * pen1 = [[Pen alloc] init];
        [pen1 setPenWidth:size.width/2 andHeight:size.height/2];
        
        //Pen * pen2 = [[Pen alloc] init];
        //[pen1 setPenWidth:size.width/2 andHeight:size.height/2];
        // move pen?
        
        
        [self addChild:pen1];
	}
	return self;
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
