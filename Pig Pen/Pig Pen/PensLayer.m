//
//  PensLayer.m
//  Pig Pen
//
//  Created by Joseph Miller on 1/24/13.
//
//

#import "PensLayer.h"
//#import "Pig.h"
#import "Pen.h"

@implementation PensLayer

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	PensLayer *layer = [PensLayer node];
	
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
		CCLabelTTF *label = [CCLabelTTF labelWithString:@"Pig Pens" fontName:@"Marker Felt" fontSize:24];
        
		// ask director for the window size
		CGSize size = [[CCDirector sharedDirector] winSize];
        
		// position the label on the center of the screen
		label.position =  ccp( size.width /2 , size.height - label.boundingBox.size.height/2 );
		
		// add the label as a child to this Layer
		[self addChild: label];
        
        // Add pens
        CGRect pen1rect = CGRectMake(0, 0, size.width/4, size.height);
        CGRect pen2rect = CGRectMake(size.width/4, 0, size.width/4, size.height);
        CGRect pen3rect = CGRectMake(size.width/2, 0, size.width/4, size.height);
        CGRect pen4rect = CGRectMake(size.width*3/4, 0, size.width/4, size.height);
        
        Pen * pen1 = [self addPenWithRect:pen1rect];
        Pen * pen2 = [self addPenWithRect:pen2rect];
        Pen * pen3 = [self addPenWithRect:pen3rect];
        Pen * pen4 = [self addPenWithRect:pen4rect];
        
        [pen1 addPigs:7];
        [pen2 addPigs:5];
        [pen3 addPigs:3];
        [pen4 addPigs:9];
	}
	return self;
}

-(Pen *)addPenWithRect:(CGRect)rect
{
    Pen * pen = [[Pen alloc] initWithRect:rect];
    [self addChild:pen];
    return pen;
}


@end
