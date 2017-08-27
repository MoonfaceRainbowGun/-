#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>
#import <OpenAL/al.h>
#import <OpenAL/alc.h>


#import "FISampleFormat.h"

@interface FISampleBuffer : NSObject

@property(assign, readonly) ALuint handle;
@property(assign, readonly) NSUInteger sampleRate;
@property(assign, readonly) FISampleFormat sampleFormat;

@property(assign, readonly) NSUInteger numberOfSamples;
@property(assign, readonly) NSUInteger bytesPerSample;
@property(assign, readonly) NSTimeInterval duration;

- (id) initWithData: (NSData*) data sampleRate: (NSUInteger) sampleRate
    sampleFormat: (FISampleFormat) sampleFormat error: (NSError**) error;

@end