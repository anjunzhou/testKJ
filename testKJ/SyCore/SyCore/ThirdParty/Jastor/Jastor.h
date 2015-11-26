//
//  Jastor.h
//  Jastor
//
//  Created by Elad Ossadon on 12/14/11.
//  http://devign.me | http://elad.ossadon.com | http://twitter.com/elado
//
#import "SyConstant.h"

@interface Jastor : NSObject <NSCoding>

@property (nonatomic, strong) NSString *objectId;

+ (id)objectFromDictionary:(NSDictionary*)dictionary;

- (id)initWithObject:(id )obj;

- (id)initWithDictionary:(NSDictionary *)dictionary;

- (NSMutableDictionary *)toDictionary;

- (NSString *)toXmlString ;
@end
