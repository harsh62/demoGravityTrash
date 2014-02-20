//
//  MyScene.h
//  demoGravity
//

//  Copyright (c) 2013 Harshdeep  Singh. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface MyScene : SKScene
{
    UIBezierPath *_path;
    UIImage *incrementalImage;
    CGPoint pts[5];
    uint ctr;
    
    CGPoint lastPoint;
	UIImageView *drawImage;
	BOOL mouseSwiped;
	int mouseMoved;
    
    CGPoint previousPoint;
    CGPoint currentPoint;
    CGPoint midPoint;
}

@end
