// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Car.m instead.

#import "_Car.h"

const struct CarAttributes CarAttributes = {
	.age = @"age",
	.country = @"country",
};

const struct CarRelationships CarRelationships = {
	.baohan = @"baohan",
};

const struct CarFetchedProperties CarFetchedProperties = {
};

@implementation CarID
@end

@implementation _Car

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Car" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Car";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Car" inManagedObjectContext:moc_];
}

- (CarID*)objectID {
	return (CarID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic age;






@dynamic country;






@dynamic baohan;

	






@end
