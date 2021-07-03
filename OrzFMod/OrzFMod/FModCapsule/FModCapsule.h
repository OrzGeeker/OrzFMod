//
//  FModCapsule.h
//  jokerHub
//
//  Created by JokerAtBaoFeng on 2018/1/3.
//  Copyright © 2018年 joker. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FModCapsule : NSObject

-(void)playStreamWithFilePath:(NSString *)filePath;
-(void)play;
-(void)pause;
-(void)stop;
-(void)close;
-(BOOL)isPlaying;
@end
