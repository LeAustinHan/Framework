//
//  ImageCache.m
//  Tuan800
//
//  Created by mac mac on 11-11-16.
//  Copyright 2011年 mac. All rights reserved.


#import "ImageCache.h"

static ImageCache *_instance;
@implementation ImageCache
@synthesize myCache;
#pragma mark -
#pragma mark Singleton Methods

+ (ImageCache*)sharedInstance
{
	@synchronized(self) {
		
        if (_instance == nil) {
			
            _instance = [[self alloc] init];
            
            // Allocate/initialize any member variables of the singleton class here
            // example
			//_instance.member = @"";
        }
    }
    return _instance;
}

- (id) init
{
	if (!(self = [super init])) return self;
	self.myCache = [NSMutableDictionary dictionary];
	return self;
}

+ (id)allocWithZone:(NSZone *)zone

{	
    @synchronized(self) {
		
        if (_instance == nil) {
			
            _instance = [super allocWithZone:zone];			
            return _instance;  // assignment and return on first allocation
        }
    }
	
    return nil; //on subsequent allocation attempts return nil	
}


- (id)copyWithZone:(NSZone *)zone
{
    return self;	
}

#pragma mark -
#pragma mark Custom Methods

- (void)addImageToCache:(NSString*)imageName
{
    if (imageName) {
        UIImage *object = [self.myCache objectForKey:imageName];
        if (!object) 
        {
            //object=[UIImage imageNamed:someKey];
            object=[ImageHelper imageNamed:imageName];
            if (object) {
                [self.myCache setObject:object forKey:imageName];
            }
        }
    }
}

- (void)removeImageFromCache:(NSString*)imageName
{
    if (imageName) {
        UIImage *object = [self.myCache objectForKey:imageName];
        if (object) 
        {
            [self.myCache removeObjectForKey:imageName];
        }
    }
}

// Add your custom methods here
- (UIImage *) getImageByName: (NSString *) someKey
{
	UIImage *object = [self.myCache objectForKey:someKey];
	if (!object) 
	{
        //object=[UIImage imageNamed:someKey];
        object=[ImageHelper imageNamed:someKey];
        if (object) {
            [self.myCache setObject:object forKey:someKey];
        }
	}
   // NSLog(@"%d",[self.myCache count]);
	return object;
}

// Clear the cache at a memory warning
- (void) respondToMemoryWarning
{
    if ([self.myCache count]>0) {
        [self.myCache removeAllObjects];
    }
}

- (void) dealloc
{
	[self.myCache removeAllObjects];
}

@end
