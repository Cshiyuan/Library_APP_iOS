//
//  CSYBookInfoCell.m
//  Library_APP_iOS
//
//  Created by chenshyiuan on 2017/3/9.
//  Copyright © 2017年 chenshyiuan. All rights reserved.
//

#import "CSYBookInfoCell.h"

@implementation CSYBookInfoCell

//-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
//{
//    
//    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
//    if(self)
//    {
//        
//    }
//    
//    return self;
//}

+(instancetype)initWithXib
{
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *className = NSStringFromClass([self class]);
    NSArray *objs = [bundle loadNibNamed:className owner:nil options:nil];
    return [objs lastObject];
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
