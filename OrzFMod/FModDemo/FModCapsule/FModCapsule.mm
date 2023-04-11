//
//  FModCapsule.m
//  jokerHub
//
//  Created by JokerAtBaoFeng on 2018/1/3.
//  Copyright © 2018年 joker. All rights reserved.
//

#import "FModCapsule.h"
#import <FModAPI/FModAPI.h>

//#include "fmod.hpp"
//#include "common.h"
//#include "fmod_errors.h"

@interface FModCapsule()
{
    FMOD::System     *system;
    FMOD::Sound      *sound, *sound_to_play;
    FMOD::Channel    *channel;
    FMOD_RESULT       result;
    unsigned int      version;
    void             *extradriverdata;
    int               numsubsounds;
}
@property (nonatomic, copy) NSString *currentPlayFilePath;
@end


#define ERROR_CHECK(_result)   if (result != FMOD_OK){\
    NSLog(@"%@",[NSString stringWithUTF8String:FMOD_ErrorString(result)]);\
    return;\
}

@implementation FModCapsule

-(instancetype)init
{
    if(self = [super init])
    {
        [self createSystem];
    }
    return self;
}

-(void)createSystem {
    
    channel = 0;
    extradriverdata = 0;
    sound = 0;
    result = FMOD_OK;
    
    result = FMOD::System_Create(&system);
    ERROR_CHECK(result);
    
    result = system->getVersion(&version);
    ERROR_CHECK(result);
    
    if (version < FMOD_VERSION)
    {
        NSLog(@"FMOD lib version %08x doesn't match header version %08x", version, FMOD_VERSION);
        return;
    }
    
    Common_Init(&extradriverdata);
    
    result = system->init(32, FMOD_INIT_NORMAL, extradriverdata);
    ERROR_CHECK(result);
}

-(void)playStreamWithFilePath:(NSString *)filePath
{    
    [self releaseSound];
    
    result = system->createStream(filePath.UTF8String, FMOD_LOOP_NORMAL | FMOD_2D, 0, &sound);
    ERROR_CHECK(result);

    result = sound->getNumSubSounds(&numsubsounds);
    ERROR_CHECK(result);
    
    if (numsubsounds)
    {
        sound->getSubSound(0, &sound_to_play);
        ERROR_CHECK(result);
    }
    else
    {
        sound_to_play = sound;
    }
    
    result = system->playSound(sound_to_play, 0, false, &channel);
    ERROR_CHECK(result);
    
    self.currentPlayFilePath = filePath;
}
-(void)play
{
    if(channel)
    {
        bool isPaused = false;
        channel->getPaused(&isPaused);
        if(isPaused)
        {
            channel->setPaused(false);
        }
    }
}

-(void)pause
{
    if(channel)
    {
        bool isPlaying = false;
        channel->isPlaying(&isPlaying);
        if(isPlaying)
        {
            channel->setPaused(true);
        }
        
    }
}
-(void)close
{
    [self releaseSound];
    [self releaseSystem];
}

-(void)releaseSound {
    if(sound)
    {
        result = sound->release();
        ERROR_CHECK(result);
        sound = 0;
    }
}

-(void)releaseSystem {
    if(system)
    {
        result = system->close();
        ERROR_CHECK(result);
        
        result = system->release();
        ERROR_CHECK(result);
    }
}
-(void)stop
{
    if(channel)
    {
        channel->stop();
    }
}

-(BOOL)isPlaying {
    if(channel)
    {
        bool isPlaying = false;
        channel->isPlaying(&isPlaying);
        bool isPaused = false;
        channel->getPaused(&isPaused);
        if(isPlaying && !isPaused) {
            return YES;
        }
    }
    return NO;
}
- (BOOL)isPaused {
    if(channel) {
        bool isPaused = false;
        channel->getPaused(&isPaused);
        if(isPaused) {
            return YES;
        }
    }
    return NO;
}
- (BOOL)isSameAs:(NSString *)filePath {
    return [self.currentPlayFilePath isEqualToString:filePath];
}
- (BOOL)canPlay:(NSString *)filePath {
    BOOL ret = NO;
    
    FMOD::Sound *sound = NULL;
    FMOD_RESULT result = FMOD_OK;
    
    result = system->createStream(filePath.UTF8String, FMOD_LOOP_NORMAL | FMOD_2D, 0, &sound);
    ret = (result == FMOD_OK);
    
    if(sound) {
        result = sound->release();
        sound = NULL;
    }
    
    return ret;
}
@end
