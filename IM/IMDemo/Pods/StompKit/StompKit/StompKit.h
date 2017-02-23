//
//  StompKit.h
//  StompKit
//
//  Created by Jeff Mesnil on 09/10/2013.
//  Copyright (c) 2013 Jeff Mesnil. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark Frame headers

#define kHeaderAcceptVersion @"accept-version"
#define kHeaderAck           @"ack"
#define kHeaderContentLength @"content-length"
#define kHeaderDestination   @"destination"
#define kHeaderHeartBeat     @"heart-beat"
#define kHeaderHost          @"host"
#define kHeaderID            @"id"
#define kHeaderLogin         @"login"
#define kHeaderMessage       @"message"
#define kHeaderPasscode      @"passcode"
#define kHeaderReceipt       @"receipt"
#define kHeaderReceiptID     @"receipt-id"
#define kHeaderSession       @"session"
#define kHeaderSubscription  @"subscription"
#define kHeaderTransaction   @"transaction"

#pragma mark Ack Header Values

#define kAckAuto             @"auto"
#define kAckClient           @"client"
#define kAckClientIndividual @"client-individual"

@class STOMPFrame;
@class STOMPMessage;

typedef void (^STOMPFrameHandler)(STOMPFrame *frame);
typedef void (^STOMPMessageHandler)(STOMPMessage *message);

#pragma mark STOMP Frame

@interface STOMPFrame : NSObject

@property (nonatomic, copy, readonly) NSString *command;
@property (nonatomic, copy, readonly) NSDictionary *headers;
@property (nonatomic, copy, readonly) NSString *body;

@end

#pragma mark STOMP Message

@interface STOMPMessage : STOMPFrame

- (void)ack;
- (void)ack:(NSDictionary *)theHeaders;
- (void)nack;
- (void)nack:(NSDictionary *)theHeaders;

@end

#pragma mark STOMP Subscription

@interface STOMPSubscription : NSObject

@property (nonatomic, copy, readonly) NSString *identifier;

- (void)unsubscribe;

@end

#pragma mark STOMP Transaction

@interface STOMPTransaction : NSObject

@property (nonatomic, copy, readonly) NSString *identifier;

- (void)commit;
- (void)abort;

@end

#pragma mark STOMP Client

@interface STOMPClient : NSObject

@property (nonatomic, copy) STOMPFrameHandler receiptHandler;
@property (nonatomic, copy) void (^errorHandler)(NSError *error);
@property (nonatomic, assign) BOOL connected;

- (id)initWithHost:(NSString *)theHost
			  port:(NSUInteger)thePort;

- (void)connectWithLogin:(NSString *)login
                passcode:(NSString *)passcode
       completionHandler:(void (^)(STOMPFrame *connectedFrame, NSError *error))completionHandler;
- (void)connectWithHeaders:(NSDictionary *)headers
         completionHandler:(void (^)(STOMPFrame *connectedFrame, NSError *error))completionHandler;

- (void)sendTo:(NSString *)destination
          body:(NSString *)body;
- (void)sendTo:(NSString *)destination
       headers:(NSDictionary *)headers
          body:(NSString *)body;

- (STOMPSubscription *)subscribeTo:(NSString *)destination
                    messageHandler:(STOMPMessageHandler)handler;
- (STOMPSubscription *)subscribeTo:(NSString *)destination
                           headers:(NSDictionary *)headers
                    messageHandler:(STOMPMessageHandler)handler;

- (STOMPTransaction *)begin;
- (STOMPTransaction *)begin:(NSString *)identifier;

- (void)disconnect;
- (void)disconnect:(void (^)(NSError *error))completionHandler;

@end