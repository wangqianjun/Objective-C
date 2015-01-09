//
//  ViewController.m
//  NSRegularExpression
//
//  Created by 王钱钧 on 15/1/8.
//  Copyright (c) 2015年 Arthur. All rights reserved.
//


/*
 从iOS 4开始，原生SDK提供了NSRegularExpression用于处理一些跟正则表达式相关的操作，比如字符查找、数字匹配等等。但是NSRegularExpression的用法比较繁冗。RegEx Categories提供了一系列十分简便的方法来进行正则表达式操作。
 
 比如：
 
 用NSRegularExpression来判断字符串中是否存在数字：
 
 NSString* string = @"I have 2 dogs.";
 
 NSRegularExpression *regex = [NSRegularExpression regular ExpressionWithPattern:@"\\d+" options:NSRegularExpressionCaseInsensitive error:&error;];
 
 NSTextCheckingResult *match = [regex firstMatchInString:string options:0 range:NSMakeRange(0, [string length])];
 
 BOOL isMatch = match != nil;
 
 
 
 利用RegEx Categories只需要一句代码：
 
 BOOL isMatch = [@"I have 2 dogs." isMatch:RX(@"\\d+")];
 */



#import "ViewController.h"
#import "RegExCategories.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self useRegularExpreesion];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 
 http://www.cocoachina.com/bbs/read.php?tid-106586.html
 
 1、正则的一些语法：
 
 1) \ :
 
 \r, \n  代表回车和换行符
 \t      制表符
 \\      代表 "\" 本身
 \^      匹配 ^ 符号本身
 \$      匹配 $ 符号本身
 \.      匹配小数点（.）本身
 
 
 2) 能够与 '多种字符' 匹配的表达式
 
 \d 任意一个数字，0~9 中的任意一个
 \w 任意一个字母或数字或下划线，也就是 A~Z,a~z,0~9,_ 中任意一个
 \s 包括空格、制表符、换页符等空白字符的其中任意一个
 .  小数点可以匹配除了换行符（\n）以外的任意一个字符
 
 
 3) 自定义能够匹配 '多种字符' 的表达式
 使用方括号 [ ] 包含一系列字符，能够匹配其中任意一个字符。用 [^ ] 包含一系列字符，则能够匹配其中字符之外的任意一个字符。同样的道理，虽然可以匹配其中任意一个，但是只能是一个，不是多个
 
 [ab5@]: 匹配 "a" 或 "b" 或 "5" 或 "@"
 [^abc]: 匹配 "a","b","c" 之外的任意一个字符
 [f-k] : 匹配 "f"~"k" 之间的任意一个字母 (包含f，k)
 [^A-F0-3]: 匹配 "A"~"F","0"~"3" 之外的任意一个字符
 
 
 4) 修饰匹配次数的特殊符号
 上面提到，无论是只能匹配一种字符的表达式，还是可以匹配多种字符其中任意一个的表达式，都只能匹配一次。如果使用表达式再加上修饰匹配次数的特殊符号，那么不用重复书写表达式就可以重复匹配
 
 {n} : 表达式重复n次, 比如："\w{2}" 相当于 "\w\w"；"a{5}" 相当于 "aaaaa"
 {m,n} : 表达式至少重复m次，最多重复n次, 最多重复n次，比如："ba{1,3}"可以匹配 "ba"或"baa"或"baaa"
 {m,} : 表达式至少重复m次，比如："\w\d{2,}"可以匹配 "a12","_456","M12344"...
 ?   : 匹配表达式0次或者1次，相当于 {0,1}
 +   : 表达式至少出现1次，相当于 {1,}，比如："a+b"可以匹配 "ab","aab","aaab"...
 *   : 表达式不出现或出现任意次，相当于 {0,}，比如："\^*b"可以匹配 "b","^^^b"...
 
 
 5) 其他一些代表抽象意义的特殊符号
    一些符号在表达式中代表抽象的特殊意义：
    ^ : 与字符串开始的地方匹配，不匹配任何字符
    $ : 与字符串结束的地方匹配，不匹配任何字符
    \b : 匹配一个单词边界，也就是单词和空格之间的位置，不匹配任何字符
 
    一些符号可以影响表达式内部的子表达式之间的关系：
    | : 左右两边表达式之间 "或" 关系，匹配左边或者右边
    ( ) :
        (1). 在被修饰匹配次数的时候，括号中的表达式可以作为整体被修饰
        (2). 取匹配结果的时候，括号中的表达式匹配到的内容可以被单独得到
 
 
 2、正则表达式中的一些高级规则：
 
 1）匹配次数中的贪婪与非贪婪
 
 贪婪
 (d)(\w+) : "\w+" 将匹配第一个 "d" 之后的所有字符 "xxxdxxxd"
 (d)(\w+)(d) : "\w+" 将匹配第一个 "d" 和最后一个 "d" 之间的所有字符 "xxxdxxx"。虽然 "\w+" 也能够匹配上最后一个 "d"，但是为了使整个表达式匹配成功，"\w+" 可以 "让出" 它本来能够匹配的最后一个 "d"
 
 非贪婪
 (d)(\w+?) : "\w+?" 将尽可能少的匹配第一个 "d" 之后的字符，结果是："\w+?" 只匹配了一个 "x"
 (d)(\w+?)(d) : 为了让整个表达式匹配成功，"\w+?" 不得不匹配 "xxx" 才可以让后边的 "d" 匹配，从而使整个表达式匹配成功。因此，结果是："\w+?" 匹配 "xxx"
 
 
 2）反向引用 \1, \2...
 */

- (void)useRegularExpreesion {
    NSString *staString = [NSString stringWithUTF8String:"let's gofgo gogo"];
    NSString *pattern = @"(go\\s*)+";
    NSError *error = nil;
    NSRegularExpression *rx = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:&error];
    
    NSArray *match = [rx matchesInString:staString options:NSMatchingReportCompletion range:NSMakeRange(0, [staString length])];
    
    if (match.count != 0)
    {    
        for (NSTextCheckingResult *matc in match)
        {
            NSRange range = [matc range];
            NSLog(@"%lu,%lu,%@",(unsigned long)range.location,(unsigned long)range.length,[staString substringWithRange:range]);
        }  
    }
}

// 使用RegExCategories
- (void)useRegExCategories {
    Rx *rx = RX(@"\\d");
    Rx *rx1 = [Rx rx:@"\\d"];
    Rx *rx2 = [Rx rx:@"\\d" ignoreCase:YES];
}

@end
