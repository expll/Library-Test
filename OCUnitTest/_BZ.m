// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to BZ.m instead.

#import "_BZ.h"

const struct BZAttributes BZAttributes = {		
	.kind = @"kind",
};

const struct BZRelationships BZRelationships = {
	.shuyu = @"shuyu",
};

const struct BZFetchedProperties BZFetchedProperties = {
};

@implementation BZID
@end

@implementation _BZ

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"BZ" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"BZ";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"BZ" inManagedObjectContext:moc_];
}

- (BZID*)objectID {
	return (BZID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic kind;






@dynamic shuyu;

	






@end
