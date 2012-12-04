// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to BZ.h instead.

#import <CoreData/CoreData.h>


extern const struct BZAttributes {
	 __unsafe_unretained NSString *kind;
} BZAttributes;

extern const struct BZRelationships {
	 __unsafe_unretained NSString *shuyu;
} BZRelationships;

extern const struct BZFetchedProperties {
} BZFetchedProperties;

@class Car;



@interface BZID : NSManagedObjectID {}
@end

@interface _BZ : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (BZID*)objectID;





@property (nonatomic, retain) NSString* kind;



//- (BOOL)validateKind:(id*)value_ error:(NSError**)error_;





@property (nonatomic, retain) Car *shuyu;

//- (BOOL)validateShuyu:(id*)value_ error:(NSError**)error_;





@end

@interface _BZ (CoreDataGeneratedAccessors)

@end

@interface _BZ (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveKind;
- (void)setPrimitiveKind:(NSString*)value;





- (Car*)primitiveShuyu;
- (void)setPrimitiveShuyu:(Car*)value;


@end
