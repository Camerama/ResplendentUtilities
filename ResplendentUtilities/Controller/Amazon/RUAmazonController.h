//
//  AmazonController.h
//  Pineapple
//
//  Created by Benjamin Maer on 3/17/13.
//  Copyright (c) 2013 Pineapple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RUAmazonControllerProtocols.h"
#import <AWSiOSSDK/S3/AmazonS3Client.h>

@interface RUAmazonController : NSObject <AmazonServiceRequestDelegate>
{
    AmazonS3Client* _amazonS3Client;
}

@property (nonatomic, assign) id<RUAmazonControllerDelegate> delegate;

//Must be overloaded by a subclass
@property (nonatomic, readonly) NSString* accessKey;
@property (nonatomic, readonly) NSString* secretKey;
@property (nonatomic, readonly) NSString* bucketName;

-(void)sendRequest:(S3PutObjectRequest*)request;

-(S3PutObjectRequest*)uploadImage:(UIImage*)image imageName:(NSString*)imageName;

//returns name of photo in amazon bucket
-(NSURL*)imageURLForImageName:(NSString*)imageName;

@end
