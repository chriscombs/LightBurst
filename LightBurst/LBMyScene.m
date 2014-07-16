//
//  LBMyScene.m
//  LightBurst
//
//  Created by Chris on 12/5/13.
//  Copyright (c) 2013 chriscombs. All rights reserved.
//

#import "LBMyScene.h"

@implementation LBMyScene

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        self.backgroundColor = [SKColor colorWithRed:0.05 green:0.05 blue:0.05 alpha:1.0];
        
        self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
        self.physicsWorld.gravity = CGVectorMake(0, 0);
        self.physicsWorld.contactDelegate = self;
        _nodeArray = [NSMutableArray array];
        
        for (int i = 0; i < 20; i++) {
            [self addNewShape];
        }
    }
    return self;
}

- (void)addNewShape {
    
    SKShapeNode *node = [SKShapeNode node];
    
    CGMutablePathRef path = CGPathCreateMutable();
    //CGPathMoveToPoint(path, NULL, 0.f, 0.f);
    CGPathAddLineToPoint(path, NULL, 10.f, 10.f);
    CGPathAddArc(path, NULL, 0.f, 0.f, 10.f, -M_PI_2, M_PI_2*3, NO);
    CGPathCloseSubpath(path);
    node.path = path;
    CGPathRelease(path);
    
    node.strokeColor = [UIColor colorWithRed:0.3 green:1.0 blue:0.3 alpha:1];
    node.glowWidth = 0.1;
    node.lineWidth = 0.5;
    
    node.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:node.frame.size.width/2];
    node.physicsBody.dynamic = YES;
    node.physicsBody.restitution = 1;
    node.physicsBody.linearDamping = 0;
    node.physicsBody.angularDamping = 0;
    node.physicsBody.friction = 0;
    node.physicsBody.mass = 0.005;
    
    static const uint32_t nodeCategory = 0x1 << 0;
    node.physicsBody.categoryBitMask = nodeCategory;
    node.physicsBody.contactTestBitMask = nodeCategory;
    
    [self addChild:node];
    [self.nodeArray addObject:node];
    
    CGFloat x = ((float)(arc4random()%200)/100)-1.0; // between -1 and 1
    CGFloat y = ((float)(arc4random()%200)/100)-1.0;
    NSLog(@"%f, %f", x, y);
    
    node.position = CGPointMake(CGRectGetMidX(self.frame)+x*100, CGRectGetMidY(self.frame)+y*100);
    [node.physicsBody applyImpulse:CGVectorMake(x, y)];
    
}

- (void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
  
}

- (void)didBeginContact:(SKPhysicsContact *)contact {
    if ([contact.bodyA.node isKindOfClass:[SKShapeNode class]] &&
        [contact.bodyB.node isKindOfClass:[SKShapeNode class]]) {
        
        SKShapeNode *nodeA = (SKShapeNode*)contact.bodyA.node;
        SKShapeNode *nodeB = (SKShapeNode*)contact.bodyB.node;
    
        nodeA.strokeColor = [UIColor colorWithRed:((float)(arc4random()%200)/100)
                                            green:((float)(arc4random()%200)/100)
                                             blue:((float)(arc4random()%200)/100)
                                            alpha:1];
        nodeB.strokeColor = [UIColor colorWithRed:((float)(arc4random()%200)/100)
                                            green:((float)(arc4random()%200)/100)
                                             blue:((float)(arc4random()%200)/100)
                                            alpha:1];
    }
    
}

@end
