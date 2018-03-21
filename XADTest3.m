/*
 * XADTest3.m
 *
 * Copyright (c) 2017-present, MacPaw Inc. All rights reserved.
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
 * MA 02110-1301  USA
 */
#import "XADArchiveParser.h"
#import "XADTestUtilities.h"

NSString *EscapeString(NSString *str)
{
	NSMutableString *res=[NSMutableString string];
	int length=[str length];
	for(int i=0;i<length;i++)
	{
		unichar c=[str characterAtIndex:i];
		if(c<32) [res appendFormat:@"^%c",c+64];
		else [res appendFormat:@"%C",c];
	}
	return res;
}

@interface ArchiveTester:NSObject
{
	int indent;
}
@end

@implementation ArchiveTester

-(id)initWithIndentLevel:(int)indentlevel
{
	if((self=[super init]))
	{
		indent=indentlevel;
	}
	return self;
}

-(void)archiveParser:(XADArchiveParser *)parser foundEntryWithDictionary:(NSDictionary *)dict
{
	for(int i=0;i<indent;i++) printf(" ");

	NSNumber *dir=[dict objectForKey:XADIsDirectoryKey];
	NSString *link=[[parser linkDestinationForDictionary:dict] string];
	NSNumber *compsize=[dict objectForKey:XADCompressedSizeKey];
	NSNumber *size=[dict objectForKey:XADFileSizeKey];
	CSHandle *fh;

	BOOL failed=NO;

	if(dir&&[dir boolValue]) printf("-  ");
	else if(link) printf("-  ");
	else
	{
		fh=[parser handleForEntryWithDictionary:dict wantChecksum:YES];
		[fh seekToEndOfFile];

		if(!fh) { printf("!  "); failed=YES; }
		else
		{
			if([fh hasChecksum])
			{
				if([fh isChecksumCorrect]) printf("o");
				else { printf("x"); failed=YES; }
			}
			else printf("?");

			if(size)
			{
				if([size longLongValue]==[fh offsetInFile]) printf("  ");
				else { printf("x "); failed=YES; }
			}
			else printf("  ");
		}
	}

	NSString *name=EscapeString([[dict objectForKey:XADFileNameKey] string]);
	printf("%s (",[name UTF8String]);

	if(dir&&[dir boolValue])
	{
		printf("dir");

		NSNumber *rsrc=[dict objectForKey:XADIsResourceForkKey];
		if(rsrc&&[rsrc boolValue]) printf(", rsrc");
	}
	else if(link) printf("-> %s",[link UTF8String]);
	else
	{
		if(compsize) printf("%lld",[compsize longLongValue]);
		else printf("?");

		printf("/");

		if(size) printf("%lld",[size longLongValue]);
		else printf("?");

		XADString *compname=[dict objectForKey:XADCompressionNameKey];
		if(compname) printf(", %s",[[compname string] UTF8String]);

		NSNumber *rsrc=[dict objectForKey:XADIsResourceForkKey];
		if(rsrc&&[rsrc boolValue]) printf(", rsrc");

		if(!fh) printf(", unsupported");
	}

	printf(")\n");

	if(failed)
	{
		if(getenv("XADTestStrict"))
		{
			printf("Encountered failure in strict mode, exiting.\n");
			exit(1);
		}
	}

	NSNumber *arch=[dict objectForKey:XADIsArchiveKey];
	if(arch&&[arch boolValue])
	{
		[fh seekToFileOffset:0];
		XADArchiveParser *parser=[XADArchiveParser archiveParserForHandle:fh name:name];
		[parser setDelegate:[[[ArchiveTester alloc] initWithIndentLevel:indent+2] autorelease]];
		[parser parse];
	}
}

-(BOOL)archiveParsingShouldStop:(XADArchiveParser *)parser
{
	return NO;
}

@end

int main(int argc,char **argv)
{
	NSString *filename;
	NSEnumerator *enumerator=[FilesForArgs(argc,argv) objectEnumerator];
	while(filename=[enumerator nextObject])
	{
		NSAutoreleasePool *pool=[[NSAutoreleasePool alloc] init];

		printf("Testing %s...\n",[filename UTF8String]);

		XADArchiveParser *parser=[XADArchiveParser archiveParserForPath:filename];

		[parser setDelegate:[[[ArchiveTester alloc] initWithIndentLevel:2] autorelease]];

		NSString *pass=FigureOutPassword(filename);
		if(pass) [parser setPassword:pass];

		@try {
			[parser parse];
		} @catch(id e) {
			printf("*** Exception: %s\n",[[e description] UTF8String]);
		}

		[pool release];
	}
	return 0;
}
