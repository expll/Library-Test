// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Single.m instead.

#import "_Single.h"



@implementation SingleID
@end

@implementation _Single

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Single" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Single";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Single" inManagedObjectContext:moc_];
}

- (SingleID*)objectID {
	return (SingleID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic name;











@end
