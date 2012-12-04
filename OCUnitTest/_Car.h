// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Car.h instead.

#import <CoreData/CoreData.h>


extern const struct CarAttributes {
	 __unsafe_unretained NSString *age;
	 __unsafe_unretained NSString *country;
} CarAttributes;

extern const struct CarRelationships {
	 __unsafe_unretained NSString *baohan;
} CarRelationships;

extern const struct CarFetchedProperties {
} CarFetchedProperties;

@class BZ;




@interface CarID : NSManagedObjectID {}
@end

@interface _Car : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (CarID*)objectID;





@property (nonatomic, retain) NSString* age;



//- (BOOL)validateAge:(id*)value_ error:(NSError**)error_;





@property (nonatomic, retain) NSString* country;



//- (BOOL)validateCountry:(id*)value_ error:(NSError**)error_;





@property (nonatomic, retain) BZ *baohan;

//- (BOOL)validateBaohan:(id*)value_ error:(NSError**)error_;





@end

@interface _Car (CoreDataGeneratedAccessors)

@end

@interface _Car (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveAge;
- (void)setPrimitiveAge:(NSString*)value;




- (NSString*)primitiveCountry;
- (void)setPrimitiveCountry:(NSString*)value;





- (BZ*)primitiveBaohan;
- (void)setPrimitiveBaohan:(BZ*)value;


@end
