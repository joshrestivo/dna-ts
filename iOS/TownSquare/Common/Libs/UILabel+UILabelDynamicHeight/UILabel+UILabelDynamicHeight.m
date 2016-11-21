//
//  UILabel+UILabelDynamicHeight.m
//  PipeFish
//
//  Created by Cuc Nguyen on 3/31/15.
//  Copyright (c) 2015 CloudZilla. All rights reserved.
//

#import "UILabel+UILabelDynamicHeight.h"
@import CoreText;
@implementation UILabel(UILabelDynamicHeight)
#pragma mark - Calculate the size,bounds,frame of the Multi line Label
/*====================================================================*/

/* Calculate the size,bounds,frame of the Multi line Label */
-(CGSize)sizeOfMultiLineLabelWidth:(CGFloat)labelWidth{
    NSAssert(self, @"UILabel was nil");
    
    //Label text
    NSString *aLabelTextString = [self text];
    
    //Label font
    UIFont *aLabelFont = [self font];

    //Return the calculated size of the Label
    return [aLabelTextString boundingRectWithSize:CGSizeMake(labelWidth, MAXFLOAT)
                                          options:(NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading)
                                       attributes:@{
                                                    NSFontAttributeName : aLabelFont
                                                    }
                                          context:nil].size;

    
    return [self bounds].size;
}
/*====================================================================*/
/**
 *  Returns the size of the Label
 *
 *  @param aLabel To be used to calculte the height
 *
 *  @return size of the Label
 */
-(CGSize)sizeOfMultiLineLabel{
    
    NSAssert(self, @"UILabel was nil");
    
    //Width of the Label
    CGFloat aLabelSizeWidth = self.frame.size.width;
    return [self sizeOfMultiLineLabelWidth:aLabelSizeWidth];
    
}

- (CGSize)frameSizeForAttributedString
{
    CGFloat width = self.frame.size.width;
    return [self frameSizeForAttributedStringWidth:width];
}
- (CGSize)frameSizeForAttributedStringWidth:(CGFloat)width{


    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFMutableAttributedStringRef)self.attributedText);
    CGSize suggestedSize = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, CFRangeMake(0, 0), NULL, CGSizeMake(width, CGFLOAT_MAX), NULL);
    CFRelease(framesetter);
    
    CTTypesetterRef typesetter = CTTypesetterCreateWithAttributedString((CFAttributedStringRef)self.attributedText);
    CFIndex offset = 0, length;
    CGFloat y = 0;
    do {
        length = CTTypesetterSuggestLineBreak(typesetter, offset, width);
        CTLineRef line = CTTypesetterCreateLine(typesetter, CFRangeMake(offset, length));
        
        CGFloat ascent, descent, leading;
        CTLineGetTypographicBounds(line, &ascent, &descent, &leading);
        
        CFRelease(line);
        
        offset += length;
        y += ascent + descent + leading;
    } while (offset < [self.attributedText length]);
    
    CFRelease(typesetter);
    
    return CGSizeMake(suggestedSize.width, ceil(y + 10));
}

@end
