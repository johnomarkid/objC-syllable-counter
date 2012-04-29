//
//  SyllableCounter.m
//  WeHaiku
//
//  Created by Anthony Nichols on 4/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SyllableCounter.h"

@implementation SyllableCounter

+ (int)SyllableCountForWord:(NSString*)word  {
    // Basic array of lots of words
    NSArray *subsyl = [NSArray arrayWithObjects:@"cial", @"tia", @"cius", @"cious", @"uiet", @"gious", @"geous", @"priest",
                       @"giu", @"dge", @"ion", @"iou", @"sia$", @".che$", @".ched$", @".abe$",
                       @".ace$", @".ade$", @".age$", @".aged$", @".ake$", @".ale$", @".aled$",
                       @".ales$", @".ane$", @".ame$", @".ape$", @".are$", @".ase$", @".ashed$",
                       @".asque$", @".ate$", @".ave$", @".azed$", @".awe$", @".aze$", @".aped$",
                       @".athe$", @".athes$", @".ece$", @".ese$", @".esque$", @".esques$",
                       @".eze$", @".gue$", @".ibe$", @".ice$", @".ide$", @".ife$", @".ike$",
                       @".ile$", @".ime$", @".ine$", @".ipe$", @".iped$", @".ire$", @".ise$",
                       @".ished$", @".ite$", @".ive$", @".ize$", @".obe$", @".ode$", @".oke$",
                       @".ole$", @".ome$", @".one$", @".ope$", @".oque$", @".ore$", @".ose$",
                       @".osque$", @".osques$", @".ote$", @".ove$", @".pped$", @".sse$",
                       @".ssed$", @".ste$", @".ube$", @".uce$", @".ude$", @".uge$", @".uke$",
                       @".ule$", @".ules$", @".uled$", @".ume$", @".une$", @".upe$", @".ure$",
                       @".use$", @".ushed$", @".ute$", @".ved$", @".we$", @".wes$", @".wed$",
                       @".yse$", @".yze$", @".rse$", @".red$", @".rce$", @".rde$", @".ily$",
                       @".ne$", @".ely$", @".des$", @".gged$", @".kes$", @".ced$", @".ked$",
                       @".med$", @".mes$", @".ned$", @".sed$", @".nce$", @".rles$", @".nes$",
                       @".pes$", @".tes$", @".res$", @".ves$", @"ere$", nil];
    
    // Basic array of lots of words
    NSArray *addsyl = [NSArray arrayWithObjects:@"ia", @"riet", @"dien", @"ien", @"iet", @"iu", @"iest", @"io", @"ii", @"ily",@".oala$", @".iara$", @".ying$", @".earest", @".arer", @".aress",
                       @".eate$", @".eation$", @"[aeiouym]bl$", @"[aeiou]{3}", @"^mc",@"ism",
                       @"^mc",@"asm", @"([^aeiouy])\1l$", @"[^l]lien", @"^coa[dglx].",
                       @"[^gq]ua[^auieo]", @"dnt$", nil];
    
    // UBER EXCEPTIONS - WHOLE WORDS THAT SLIP THROUGH THE NET OR
    // SOMEHOW THROW A WOBBLY
    NSArray *exceptions_one = [NSArray arrayWithObjects:@"abe", @"ace", @"ade", @"age", @"ale", @"are", @"use", @"ate", nil];
    
    /*
    # Based on Greg Fast's Perl module Lingua::EN::Syllables
    #
    # Lowercase the word completely and then perform a 
    # regular expression substitution. The i option is 
    # saying ignore case and the m option is saying include
    # even newlines for '.' operator (which matches everything
    # usually except newlines). All it's effectively doing
    # is removing the first letter from the word so hello is ello
    # In this regard, the m option is pretty stupid but it's a
    # direct port..
     */
    NSString *lowercaseString = [word lowercaseString];
    NSString *regexString       = @"[^a-z]";
    NSString *replaceWithString = @"";
    NSString *replacedString    = [lowercaseString stringByReplacingOccurrencesOfRegex:regexString withString:replaceWithString options:NSRegularExpressionDotMatchesLineSeparators range:NSMakeRange(0, [lowercaseString length]) error:nil];


    NSArray *word_split = [replacedString componentsSeparatedByRegex:@"[^aeiouy]+"];
    
    // valid syllables
    NSMutableArray *valid_word_parts = [[NSMutableArray alloc]init];
    for (NSString *value in word_split) {
        if (![value isEqualToString:@""]) {
            [valid_word_parts addObject:value];
        }
    }
    
    int syllables = 0;
    
    // Eliminate syllable exceptions
    for (NSString *syl in subsyl) {
        NSArray *match_array = [replacedString componentsMatchedByRegex:[NSString stringWithFormat:@"%@",syl]];
        syllables -= [match_array count];
    }
    
    for (NSString *syl in addsyl) {
        NSArray *match_array = [replacedString componentsMatchedByRegex:[NSString stringWithFormat:@"%@",syl]];
        syllables -= [match_array count];
    }

    // exceptions
    if ([exceptions_one containsObject:[word lowercaseString]]) {
        syllables -= 1;
    }
    
    // Add valid word parts to syllable count
    syllables += [valid_word_parts count];
    
    // Account for 0 found
    if (syllables == 0) {
        syllables = 1;
    }
    else syllables = syllables;
    
    
    return syllables;
}

+ (int)SyllableCountForWords:(NSString*)words  {
    NSArray *myWords = [words componentsSeparatedByString:@" "];
    
    int totalCount = 0;
    for (NSString *word in myWords) {
        int wordCount = [SyllableCounter SyllableCountForWord:word];
        totalCount += wordCount;
    }
    
    return totalCount;
}

@end
