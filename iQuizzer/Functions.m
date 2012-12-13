//
//  Functions.m
//  iQuizzer
//
//  Created by Tiago Bencardino on 27/11/12.
//  Copyright (c) 2012 Tiago Bencardino. All rights reserved.
//

#import "Functions.h"

@implementation Functions
+(NSArray*)shuffle:(NSMutableArray*)array{
    for (int x = 0; x < [array count]; x++) {
        int randInt = (arc4random() % ([array count] - x)) + x;
        [array exchangeObjectAtIndex:x withObjectAtIndex:randInt];
    }
    return array;
}
+(NSString*)currentDate{
    NSDateComponents* dc = [self getDateComponents];
    NSString* date = [NSString stringWithFormat:@"%02d/%02d/%02d", dc.day, dc.month, dc.year];
    return date;
}
+(NSString*)currentTime{
    NSDateComponents* dc = [self getDateComponents];
    NSString* date = [NSString stringWithFormat:@"%02d:%02d:%02d", dc.hour, dc.minute, dc.second];
    return date;
}
+(NSDateComponents*)getDateComponents{
    NSDate *now = [NSDate date];
	NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	NSDateComponents *dateComponents = [gregorian components:(NSDayCalendarUnit  | NSMonthCalendarUnit | NSYearCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit) fromDate:now];
    
    return dateComponents;
}
+(void)alert:(NSString*)message{
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"iQuizzer" message:message delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    [alert show];
}
@end
