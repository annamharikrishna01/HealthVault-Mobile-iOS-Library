//
//  MobilePlatformTest.m
//  HealthVault Mobile Library for iOS
//
// Copyright 2011 Microsoft Corp.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
// 
// http://www.apache.org/licenses/LICENSE-2.0
// 
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

#import "MobilePlatformTest.h"
#import "../HVMobile/MobilePlatform.h"


@implementation MobilePlatformTest

- (void)testSha256Hash {
	NSString* testString = @"The quick brown fox jumps over the lazy dog";
	
	NSString* expectedResult = @"16j7swfXgJRpypq8sAguT41WUeRtPNt2LQLQvzfJ5ZI=";
	
	NSString* result = [MobilePlatform computeSha256Hash:testString];
	
	NSComparisonResult compareResult = [result caseInsensitiveCompare:expectedResult];
	
	STAssertTrue(NSOrderedSame == compareResult, @"SHA256 hash isn't equal to expected.");
}

- (void)testLibraryNameLength {
	NSString* abbreviationAndVersion = [MobilePlatform platformAbbreviationAndVersion];
	
	STAssertTrue(abbreviationAndVersion.length >=7, @"Platform abbriviarute is very small.");
	STAssertTrue(abbreviationAndVersion.length <= 19, @"Platform abbreviture is very long.");
}

- (void)testHmacSha256 {
	NSUInteger keyLength = 20;
	NSMutableData* key = [NSMutableData dataWithLength:20];
	int8_t* keyBytes = (int8_t *)key.mutableBytes;
	for (NSUInteger i = 0; i < keyLength; i++)
	{
		keyBytes[i] = 0x0b;
	}
	
	NSString* testString = @"Hi There";
	NSString* result = [MobilePlatform computeSha256Hmac:key :testString];
	NSComparisonResult compareResult = [result caseInsensitiveCompare:@"sDRMYdjbOFNcqK/OrwvxK4gdwgDJgz2nJuk3bC4yz/c="];

	STAssertTrue(NSOrderedSame == compareResult, @"SHA256hmac isn't equal to expected.");
	
} 

@end
