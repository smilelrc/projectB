//
//  Student.h
//  
//
//  Created by lanou on 15/10/26.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Student : NSManagedObject

@property (nonatomic, retain) NSString * gender;
@property (nonatomic, retain) NSString * hobby;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * age;

@end
