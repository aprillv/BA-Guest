/*
	wcfGuestEntryItem.h
	The interface definition of properties and methods for the wcfGuestEntryItem object.
	Generated by SudzC.com
*/

#import "Soap.h"
	

@interface wcfGuestEntryItem : SoapObject
{
	NSString* _AgentFName;
	NSString* _AgentLName;
	NSString* _Email;
	NSString* _FirstNm;
	NSString* _HearAboutUs;
	NSString* _IdCia;
	NSString* _IdSub;
	NSString* _IdWeb;
	NSString* _IdwebArea;
	NSString* _LastNm;
	NSString* _Msg;
	NSString* _PhoneNo;
	NSString* _RealtorName;
	NSString* _Refdate;
	NSString* _Sendyn;
	NSString* _WebNm;
	long _idnumber;
	
}
		
	@property (retain, nonatomic) NSString* AgentFName;
	@property (retain, nonatomic) NSString* AgentLName;
	@property (retain, nonatomic) NSString* Email;
	@property (retain, nonatomic) NSString* FirstNm;
	@property (retain, nonatomic) NSString* HearAboutUs;
	@property (retain, nonatomic) NSString* IdCia;
	@property (retain, nonatomic) NSString* IdSub;
	@property (retain, nonatomic) NSString* IdWeb;
	@property (retain, nonatomic) NSString* IdwebArea;
	@property (retain, nonatomic) NSString* LastNm;
	@property (retain, nonatomic) NSString* Msg;
	@property (retain, nonatomic) NSString* PhoneNo;
	@property (retain, nonatomic) NSString* RealtorName;
	@property (retain, nonatomic) NSString* Refdate;
	@property (retain, nonatomic) NSString* Sendyn;
	@property (retain, nonatomic) NSString* WebNm;
	@property long idnumber;

	+ (wcfGuestEntryItem*) newWithNode: (CXMLNode*) node;
	- (id) initWithNode: (CXMLNode*) node;
	- (NSMutableString*) serialize;
	- (NSMutableString*) serialize: (NSString*) nodeName;
	- (NSMutableString*) serializeAttributes;
	- (NSMutableString*) serializeElements;

@end
