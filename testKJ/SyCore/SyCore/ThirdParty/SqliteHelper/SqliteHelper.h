//
//  SqliteHelper.h
//  Common
//
//  Created by Eric Gu on 8/26/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface SqliteHelper : NSObject {
	NSInteger busyRetryTimeout;
	NSString *filePath;
	sqlite3 *_db;
}

@property (readwrite) NSInteger busyRetryTimeout;
@property (readonly) NSString *filePath;


+ (NSString *)createUuid;
+ (NSString *)version;

- (id)initWithOpen;
- (BOOL)open;
- (void)close;

- (NSInteger)errorCode;
- (NSString *)errorMessage;

- (NSArray *)executeQuery: (NSString *)sql, ...;
- (NSArray *)executeQuery: (NSString *)sql arguments: (NSArray *)args;

- (BOOL)executeNonQuery: (NSString *)sql, ...;
- (BOOL)executeNonQuery: (NSString *)sql arguments: (NSArray *)args;

- (BOOL)commit;
- (BOOL)rollback;
- (BOOL)beginTransaction;
- (BOOL)beginDeferredTransaction;


@end
