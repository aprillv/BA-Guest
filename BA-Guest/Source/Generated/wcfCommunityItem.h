/*
	wcfCommunityItem.h
	The interface definition of properties and methods for the wcfCommunityItem object.
	Generated by SudzC.com
*/

#import "Soap.h"
	

@interface wcfCommunityItem : SoapObject
{
	NSString* _CiaName;
	NSString* _City;
	NSString* _IdArea;
	NSString* _IdCia;
	NSString* _IdSub;
	NSString* _IdWeb;
	NSString* _WebArea;
	NSString* _WebCommunity;
	
}
		
	@property (retain, nonatomic) NSString* CiaName;
	@property (retain, nonatomic) NSString* City;
	@property (retain, nonatomic) NSString* IdArea;
	@property (retain, nonatomic) NSString* IdCia;
	@property (retain, nonatomic) NSString* IdSub;
	@property (retain, nonatomic) NSString* IdWeb;
	@property (retain, nonatomic) NSString* WebArea;
	@property (retain, nonatomic) NSString* WebCommunity;

	+ (wcfCommunityItem*) newWithNode: (CXMLNode*) node;
	- (id) initWithNode: (CXMLNode*) node;
	- (NSMutableString*) serialize;
	- (NSMutableString*) serialize: (NSString*) nodeName;
	- (NSMutableString*) serializeAttributes;
	- (NSMutableString*) serializeElements;

@end
