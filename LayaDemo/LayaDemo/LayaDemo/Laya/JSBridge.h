#import <Foundation/NSObject.h>

@interface JSBridge: NSObject
//是否切换账号
@property(nonatomic,assign)BOOL IsSwitch;


+ (instancetype)shareInitialization;


//刷新游戏
+(void)refreshGame;
@end

