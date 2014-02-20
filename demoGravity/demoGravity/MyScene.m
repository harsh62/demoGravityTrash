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
       // [_path setLineWidth:1.0];
        
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
    arrayOfPoints = [[NSMutableArray alloc] init];
    _pathArray = [[NSMutableArray alloc] init];
    for (UITouch *touch in touches) {
        currentPoint = [touch locationInNode:self];
        [arrayOfPoints addObject:[NSValue valueWithCGPoint:currentPoint]];
    }
//    [_path moveToPoint:currentPoint];
    previousPoint = currentPoint;
    initialPoint = currentPoint;
    


}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    
    for (UITouch *touch in touches) {
        currentPoint = [touch locationInNode:self];
        midPoint = midpoint(previousPoint, currentPoint);
//        [_path addLineToPoint:currentPoint];
        [arrayOfPoints addObject:[NSValue valueWithCGPoint:currentPoint]];


       // [_path addQuadCurveToPoint:midPoint controlPoint:previousPoint];
        previousPoint = currentPoint;
    }
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    for (UITouch *touch in touches) {
    currentPoint = [touch locationInNode: self];
    midPoint = midpoint(previousPoint, currentPoint);
        [arrayOfPoints addObject:[NSValue valueWithCGPoint:currentPoint]];

//        [_path addLineToPoint:currentPoint];
  //  [_path addQuadCurveToPoint:midPoint controlPoint:previousPoint];
    }    
//    SKSpriteNode *sprite = [[SKSpriteNode alloc] initWithTexture:[SKTexture textureWithImage:[UIImage imageNamed:@"sphere.png"]]];
//    sprite.physicsBody = [SKPhysicsBody bodyWithPolygonFromPath:[_path CGPath]];
//    sprite.position =currentPoint;
            [_path removeAllPoints];
    NSInteger  i = 0;
    
    UIBezierPath *_path1;
    _path1.usesEvenOddFillRule = YES;
    
    
    
    CGFloat  sum=0.0;
    
    for(NSInteger i=1; i<arrayOfPoints.count;i++){
        CGPoint point1;
        CGPoint point2;
        if(i==arrayOfPoints.count){
        point1 = [[arrayOfPoints objectAtIndex:i-1] CGPointValue];
        point2 = [[arrayOfPoints objectAtIndex:0] CGPointValue];
        }
        else{
        point1 =  [[arrayOfPoints objectAtIndex:i-1] CGPointValue];
        point2 = [[arrayOfPoints objectAtIndex:i] CGPointValue];
        }
        CGFloat sum2 =(point2.x-point1.x)*(point2.y+point1.y);
        sum =  sum + sum2;
        
        
    }
    
    if(sum<0)
    {
        NSLog(@"counter : %f", sum);
    }
    else{
        NSLog(@"Clock: %f", sum);
    }
    
    for(NSValue *val in arrayOfPoints){
        if (i==0){
            _path1 = [UIBezierPath bezierPath];
            // set Line width.
           // [_path1 setLineWidth:1.0];
            
            [_path1 moveToPoint:[val CGPointValue]];
        }
        else{
            if(i%12==0){
                [_pathArray addObject:_path1];
                
                _path1 = [UIBezierPath bezierPath];
                // set Line width.
             //   [_path1 setLineWidth:1.0];
                
                [_path1 removeAllPoints];
                [_path1 moveToPoint:[val CGPointValue]];
            }
            else if(i%1==0){
                [_path1 addLineToPoint:[val CGPointValue]];
            }
        }
        i++;
    }
    
    if(![_pathArray containsObject:_path1]){
        [_pathArray addObject:_path1];
    }
    
    
    
    for(UIBezierPath *pth in _pathArray){
        SKShapeNode *wheel = [[SKShapeNode alloc]init];
        
        wheel.path = pth.CGPath;
        NSLog(@"%@",pth);
        wheel.position =CGPointMake(wheel.frame.origin.x,wheel.frame.origin.y);
        //wheel.fillColor = [SKColor blueColor];
        
        
        
        
        @try {
            wheel.physicsBody = [SKPhysicsBody bodyWithPolygonFromPath:pth.CGPath];
        }
        @catch (NSException *exception) {
            NSLog(@"crash");
            NSLog(@"----------------");
            continue;
        }
        @finally {
        }
        //wheel.physicsBody.affectedByGravity = YES;
        //wheel.physicsBody.dynamic = YES;
        //wheel.physicsBody.mass = 550.0f;
        
        //wheel.physicsBody.restitution = 1;
        
        
        wheel.physicsBody.dynamic = YES;
        wheel.physicsBody.affectedByGravity = YES;
        //wheel.physicsBody.mass = 550.0f;
        //wheel.physicsBody.categoryBitMask = 1;
        //wheel.physicsBody.collisionBitMask = 1;
        //wheel.physicsBody.contactTestBitMask = 1;
        
        //    SKAction *testAction = [SKAction rotateByAngle:13.28 duration:10];
        //    [wheel runAction:testAction];
        
        //    SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:@"sphere.png"];
        //    sprite.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:sprite.size.width/2];
        //    sprite.physicsBody.dynamic = YES;
        //    sprite.position = currentPoint;
        //
        //    [self.scene addChild:sprite];
        [self.scene addChild:wheel];
    }
    


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
