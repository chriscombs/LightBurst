//
//  LBMyScene.h
//  LightBurst
//

//  Copyright (c) 2013 chriscombs. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface LBMyScene : SKScene <SKPhysicsContactDelegate>

@property (nonatomic, strong) NSMutableArray *nodeArray;

@end
