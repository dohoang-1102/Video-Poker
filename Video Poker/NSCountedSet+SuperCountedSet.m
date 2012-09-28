//  NSCountedSet+SuperCountedSet.m
//  Video Poker
//  Created by Martin Nash on 9/28/12.
//  Copyright (c) 2012 Martin Nash. All rights reserved.

#import "NSCountedSet+SuperCountedSet.h"

@implementation NSCountedSet (SuperCountedSet)

-(NSSet *)objectsWithCountEqualTo:(NSNumber *)count
{
    NSMutableSet* passingObjects = [NSMutableSet set];

    [self enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {

        NSUInteger occurrences = [self countForObject: obj];
        if (occurrences == count.unsignedIntegerValue)
            [passingObjects addObject: obj];

    }];
    
    return passingObjects;
}

-(NSSet *)objectsWithCountGreaterThan:(NSNumber *)count
{
    NSMutableSet* passingObjects = [NSMutableSet set];
    
    [self enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
        
        NSUInteger occurrences = [self countForObject: obj];
        if (occurrences > count.unsignedIntegerValue)
            [passingObjects addObject: obj];
        
    }];
    
    return passingObjects;
}

-(NSSet *)objectsWithCountLessThan:(NSNumber *)count
{
    NSMutableSet* passingObjects = [NSMutableSet set];
    
    [self enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
        
        NSUInteger occurrences = [self countForObject: obj];
        if (occurrences < count.unsignedIntegerValue)
            [passingObjects addObject: obj];
        
    }];
    
    return passingObjects;
}

-(NSSet *)objectsWithCountGreaterThanOrEqualTo:(NSNumber *)count
{
    NSMutableSet* passingObjects = [NSMutableSet set];
    
    [self enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
        
        NSUInteger occurrences = [self countForObject: obj];
        if (occurrences >= count.unsignedIntegerValue)
            [passingObjects addObject: obj];
        
    }];
    
    return passingObjects;
}

-(NSSet *)objectsWithCountLessThanOrEqualTo:(NSNumber *)count
{
    NSMutableSet* passingObjects = [NSMutableSet set];
    
    [self enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
        
        NSUInteger occurrences = [self countForObject: obj];
        if (occurrences <= count.unsignedIntegerValue)
            [passingObjects addObject: obj];
        
    }];
    
    return passingObjects;
}


#pragma mark - Counts


-(NSArray *)arrayOfCounts
{
    NSMutableArray *objectCounts = [NSMutableArray array];
    
    [self enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
        NSUInteger count = [self countForObject: obj];
        [objectCounts addObject: @(count)];
    }];
    
    return objectCounts;
}

-(NSArray *)arrayOfCountsAscending
{
    NSArray *counts = [self arrayOfCounts];
    NSSortDescriptor* desc = [NSSortDescriptor sortDescriptorWithKey: @"intValue" ascending: YES];
    return [counts sortedArrayUsingDescriptors: @[ desc ]];
}

-(NSArray *)arrayOfCountsDescending
{
    NSArray *counts = [self arrayOfCounts];
    NSSortDescriptor* desc = [NSSortDescriptor sortDescriptorWithKey: @"intValue" ascending: NO];
    return [counts sortedArrayUsingDescriptors: @[ desc ]];
}

@end
