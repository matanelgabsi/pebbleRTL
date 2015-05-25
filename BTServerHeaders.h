#import <CoreBluetooth/CoreBluetooth.h>
#include <alloca.h>

@interface BBBulletin : NSObject
@property(copy) NSString * message;
@property(copy) NSString * title;
@end

@interface ANCAlert : NSObject
@property(readonly, nonatomic) unsigned char categoryID; // @synthesize categoryID=_categoryID;
- (id)copyWithZone:(struct _NSZone *)arg1;
- (_Bool)isEqual:(id)arg1;
- (_Bool)isEqualToAlert:(id)arg1;
- (id)date;
- (id)message;
- (id)subtitle;
- (id)title;
- (BBBulletin *)bulletin;
- (id)appIdentifier;
- (_Bool)isImportant;
- (id)initWithCategoryID:(unsigned char)arg1;

@end

@interface ANCBulletinAlert : ANCAlert {

	BBBulletin* _bulletin;

}
-(id)initWithBulletin:(id)arg1 categoryID:(unsigned char)arg2 ;
-(BOOL)isEqualToAlert:(id)arg1;
-(BOOL)isImportant;
-(void)dealloc;
-(unsigned)hash;
-(id)date;
-(id)title;
-(id)message;
-(id)subtitle;
-(id)appIdentifier;
@end