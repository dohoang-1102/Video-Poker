//  NSCountedSet+SuperCountedSet.h
//  Video Poker
//  Created by Martin Nash on 9/28/12.
//  Copyright (c) 2012 Martin Nash. All rights reserved.

#import <Foundation/Foundation.h>

@interface NSCountedSet (SuperCountedSet)

-(NSSet *) objectsWithCountEqualTo:(NSNumber *)count;
-(NSSet *) objectsWithCountGreaterThan:(NSNumber *)count;
-(NSSet *) objectsWithCountLessThan:(NSNumber *)count;
-(NSSet *) objectsWithCountGreaterThanOrEqualTo:(NSNumber *)count;
-(NSSet *) objectsWithCountLessThanOrEqualTo:(NSNumber *)count;

-(NSArray *)arrayOfCounts;
-(NSArray *)arrayOfCountsAscending;
-(NSArray *)arrayOfCountsDescending;
@end
