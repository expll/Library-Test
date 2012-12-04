// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Single.h instead.

#import <CoreData/CoreData.h>



@interface SingleID : NSManagedObjectID {}
@end

@interface _Single : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (SingleID*)objectID;





@property (nonatomic, retain) NSString* name;



//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;






@end

@interface _Single (CoreDataGeneratedAccessors)

@end

@interface _Single (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;




@end
