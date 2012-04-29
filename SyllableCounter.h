//
//  SyllableCounter.h
//  WeHaiku
//
//  Created by Anthony Nichols on 4/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RegexKitLite.h"

@interface SyllableCounter : NSObject

+ (int)SyllableCountForWord:(NSString*)word;
+ (int)SyllableCountForWords:(NSString*)words;

@end
