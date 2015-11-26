#import "Jastor.h"
#import "JastorRuntimeHelper.h"

@implementation Jastor

@synthesize objectId;
static NSString *idPropertyName = @"id";
static NSString *idPropertyNameOnObject = @"objectId";

Class nsDictionaryClass;
Class nsArrayClass;

+ (id)objectFromDictionary:(NSDictionary*)dictionary {
    id item = [[self alloc] initWithDictionary:dictionary];
    return item;
}

- (id)initWithObject:(id )obj{
    
    if ((self = [super init])) {
     
        
    }
    
    return self;
}

- (id)initWithDictionary:(NSDictionary *)dictionary {
	if (!nsDictionaryClass) nsDictionaryClass = [NSDictionary class];
	if (!nsArrayClass) nsArrayClass = [NSArray class];
	
	if ((self = [super init])) {
		for (NSString *key in [JastorRuntimeHelper propertyNames:[self class]]) {
            id value = nil;
            if ([dictionary isKindOfClass:[NSDictionary class]]) {
                value = [dictionary valueForKey:key];
                
                if (value == [NSNull null] || value == nil) {
                    continue;
                }
                
                if ([JastorRuntimeHelper isPropertyReadOnly:[self class] propertyName:key]) {
                    continue;
                }
                
                // handle dictionary
                if ([value isKindOfClass:nsDictionaryClass]) {
                    Class klass = [JastorRuntimeHelper propertyClassForPropertyName:key ofClass:[self class]];
                    value = [[klass alloc] initWithDictionary:value];
                }
                // handle array
                else if ([value isKindOfClass:nsArrayClass]) {
                    Class arrayItemType = [[self class] performSelector:NSSelectorFromString([NSString stringWithFormat:@"%@_class", key])];
                    
                    NSMutableArray *childObjects = [NSMutableArray arrayWithCapacity:[(NSArray*)value count]];
                    
                    for (id child in value) {
                        if ([[child class] isSubclassOfClass:nsDictionaryClass]) {
                            Jastor *childDTO = [[arrayItemType alloc] initWithDictionary:child];
                            [childObjects addObject:childDTO];
                        } else {
                            [childObjects addObject:child];
                        }
                    }
                    
                    value = childObjects;
                }
            }
            else  if([dictionary isKindOfClass:[NSArray class]]){
                Class arrayItemType = [[self class] performSelector:NSSelectorFromString([NSString stringWithFormat:@"%@_class", key])];
                
                NSMutableArray *childObjects = [NSMutableArray arrayWithCapacity:[(NSArray*)dictionary count]];
                
                for (id child in dictionary) {
                    if ([[child class] isSubclassOfClass:nsDictionaryClass]) {
                        Jastor *childDTO = [[arrayItemType alloc] initWithDictionary:child];
                        [childObjects addObject:childDTO];
                    } else {
                        [childObjects addObject:child];
                    }
                }
                
                value = childObjects;
            }
			[self setValue:value forKey:key];
		}
	}
	return self;	
}

- (void)encodeWithCoder:(NSCoder*)encoder {
	[encoder encodeObject:self.objectId forKey:idPropertyNameOnObject];
	for (NSString *key in [JastorRuntimeHelper propertyNames:[self class]]) {
		[encoder encodeObject:[self valueForKey:key] forKey:key];
	}
}

- (id)initWithCoder:(NSCoder *)decoder {
	if ((self = [super init])) {
		[self setValue:[decoder decodeObjectForKey:idPropertyNameOnObject] forKey:idPropertyNameOnObject];
		
		for (NSString *key in [JastorRuntimeHelper propertyNames:[self class]]) {
            if ([JastorRuntimeHelper isPropertyReadOnly:[self class] propertyName:key]) {
                continue;
            }
			id value = [decoder decodeObjectForKey:key];
			if (value != [NSNull null] && value != nil) {
				[self setValue:value forKey:key];
			}
		}
	}
	return self;
}

- (NSMutableDictionary *)toDictionary {
  
	NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if (self.objectId) {
        [dic setObject:self.objectId forKey:idPropertyName];
    }
	
	for (NSString *key in [JastorRuntimeHelper propertyNames:[self class]]) {
		id value = [self valueForKey:key];
        if (value && [value isKindOfClass:[Jastor class]]) {            
            [dic setObject:[value toDictionary] forKey:key];
        } else if (value && [value isKindOfClass:[NSArray class]] && ((NSArray*)value).count > 0) {
            id internalValue = [value objectAtIndex:0];
            if (internalValue && [internalValue isKindOfClass:[Jastor class]]) {
                NSMutableArray *internalItems = [NSMutableArray array];
                for (id item in value) {
                    [internalItems addObject:[item toDictionary]];
                }
                [dic setObject:internalItems forKey:key];
            } else {
                [dic setObject:value forKey:key];
            }
        } else if (value != nil) {
            [dic setObject:value forKey:key];
        }
	}
    return dic;
}
- (NSString *)toXmlString {
    NSString *str = [[NSMutableString  alloc] init];
   NSString * xmlStringPart1=@"";
   xmlStringPart1= [NSString stringWithFormat:@"<%@>",[self class]];
     NSString * xmlStringPart2=@"";
       NSString * xmlStringEveryPartName=@"";
    
    for (NSString *key in [JastorRuntimeHelper propertyNames:[self class]]) {
        id value = [self valueForKey:key];
        if (value && [value isKindOfClass:[Jastor class]]) {
            xmlStringPart2= [NSString stringWithFormat:@"%@%@",xmlStringPart2,[value toXmlString]];
        }else if (value && [value isKindOfClass:[NSMutableArray class]] && ((NSMutableArray*)value).count > 0) {
            id internalValue = [value objectAtIndex:0];
            if (internalValue && [internalValue isKindOfClass:[Jastor class]]) {
                NSString *internal =@"";
                for (id internalItems in value) {
                     internal= [NSString stringWithFormat:@"%@%@",internal,[internalItems toXmlString]];
                }
               xmlStringPart2=[NSString stringWithFormat:@"%@%@",xmlStringPart2,internal];
            }
        }else if (value != nil) {
            xmlStringEveryPartName=[NSString stringWithFormat:@"%@",key];
            xmlStringPart2= [NSString stringWithFormat:@"%@<%@>%@</%@>",xmlStringPart2,xmlStringEveryPartName,[NSString stringWithFormat:@"%@",value],xmlStringEveryPartName];
        }
    }
    NSString * xmlStringPart3=@"";
    xmlStringPart3= [NSString stringWithFormat:@"</%@>",[self class]];

    str=[ NSString stringWithFormat:@"%@%@%@",xmlStringPart1,xmlStringPart2,xmlStringPart3 ];
    
    return str;
}

- (NSString *)description {
    NSMutableDictionary *dic = [self toDictionary];
	
	return [NSString stringWithFormat:@"#<%@: id = %@ %@>", [self class], self.objectId, [dic description]];
}

- (BOOL)isEqual:(id)object {
	if (object == nil || ![object isKindOfClass:[Jastor class]]) return NO;
	
	Jastor *model = (Jastor *)object;
	
	return [self.objectId isEqualToString:model.objectId];
}

@end
