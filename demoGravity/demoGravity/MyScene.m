//
//  MyScene.m
//  demoGravity
//
//  Created by Harshdeep  Singh on 12/11/13.
//  Copyright (c) 2013 Harshdeep  Singh. All rights reserved.
//

#import "MyScene.h"


@implementation MyScene

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        // set Multiple touches Enabled to false for allow only single touch.
        //[self setMultipleTouchEnabled: NO];
        _path = [UIBezierPath bezierPath];
        // set Line width.
        [_path setLineWidth:8.0];
        
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
        
        SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        
        
        myLabel.text = @"Hello, World!";
        myLabel.fontSize = 30;
        myLabel.position = CGPointMake(CGRectGetMidX(self.frame),
                                       CGRectGetMidY(self.frame));
        
        [self addChild:myLabel];
            
            SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:@"sphere.png"];
            sprite.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:sprite.size.width/2];
            sprite.physicsBody.dynamic = YES;
            
            sprite.position = CGPointMake(0, 0);
            
            //SKAction *action = [SKAction rotateByAngle:M_PI duration:1];
            
            //[sprite runAction:[SKAction repeatActionForever:action]];
            
            [self addChild:sprite];

        [self createSceneContents];
        
    }
    return self;
}
- (void) createSceneContents
{
    self.backgroundColor = [SKColor blackColor];
    self.scaleMode = SKSceneScaleModeAspectFit;
    self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
}



-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    [_path removeAllPoints];

    for (UITouch *touch in touches) {
        currentPoint = [touch locationInNode:self];
    }
    [_path moveToPoint:currentPoint];
    previousPoint = currentPoint;


}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    
    for (UITouch *touch in touches) {
        currentPoint = [touch locationInNode:self];
        midPoint = midpoint(previousPoint, currentPoint);
        [_path addQuadCurveToPoint:midPoint controlPoint:previousPoint];
        previousPoint = currentPoint;
    }
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    for (UITouch *touch in touches) {
    currentPoint = [touch locationInNode: self];
    midPoint = midpoint(previousPoint, currentPoint);
    [_path addQuadCurveToPoint:midPoint controlPoint:previousPoint];
    }    
//    SKSpriteNode *sprite = [[SKSpriteNode alloc] initWithTexture:[SKTexture textureWithImage:[UIImage imageNamed:@"sphere.png"]]];
//    sprite.physicsBody = [SKPhysicsBody bodyWithPolygonFromPath:[_path CGPath]];
//    sprite.position =currentPoint;
    
    SKShapeNode *wheel = [[SKShapeNode alloc]init];
    wheel.path = _path.CGPath;
    wheel.position =CGPointMake(currentPoint.x, currentPoint.y);
    //wheel.fillColor = [SKColor blueColor];
    
    wheel.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromPath:_path.CGPath];
    wheel.physicsBody.affectedByGravity = YES;
    wheel.physicsBody.dynamic = YES;
    wheel.physicsBody.restitution = 1;
    SKAction *testAction = [SKAction rotateByAngle:12.28 duration:10];
    [wheel runAction:testAction];
    
//    SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:@"sphere.png"];
//    sprite.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:sprite.size.width/2];
//    sprite.physicsBody.dynamic = YES;
//    sprite.position = currentPoint;
//
//    [self.scene addChild:sprite];
    [self.scene addChild:wheel];
    
    
    [_path removeAllPoints];
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

- (void)drawRect:(CGRect)rect {
    [_path stroke];
}

static CGPoint midpoint(CGPoint p0, CGPoint p1) {
    return (CGPoint) {
        (p0.x + p1.x) / 2.0,
        (p0.y + p1.y) / 2.0
    };
}

@end
