//
//  AvroKeyboard
//
//  Created by Rifat Nabi on 6/24/12.
//  Copyright (c) 2012 OmicronLab. All rights reserved.
//

#import "AutoCorrect.h"
#import "AvroParser.h"

static AutoCorrect* sharedInstance = nil;

@implementation AutoCorrect

@synthesize autoCorrectEntries = _autoCorrectEntries;

+ (AutoCorrect *)sharedInstance  {
    if (sharedInstance == nil) {
        [[self alloc] init]; // assignment not done here, see allocWithZone
    }
	return sharedInstance;
}

+ (id)allocWithZone:(NSZone *)zone {
    if (sharedInstance == nil) {
        sharedInstance = [super allocWithZone:zone];
        return sharedInstance;  // assignment and return on first allocation
    }
    return sharedInstance; //on subsequent allocation attempts return nil
}

- (id)copyWithZone:(NSZone *)zone {
    return self;
}

- (id)init {
    self = [super init];
    if (self) {
        // Open the file
        NSString *fileName = [[NSBundle mainBundle] pathForResource:@"autodict" ofType:@"dct"];
        const char *fn = [fileName UTF8String];
        FILE *file = fopen(fn, "r");
        
        // Read from the file
        char replaceBuffer[512], withBuffer[512];
        _autoCorrectEntries = [[NSMutableArray alloc] init];
        while(fscanf(file, "%s %[^\n]\n", replaceBuffer, withBuffer) == 2) {
            NSString* replace = [NSString stringWithFormat:@"%s", replaceBuffer];
            NSString* with = [NSString stringWithFormat:@"%s", withBuffer];
            
            if ([replace isEqualToString:with] == NO) {
                with = [[AvroParser sharedInstance] parse:with];
            }
            
            NSMutableDictionary* item = [[NSMutableDictionary alloc] initWithObjectsAndKeys:replace, @"replace", with, @"with", nil];
            [_autoCorrectEntries addObject:item];
        }
        fclose(file);
    }
    return self;
}

// Instance Methods
- (NSString*)find:(NSString*)term {
    term = [[AvroParser sharedInstance] fix:term];
    // Binary Search
    int left = 0, right = [_autoCorrectEntries count] -1, mid;
    while (right >= left) {
        mid = (left + right) / 2;
        NSDictionary* item = [_autoCorrectEntries objectAtIndex:mid];
        NSComparisonResult comp = [term compare:[item objectForKey:@"replace"]];
        if (comp == NSOrderedDescending) {
            left = mid + 1;
        } else if (comp == NSOrderedAscending) {
            right = mid - 1;
        } else {
            return [item objectForKey:@"with"];
        }
    }
    return nil;
}

@end
