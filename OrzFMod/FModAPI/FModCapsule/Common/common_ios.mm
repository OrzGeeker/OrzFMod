/*==============================================================================
 FMOD Example Framework
 Copyright (c), Firelight Technologies Pty, Ltd 2012-2023.
 ==============================================================================*/
#include "fmod_errors.h"

#import <AVFoundation/AVAudioSession.h>

void (*gSuspendCallback)(bool suspend);

void Common_RegisterSuspendCallback(void (*callback)(bool))
{
    gSuspendCallback = callback;
}

void Common_Init(void **extraDriverData)
{
    /*
     Optimize audio session for FMOD defaults
     */
    double rate = 24000.0;
    int blockSize = 512;
    long channels = 2;
    BOOL success = false;
    AVAudioSession *session = [AVAudioSession sharedInstance];
    
    // Make our category 'solo' for the best chance at getting our desired settings
    // Use AVAudioSessionCategoryPlayAndRecord if you need microphone input
    success = [session setCategory:AVAudioSessionCategorySoloAmbient error:nil];
    assert(success);
    
    // Set our preferred rate and activate the session to test it
    success = [session setPreferredSampleRate:rate error:nil];
    assert(success);
    success = [session setActive:TRUE error:nil];
    assert(success);
    
    // Query the actual supported rate and max channels
    rate = [session sampleRate];
    channels = [session respondsToSelector:@selector(maximumOutputNumberOfChannels)] ? [session maximumOutputNumberOfChannels] : 2;
    
    // Deactivate the session so we can change parameters without route changes each time
    success = [session setActive:FALSE error:nil];
    assert(success);
    
    // Set the duration and channels based on known supported values
    success = [session setPreferredIOBufferDuration:blockSize / rate error:nil];
    assert(success);
    if ([session respondsToSelector:@selector(setPreferredOutputNumberOfChannels:error:)])
    {
        success = [session setPreferredOutputNumberOfChannels:channels error:nil];
        assert(success);
    }
    
    /*
     Set up some observers for various notifications
     */
    [[NSNotificationCenter defaultCenter] addObserverForName:AVAudioSessionInterruptionNotification object:nil queue:nil usingBlock:^(NSNotification *notification)
     {
        bool began = [[notification.userInfo valueForKey:AVAudioSessionInterruptionTypeKey] intValue] == AVAudioSessionInterruptionTypeBegan;
        NSLog(@"Interruption %@", began ? @"Began" : @"Ended");
        
        if (!began)
        {
            [[AVAudioSession sharedInstance] setActive:TRUE error:nil];
        }
        
        if (gSuspendCallback)
        {
            gSuspendCallback(began);
        }
    }];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:AVAudioSessionSilenceSecondaryAudioHintNotification object:nil queue:nil usingBlock:^(NSNotification *notification)
     {
        bool began = [[notification.userInfo valueForKey:AVAudioSessionSilenceSecondaryAudioHintTypeKey] intValue] == AVAudioSessionSilenceSecondaryAudioHintTypeBegin;
        NSLog(@"Silence secondary audio %@", began ? @"Began" : @"Ended");
    }];
    
    
    [[NSNotificationCenter defaultCenter] addObserverForName:AVAudioSessionRouteChangeNotification object:nil queue:nil usingBlock:^(NSNotification *notification)
     {
        NSNumber *reason = [[notification userInfo] valueForKey:AVAudioSessionRouteChangeReasonKey];
        AVAudioSessionPortDescription *oldOutput = [[[notification userInfo] valueForKey:AVAudioSessionRouteChangePreviousRouteKey] outputs][0];
        AVAudioSessionPortDescription *newOutput = [[[AVAudioSession sharedInstance] currentRoute] outputs][0];
        
        const char *reasonString = NULL;
        switch ([reason intValue])
        {
            case AVAudioSessionRouteChangeReasonNewDeviceAvailable:         reasonString = "New Device Available";              break;
            case AVAudioSessionRouteChangeReasonOldDeviceUnavailable:       reasonString = "Old Device Unavailable";            break;
            case AVAudioSessionRouteChangeReasonCategoryChange:             reasonString = "Category Change";                   break;
            case AVAudioSessionRouteChangeReasonOverride:                   reasonString = "Override";                          break;
            case AVAudioSessionRouteChangeReasonWakeFromSleep:              reasonString = "Wake From Sleep";                   break;
            case AVAudioSessionRouteChangeReasonNoSuitableRouteForCategory: reasonString = "No Suitable Route For Category";    break;
            case AVAudioSessionRouteChangeReasonRouteConfigurationChange:   reasonString = "Configuration Change";              break;
            default:                                                        reasonString = "Unknown";
        }
        
        NSLog(@"Output route has changed from %dch %@ to %dch %@ due to '%s'", (int)[[oldOutput channels] count], [oldOutput portName], (int)[[newOutput channels] count], [newOutput portName], reasonString);
    }];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:AVAudioSessionMediaServicesWereLostNotification object:nil queue:nil usingBlock:^(NSNotification *notification)
     {
        NSLog(@"Media services were lost");
    }];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:AVAudioSessionMediaServicesWereResetNotification object:nil queue:nil usingBlock:^(NSNotification *notification)
     {
        NSLog(@"Media services were reset");
    }];
    
    /*
     Activate the audio session
     */
    success = [session setActive:TRUE error:nil];
    assert(success);
}
