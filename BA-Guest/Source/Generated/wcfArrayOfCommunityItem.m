/*
	wcfArrayOfCommunityItem.h
	The implementation of properties and methods for the wcfArrayOfCommunityItem array.
	Generated by SudzC.com
*/
#import "wcfArrayOfCommunityItem.h"

#import "wcfCommunityItem.h"
@implementation wcfArrayOfCommunityItem

	+ (id) newWithNode: (CXMLNode*) node
	{
		return [[[wcfArrayOfCommunityItem alloc] initWithNode: node] autorelease];
	}

	- (id) initWithNode: (CXMLNode*) node
	{
		if(self = [self init]) {
			for(CXMLElement* child in [node children])
			{
				wcfCommunityItem* value = [[wcfCommunityItem newWithNode: child] object];
				if(value != nil) {
					[self addObject: value];
				}
			}
		}
		return self;
	}
	
	+ (NSMutableString*) serialize: (NSArray*) array
	{
		NSMutableString* s = [NSMutableString string];
		for(id item in array) {
			[s appendString: [item serialize: @"CommunityItem"]];
		}
		return s;
	}

- (NSMutableArray*) toMutableArray{
    NSMutableArray* s = [[NSMutableArray alloc]init];
    for(wcfCommunityItem *item in self) {
        [s addObject:item];
    }
    return s;
    
}
@end
