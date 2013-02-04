//
//  AttributeViewController.m
//  Lecture4Attribute
//
//  Created by WeiHsiang-Mac on 2013-02-02.
//  Copyright (c) 2013 WeiHsiang-Mac. All rights reserved.
//

#import "AttributeViewController.h"

@interface AttributeViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIStepper *selectedWordStepper;
@property (weak, nonatomic) IBOutlet UILabel *selectedWordLabel;

@end

@implementation AttributeViewController
- (void)addLabelAttributes:(NSDictionary *)attributes range:(NSRange)range{
    if (range.location != NSNotFound) {
        NSMutableAttributedString *mat = [self.label.attributedText mutableCopy];
        [mat addAttributes:attributes range:range];
        self.label.attributedText = mat;
    }
}

- (void)addSelectedWordAttributes:(NSDictionary *)attributes
{
    NSRange range = [[self.label.attributedText string] rangeOfString:[self selectedWord]];
    [self addLabelAttributes:attributes range:range];
}
- (IBAction)underline {
    [self addSelectedWordAttributes:@{ NSUnderlineStyleAttributeName : @(NSUnderlineStyleSingle)}];
}

- (IBAction)ununderline {
        [self addSelectedWordAttributes:@{ NSUnderlineStyleAttributeName : @(NSUnderlineStyleNone)}];
}

- (IBAction)changeColor:(UIButton *)sender {

    [self addSelectedWordAttributes:@{NSForegroundColorAttributeName: sender.backgroundColor}];
}

- (IBAction)changeFont:(UIButton *)sender {
    
    CGFloat fontSize = [UIFont systemFontSize];
    
    NSDictionary *attributes = [self.label.attributedText attributesAtIndex:0 effectiveRange:NULL];
    UIFont *existingFont = attributes[NSFontAttributeName];
    if (existingFont) fontSize = existingFont.pointSize;
    
    UIFont *font = [sender.titleLabel.font fontWithSize:fontSize];
    [self addSelectedWordAttributes:@{NSFontAttributeName : font}];
}

- (NSArray *) wordList{
    NSArray *wordList = [[self.label.attributedText string] componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if ([wordList count]) {
        return wordList;
    } else {
        return @[@""];
    }
}

- (IBAction)outline {
//    [self addSelectedWordAttributes:@{NSStrokeColorAttributeName: [UIColor redColor]}];
    [self addSelectedWordAttributes:@{NSStrokeWidthAttributeName: [NSNumber numberWithFloat:3]}];
}

- (IBAction)noOutline:(id)sender {
    [self addSelectedWordAttributes:@{NSStrokeWidthAttributeName: [NSNumber numberWithFloat:0]}];
}


- (NSString *) selectedWord{
    return [self wordList][(int)self.selectedWordStepper.value];
}

- (IBAction)updateSelectedWord {
    self.selectedWordStepper.maximumValue = [[self wordList] count]-1;
    self.selectedWordLabel.text = [self selectedWord];
}

- (void)viewDidLoad{

    [super viewDidLoad];
    [self updateSelectedWord];
}

@end
