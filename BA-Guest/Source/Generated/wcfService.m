/*
	wcfService.m
	The implementation classes and methods for the Service web service.
	Generated by SudzC.com
*/

#import "wcfService.h"
				
#import "Soap.h"
	
#import "wcfArrayOfCommunityItem.h"
#import "wcfGuestEntryItem.h"
#import "wcfKeyValueItem.h"
#import "wcfGuestEntryItem1.h"
#import "wcfCommunityItem.h"

/* Implementation of the service */
				
@implementation wcfService

	- (id) init
	{
		if(self = [super init])
		{
			self.serviceUrl = @"http://ws3.buildersaccess.com/Service.svc";
			self.namespace = @"http://tempuri.org/";
			self.headers = nil;
			self.logging = NO;
		}
		return self;
	}
	
	- (id) initWithUsername: (NSString*) username andPassword: (NSString*) password {
		if(self = [super initWithUsername:username andPassword:password]) {
		}
		return self;
	}
	
	+ (wcfService*) service {
		return [wcfService serviceWithUsername:nil andPassword:nil];
	}
	
	+ (wcfService*) serviceWithUsername: (NSString*) username andPassword: (NSString*) password {
		return [[[wcfService alloc] initWithUsername:username andPassword:password] autorelease];
	}

		
	/* Returns wcfKeyValueItem*.  */
	- (SoapRequest*) xCheckLogin: (id <SoapDelegate>) handler xemail: (NSString*) xemail xpassword: (NSString*) xpassword EquipmentType: (NSString*) EquipmentType
	{
		return [self xCheckLogin: handler action: nil xemail: xemail xpassword: xpassword EquipmentType: EquipmentType];
	}

	- (SoapRequest*) xCheckLogin: (id) _target action: (SEL) _action xemail: (NSString*) xemail xpassword: (NSString*) xpassword EquipmentType: (NSString*) EquipmentType
		{
		NSMutableArray* _params = [NSMutableArray array];
		
		[_params addObject: [[[SoapParameter alloc] initWithValue: xemail forName: @"xemail"] autorelease]];
		[_params addObject: [[[SoapParameter alloc] initWithValue: xpassword forName: @"xpassword"] autorelease]];
		[_params addObject: [[[SoapParameter alloc] initWithValue: EquipmentType forName: @"EquipmentType"] autorelease]];
		NSString* _envelope = [Soap createEnvelope: @"xCheckLogin" forNamespace: self.namespace withParameters: _params withHeaders: self.headers];
		SoapRequest* _request = [SoapRequest create: _target action: _action service: self soapAction: @"http://tempuri.org/IService/xCheckLogin" postData: _envelope deserializeTo: [[wcfKeyValueItem alloc] autorelease]];
		[_request send];
		return _request;
	}

	/* Returns NSString*.  */
	- (SoapRequest*) xSendGetPasswordMail: (id <SoapDelegate>) handler xemail: (NSString*) xemail EquipmentType: (NSString*) EquipmentType
	{
		return [self xSendGetPasswordMail: handler action: nil xemail: xemail EquipmentType: EquipmentType];
	}

	- (SoapRequest*) xSendGetPasswordMail: (id) _target action: (SEL) _action xemail: (NSString*) xemail EquipmentType: (NSString*) EquipmentType
		{
		NSMutableArray* _params = [NSMutableArray array];
		
		[_params addObject: [[[SoapParameter alloc] initWithValue: xemail forName: @"xemail"] autorelease]];
		[_params addObject: [[[SoapParameter alloc] initWithValue: EquipmentType forName: @"EquipmentType"] autorelease]];
		NSString* _envelope = [Soap createEnvelope: @"xSendGetPasswordMail" forNamespace: self.namespace withParameters: _params withHeaders: self.headers];
		SoapRequest* _request = [SoapRequest create: _target action: _action service: self soapAction: @"http://tempuri.org/IService/xSendGetPasswordMail" postData: _envelope deserializeTo: @"NSString"];
		[_request send];
		return _request;
	}

	/* Returns NSString*.  */
	- (SoapRequest*) xisupdate_ipad2: (id <SoapDelegate>) handler version: (NSString*) version
	{
		return [self xisupdate_ipad2: handler action: nil version: version];
	}

	- (SoapRequest*) xisupdate_ipad2: (id) _target action: (SEL) _action version: (NSString*) version
		{
		NSMutableArray* _params = [NSMutableArray array];
		
		[_params addObject: [[[SoapParameter alloc] initWithValue: version forName: @"version"] autorelease]];
		NSString* _envelope = [Soap createEnvelope: @"xisupdate_ipad2" forNamespace: self.namespace withParameters: _params withHeaders: self.headers];
		SoapRequest* _request = [SoapRequest create: _target action: _action service: self soapAction: @"http://tempuri.org/IService/xisupdate_ipad2" postData: _envelope deserializeTo: @"NSString"];
		[_request send];
		return _request;
	}

	/* Returns NSString*.  */
	- (SoapRequest*) xisupdate_tablet: (id <SoapDelegate>) handler version: (NSString*) version
	{
		return [self xisupdate_tablet: handler action: nil version: version];
	}

	- (SoapRequest*) xisupdate_tablet: (id) _target action: (SEL) _action version: (NSString*) version
		{
		NSMutableArray* _params = [NSMutableArray array];
		
		[_params addObject: [[[SoapParameter alloc] initWithValue: version forName: @"version"] autorelease]];
		NSString* _envelope = [Soap createEnvelope: @"xisupdate_tablet" forNamespace: self.namespace withParameters: _params withHeaders: self.headers];
		SoapRequest* _request = [SoapRequest create: _target action: _action service: self soapAction: @"http://tempuri.org/IService/xisupdate_tablet" postData: _envelope deserializeTo: @"NSString"];
		[_request send];
		return _request;
	}

	/* Returns NSMutableArray*.  */
	- (SoapRequest*) xGetCommunity: (id <SoapDelegate>) handler xemail: (NSString*) xemail xpassword: (NSString*) xpassword EquipmentType: (NSString*) EquipmentType
	{
		return [self xGetCommunity: handler action: nil xemail: xemail xpassword: xpassword EquipmentType: EquipmentType];
	}

	- (SoapRequest*) xGetCommunity: (id) _target action: (SEL) _action xemail: (NSString*) xemail xpassword: (NSString*) xpassword EquipmentType: (NSString*) EquipmentType
		{
		NSMutableArray* _params = [NSMutableArray array];
		
		[_params addObject: [[[SoapParameter alloc] initWithValue: xemail forName: @"xemail"] autorelease]];
		[_params addObject: [[[SoapParameter alloc] initWithValue: xpassword forName: @"xpassword"] autorelease]];
		[_params addObject: [[[SoapParameter alloc] initWithValue: EquipmentType forName: @"EquipmentType"] autorelease]];
		NSString* _envelope = [Soap createEnvelope: @"xGetCommunity" forNamespace: self.namespace withParameters: _params withHeaders: self.headers];
		SoapRequest* _request = [SoapRequest create: _target action: _action service: self soapAction: @"http://tempuri.org/IService/xGetCommunity" postData: _envelope deserializeTo: [[wcfArrayOfCommunityItem alloc] autorelease]];
		[_request send];
		return _request;
	}

	/* Returns NSString*.  */
	- (SoapRequest*) xUpdCommunity2: (id <SoapDelegate>) handler xemail: (NSString*) xemail xpassword: (NSString*) xpassword guestData: (NSString*) guestData EquipmentType: (NSString*) EquipmentType
	{
		return [self xUpdCommunity2: handler action: nil xemail: xemail xpassword: xpassword guestData: guestData EquipmentType: EquipmentType];
	}

	- (SoapRequest*) xUpdCommunity2: (id) _target action: (SEL) _action xemail: (NSString*) xemail xpassword: (NSString*) xpassword guestData: (NSString*) guestData EquipmentType: (NSString*) EquipmentType
		{
		NSMutableArray* _params = [NSMutableArray array];
		
		[_params addObject: [[[SoapParameter alloc] initWithValue: xemail forName: @"xemail"] autorelease]];
		[_params addObject: [[[SoapParameter alloc] initWithValue: xpassword forName: @"xpassword"] autorelease]];
		[_params addObject: [[[SoapParameter alloc] initWithValue: guestData forName: @"guestData"] autorelease]];
		[_params addObject: [[[SoapParameter alloc] initWithValue: EquipmentType forName: @"EquipmentType"] autorelease]];
		NSString* _envelope = [Soap createEnvelope: @"xUpdCommunity2" forNamespace: self.namespace withParameters: _params withHeaders: self.headers];
		SoapRequest* _request = [SoapRequest create: _target action: _action service: self soapAction: @"http://tempuri.org/IService/xUpdCommunity2" postData: _envelope deserializeTo: @"NSString"];
		[_request send];
		return _request;
	}

	/* Returns NSString*.  */
	- (SoapRequest*) xUpdCommunity1: (id <SoapDelegate>) handler xemail: (NSString*) xemail xpassword: (NSString*) xpassword guestData: (NSString*) guestData EquipmentType: (NSString*) EquipmentType
	{
		return [self xUpdCommunity1: handler action: nil xemail: xemail xpassword: xpassword guestData: guestData EquipmentType: EquipmentType];
	}

	- (SoapRequest*) xUpdCommunity1: (id) _target action: (SEL) _action xemail: (NSString*) xemail xpassword: (NSString*) xpassword guestData: (NSString*) guestData EquipmentType: (NSString*) EquipmentType
		{
		NSMutableArray* _params = [NSMutableArray array];
		
		[_params addObject: [[[SoapParameter alloc] initWithValue: xemail forName: @"xemail"] autorelease]];
		[_params addObject: [[[SoapParameter alloc] initWithValue: xpassword forName: @"xpassword"] autorelease]];
		[_params addObject: [[[SoapParameter alloc] initWithValue: guestData forName: @"guestData"] autorelease]];
		[_params addObject: [[[SoapParameter alloc] initWithValue: EquipmentType forName: @"EquipmentType"] autorelease]];
		NSString* _envelope = [Soap createEnvelope: @"xUpdCommunity1" forNamespace: self.namespace withParameters: _params withHeaders: self.headers];
		SoapRequest* _request = [SoapRequest create: _target action: _action service: self soapAction: @"http://tempuri.org/IService/xUpdCommunity1" postData: _envelope deserializeTo: @"NSString"];
		[_request send];
		return _request;
	}

	/* Returns wcfGuestEntryItem*.  */
	- (SoapRequest*) xCheckGuest: (id <SoapDelegate>) handler xemail: (NSString*) xemail xpassword: (NSString*) xpassword xidcia: (NSString*) xidcia xidcommunity: (NSString*) xidcommunity xregEmail: (NSString*) xregEmail xregMobile: (NSString*) xregMobile EquipmentType: (NSString*) EquipmentType
	{
		return [self xCheckGuest: handler action: nil xemail: xemail xpassword: xpassword xidcia: xidcia xidcommunity: xidcommunity xregEmail: xregEmail xregMobile: xregMobile EquipmentType: EquipmentType];
	}

	- (SoapRequest*) xCheckGuest: (id) _target action: (SEL) _action xemail: (NSString*) xemail xpassword: (NSString*) xpassword xidcia: (NSString*) xidcia xidcommunity: (NSString*) xidcommunity xregEmail: (NSString*) xregEmail xregMobile: (NSString*) xregMobile EquipmentType: (NSString*) EquipmentType
		{
		NSMutableArray* _params = [NSMutableArray array];
		
		[_params addObject: [[[SoapParameter alloc] initWithValue: xemail forName: @"xemail"] autorelease]];
		[_params addObject: [[[SoapParameter alloc] initWithValue: xpassword forName: @"xpassword"] autorelease]];
		[_params addObject: [[[SoapParameter alloc] initWithValue: xidcia forName: @"xidcia"] autorelease]];
		[_params addObject: [[[SoapParameter alloc] initWithValue: xidcommunity forName: @"xidcommunity"] autorelease]];
		[_params addObject: [[[SoapParameter alloc] initWithValue: xregEmail forName: @"xregEmail"] autorelease]];
		[_params addObject: [[[SoapParameter alloc] initWithValue: xregMobile forName: @"xregMobile"] autorelease]];
		[_params addObject: [[[SoapParameter alloc] initWithValue: EquipmentType forName: @"EquipmentType"] autorelease]];
		NSString* _envelope = [Soap createEnvelope: @"xCheckGuest" forNamespace: self.namespace withParameters: _params withHeaders: self.headers];
		SoapRequest* _request = [SoapRequest create: _target action: _action service: self soapAction: @"http://tempuri.org/IService/xCheckGuest" postData: _envelope deserializeTo: [[wcfGuestEntryItem alloc] autorelease]];
		[_request send];
		return _request;
	}

	/* Returns wcfGuestEntryItem1*.  */
	- (SoapRequest*) xCheckGuest1: (id <SoapDelegate>) handler xemail: (NSString*) xemail xpassword: (NSString*) xpassword xidcia: (NSString*) xidcia xidcommunity: (NSString*) xidcommunity xregEmail: (NSString*) xregEmail xregMobile: (NSString*) xregMobile EquipmentType: (NSString*) EquipmentType
	{
		return [self xCheckGuest1: handler action: nil xemail: xemail xpassword: xpassword xidcia: xidcia xidcommunity: xidcommunity xregEmail: xregEmail xregMobile: xregMobile EquipmentType: EquipmentType];
	}

	- (SoapRequest*) xCheckGuest1: (id) _target action: (SEL) _action xemail: (NSString*) xemail xpassword: (NSString*) xpassword xidcia: (NSString*) xidcia xidcommunity: (NSString*) xidcommunity xregEmail: (NSString*) xregEmail xregMobile: (NSString*) xregMobile EquipmentType: (NSString*) EquipmentType
		{
		NSMutableArray* _params = [NSMutableArray array];
		
		[_params addObject: [[[SoapParameter alloc] initWithValue: xemail forName: @"xemail"] autorelease]];
		[_params addObject: [[[SoapParameter alloc] initWithValue: xpassword forName: @"xpassword"] autorelease]];
		[_params addObject: [[[SoapParameter alloc] initWithValue: xidcia forName: @"xidcia"] autorelease]];
		[_params addObject: [[[SoapParameter alloc] initWithValue: xidcommunity forName: @"xidcommunity"] autorelease]];
		[_params addObject: [[[SoapParameter alloc] initWithValue: xregEmail forName: @"xregEmail"] autorelease]];
		[_params addObject: [[[SoapParameter alloc] initWithValue: xregMobile forName: @"xregMobile"] autorelease]];
		[_params addObject: [[[SoapParameter alloc] initWithValue: EquipmentType forName: @"EquipmentType"] autorelease]];
		NSString* _envelope = [Soap createEnvelope: @"xCheckGuest1" forNamespace: self.namespace withParameters: _params withHeaders: self.headers];
		SoapRequest* _request = [SoapRequest create: _target action: _action service: self soapAction: @"http://tempuri.org/IService/xCheckGuest1" postData: _envelope deserializeTo: [[wcfGuestEntryItem1 alloc] autorelease]];
		[_request send];
		return _request;
	}

	/* Returns NSString*.  */
	- (SoapRequest*) xUpdGuest2: (id <SoapDelegate>) handler xemail: (NSString*) xemail xpassword: (NSString*) xpassword xidnumber: (NSString*) xidnumber guestData: (NSString*) guestData EquipmentType: (NSString*) EquipmentType
	{
		return [self xUpdGuest2: handler action: nil xemail: xemail xpassword: xpassword xidnumber: xidnumber guestData: guestData EquipmentType: EquipmentType];
	}

	- (SoapRequest*) xUpdGuest2: (id) _target action: (SEL) _action xemail: (NSString*) xemail xpassword: (NSString*) xpassword xidnumber: (NSString*) xidnumber guestData: (NSString*) guestData EquipmentType: (NSString*) EquipmentType
		{
		NSMutableArray* _params = [NSMutableArray array];
		
		[_params addObject: [[[SoapParameter alloc] initWithValue: xemail forName: @"xemail"] autorelease]];
		[_params addObject: [[[SoapParameter alloc] initWithValue: xpassword forName: @"xpassword"] autorelease]];
		[_params addObject: [[[SoapParameter alloc] initWithValue: xidnumber forName: @"xidnumber"] autorelease]];
		[_params addObject: [[[SoapParameter alloc] initWithValue: guestData forName: @"guestData"] autorelease]];
		[_params addObject: [[[SoapParameter alloc] initWithValue: EquipmentType forName: @"EquipmentType"] autorelease]];
		NSString* _envelope = [Soap createEnvelope: @"xUpdGuest2" forNamespace: self.namespace withParameters: _params withHeaders: self.headers];
		SoapRequest* _request = [SoapRequest create: _target action: _action service: self soapAction: @"http://tempuri.org/IService/xUpdGuest2" postData: _envelope deserializeTo: @"NSString"];
		[_request send];
		return _request;
	}


@end
	