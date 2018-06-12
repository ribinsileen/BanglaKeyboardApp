//
//  AvroKeyboard
//
//  Created by Rifat Nabi on 6/28/12.
//  Copyright (c) 2012 OmicronLab. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Suggestion : NSObject {
    NSMutableArray* _suggestions;
}

+ (Suggestion *)sharedInstance;

- (void)clearSuggestions;
- (NSMutableArray*)getList:(NSString*)term;
- (BOOL)isKar:(NSString*)letter;
- (BOOL)isVowel:(NSString*)letter;

@end
