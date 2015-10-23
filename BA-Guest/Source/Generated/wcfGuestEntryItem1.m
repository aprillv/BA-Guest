/*
	wcfGuestEntryItem1.h
	The implementation of properties and methods for the wcfGuestEntryItem1 object.
	Generated by SudzC.com
*/
#import "wcfGuestEntryItem1.h"

@implementation wcfGuestEntryItem1
	@synthesize AgentFName = _AgentFName;
	@synthesize AgentLName = _AgentLName;
	@synthesize Email = _Email;
	@synthesize FirstNm = _FirstNm;
	@synthesize HearAboutUs = _HearAboutUs;
	@synthesize IdCia = _IdCia;
	@synthesize IdSub = _IdSub;
	@synthesize IdWeb = _IdWeb;
	@synthesize IdwebArea = _IdwebArea;
	@synthesize LastNm = _LastNm;
	@synthesize Msg = _Msg;
	@synthesize PhoneNo = _PhoneNo;
	@synthesize RealtorEmail = _RealtorEmail;
	@synthesize RealtorName = _RealtorName;
	@synthesize RealtorPhoneNo = _RealtorPhoneNo;
	@synthesize Realtoryn = _Realtoryn;
	@synthesize Refdate = _Refdate;
	@synthesize Sendyn = _Sendyn;
	@synthesize WebNm = _WebNm;
	@synthesize idnumber = _idnumber;

	- (id) init
	{
		if(self = [super init])
		{
			self.AgentFName = nil;
			self.AgentLName = nil;
			self.Email = nil;
			self.FirstNm = nil;
			self.HearAboutUs = nil;
			self.IdCia = nil;
			self.IdSub = nil;
			self.IdWeb = nil;
			self.IdwebArea = nil;
			self.LastNm = nil;
			self.Msg = nil;
			self.PhoneNo = nil;
			self.RealtorEmail = nil;
			self.RealtorName = nil;
			self.RealtorPhoneNo = nil;
			self.Refdate = nil;
			self.Sendyn = nil;
			self.WebNm = nil;

		}
		return self;
	}

	+ (wcfGuestEntryItem1*) newWithNode: (CXMLNode*) node
	{
		if(node == nil) { return nil; }
		return (wcfGuestEntryItem1*)[[[wcfGuestEntryItem1 alloc] initWithNode: node] autorelease];
	}

	- (id) initWithNode: (CXMLNode*) node {
		if(self = [super initWithNode: node])
		{
			self.AgentFName = [Soap getNodeValue: node withName: @"AgentFName"];
			self.AgentLName = [Soap getNodeValue: node withName: @"AgentLName"];
			self.Email = [Soap getNodeValue: node withName: @"Email"];
			self.FirstNm = [Soap getNodeValue: node withName: @"FirstNm"];
			self.HearAboutUs = [Soap getNodeValue: node withName: @"HearAboutUs"];
			self.IdCia = [Soap getNodeValue: node withName: @"IdCia"];
			self.IdSub = [Soap getNodeValue: node withName: @"IdSub"];
			self.IdWeb = [Soap getNodeValue: node withName: @"IdWeb"];
			self.IdwebArea = [Soap getNodeValue: node withName: @"IdwebArea"];
			self.LastNm = [Soap getNodeValue: node withName: @"LastNm"];
			self.Msg = [Soap getNodeValue: node withName: @"Msg"];
			self.PhoneNo = [Soap getNodeValue: node withName: @"PhoneNo"];
			self.RealtorEmail = [Soap getNodeValue: node withName: @"RealtorEmail"];
			self.RealtorName = [Soap getNodeValue: node withName: @"RealtorName"];
			self.RealtorPhoneNo = [Soap getNodeValue: node withName: @"RealtorPhoneNo"];
			self.Realtoryn = [[Soap getNodeValue: node withName: @"Realtoryn"] boolValue];
			self.Refdate = [Soap getNodeValue: node withName: @"Refdate"];
			self.Sendyn = [Soap getNodeValue: node withName: @"Sendyn"];
			self.WebNm = [Soap getNodeValue: node withName: @"WebNm"];
			self.idnumber = [[Soap getNodeValue: node withName: @"idnumber"] longLongValue];
		}
		return self;
	}

	- (NSMutableString*) serialize
	{
		return [self serialize: @"GuestEntryItem1"];
	}
  
	- (NSMutableString*) serialize: (NSString*) nodeName
	{
		NSMutableString* s = [NSMutableString string];
		[s appendFormat: @"<%@", nodeName];
		[s appendString: [self serializeAttributes]];
		[s appendString: @">"];
		[s appendString: [self serializeElements]];
		[s appendFormat: @"</%@>", nodeName];
		return s;
	}
	
	- (NSMutableString*) serializeElements
	{
		NSMutableString* s = [super serializeElements];
		if (self.AgentFName != nil) [s appendFormat: @"<AgentFName>%@</AgentFName>", [[self.AgentFName stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]];
		if (self.AgentLName != nil) [s appendFormat: @"<AgentLName>%@</AgentLName>", [[self.AgentLName stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]];
		if (self.Email != nil) [s appendFormat: @"<Email>%@</Email>", [[self.Email stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]];
		if (self.FirstNm != nil) [s appendFormat: @"<FirstNm>%@</FirstNm>", [[self.FirstNm stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]];
		if (self.HearAboutUs != nil) [s appendFormat: @"<HearAboutUs>%@</HearAboutUs>", [[self.HearAboutUs stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]];
		if (self.IdCia != nil) [s appendFormat: @"<IdCia>%@</IdCia>", [[self.IdCia stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]];
		if (self.IdSub != nil) [s appendFormat: @"<IdSub>%@</IdSub>", [[self.IdSub stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]];
		if (self.IdWeb != nil) [s appendFormat: @"<IdWeb>%@</IdWeb>", [[self.IdWeb stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]];
		if (self.IdwebArea != nil) [s appendFormat: @"<IdwebArea>%@</IdwebArea>", [[self.IdwebArea stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]];
		if (self.LastNm != nil) [s appendFormat: @"<LastNm>%@</LastNm>", [[self.LastNm stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]];
		if (self.Msg != nil) [s appendFormat: @"<Msg>%@</Msg>", [[self.Msg stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]];
		if (self.PhoneNo != nil) [s appendFormat: @"<PhoneNo>%@</PhoneNo>", [[self.PhoneNo stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]];
		if (self.RealtorEmail != nil) [s appendFormat: @"<RealtorEmail>%@</RealtorEmail>", [[self.RealtorEmail stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]];
		if (self.RealtorName != nil) [s appendFormat: @"<RealtorName>%@</RealtorName>", [[self.RealtorName stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]];
		if (self.RealtorPhoneNo != nil) [s appendFormat: @"<RealtorPhoneNo>%@</RealtorPhoneNo>", [[self.RealtorPhoneNo stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]];
		[s appendFormat: @"<Realtoryn>%@</Realtoryn>", (self.Realtoryn)?@"true":@"false"];
		if (self.Refdate != nil) [s appendFormat: @"<Refdate>%@</Refdate>", [[self.Refdate stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]];
		if (self.Sendyn != nil) [s appendFormat: @"<Sendyn>%@</Sendyn>", [[self.Sendyn stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]];
		if (self.WebNm != nil) [s appendFormat: @"<WebNm>%@</WebNm>", [[self.WebNm stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]];
		[s appendFormat: @"<idnumber>%@</idnumber>", [NSString stringWithFormat: @"%ld", self.idnumber]];

		return s;
	}
	
	- (NSMutableString*) serializeAttributes
	{
		NSMutableString* s = [super serializeAttributes];

		return s;
	}
	
	-(BOOL)isEqual:(id)object{
		if(object != nil && [object isKindOfClass:[wcfGuestEntryItem1 class]]) {
			return [[self serialize] isEqualToString:[object serialize]];
		}
		return NO;
	}
	
	-(NSUInteger)hash{
		return [Soap generateHash:self];

	}
	
	- (void) dealloc
	{
		if(self.AgentFName != nil) { [self.AgentFName release]; }
		if(self.AgentLName != nil) { [self.AgentLName release]; }
		if(self.Email != nil) { [self.Email release]; }
		if(self.FirstNm != nil) { [self.FirstNm release]; }
		if(self.HearAboutUs != nil) { [self.HearAboutUs release]; }
		if(self.IdCia != nil) { [self.IdCia release]; }
		if(self.IdSub != nil) { [self.IdSub release]; }
		if(self.IdWeb != nil) { [self.IdWeb release]; }
		if(self.IdwebArea != nil) { [self.IdwebArea release]; }
		if(self.LastNm != nil) { [self.LastNm release]; }
		if(self.Msg != nil) { [self.Msg release]; }
		if(self.PhoneNo != nil) { [self.PhoneNo release]; }
		if(self.RealtorEmail != nil) { [self.RealtorEmail release]; }
		if(self.RealtorName != nil) { [self.RealtorName release]; }
		if(self.RealtorPhoneNo != nil) { [self.RealtorPhoneNo release]; }
		if(self.Refdate != nil) { [self.Refdate release]; }
		if(self.Sendyn != nil) { [self.Sendyn release]; }
		if(self.WebNm != nil) { [self.WebNm release]; }
		[super dealloc];
	}

@end
