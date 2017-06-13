//
//  QNCrashMonitor.m
//  Pods
//
//  Created by 研究院01 on 17/5/27.
//
//

#import "QNCrashMonitor.h"

NSUncaughtExceptionHandler *exceptionHandler;

@implementation QNCrashMonitor

static void _qn_exception_caught(NSException * exception)
{
    /*
    NSDictionary * infoDict = [[NSBundle mainBundle] infoDictionary];
    NSString * appInfo = [NSString stringWithFormat: @"Device: %@\nOS Version: %@\nOS System: %@", [UIDevice currentDevice].model, infoDict[@"CFBundleShortVersionString"], [[UIDevice currentDevice].systemName stringByAppendingString: [UIDevice currentDevice].systemVersion]];
    */
    if (exceptionHandler != NULL) {
        (*exceptionHandler)(exception);
    }
}

static void _qn_signal_handler(int signal)
{
    _qn_exception_caught([NSException exceptionWithName: __signal_name(signal) reason: __signal_reason(signal) userInfo: nil]);
    [QNCrashMonitor _killApp];
}

CF_INLINE NSString * __signal_name(int signal)
{
    switch (signal) {
            /// 非法指令
        case SIGILL:
            return @"SIGILL";
            /// 计算错误
        case SIGFPE:
            return @"SIGFPE";
            /// 总线错误
        case SIGBUS:
            return @"SIGBUS";
            /// 无进程接手数据
        case SIGPIPE:
            return @"SIGPIPE";
            /// 无效地址
        case SIGSEGV:
            return @"SIGSEGV";
            /// abort信号
        case SIGABRT:
            return @"SIGABRT";
        default:
            return @"Unknown";
    }
}

CF_INLINE NSString * __signal_reason(int signal)
{
    switch (signal) {
            /// 非法指令
        case SIGILL:
            return @"Invalid Command";
            /// 计算错误
        case SIGFPE:
            return @"Math Type Error";
            /// 总线错误
        case SIGBUS:
            return @"Bus Error";
            /// 无进程接手数据
        case SIGPIPE:
            return @"No Data Receiver";
            /// 无效地址
        case SIGSEGV:
            return @"Invalid Address";
            /// abort信号
        case SIGABRT:
            return @"Abort Signal";
        default:
            return @"Unknown";
    }
}


#pragma mark - Public


+ (void)startMonitoring
{
    exceptionHandler = NSGetUncaughtExceptionHandler();
    NSSetUncaughtExceptionHandler(_qn_exception_caught);
    signal(SIGILL, _qn_signal_handler);
    signal(SIGFPE, _qn_signal_handler);
    signal(SIGBUS, _qn_signal_handler);
    signal(SIGPIPE, _qn_signal_handler);
    signal(SIGSEGV, _qn_signal_handler);
    signal(SIGABRT, _qn_signal_handler);
}


#pragma mark - Private


+ (void)_killApp
{
    NSSetUncaughtExceptionHandler(NULL);
    signal(SIGILL, SIG_DFL);
    signal(SIGFPE, SIG_DFL);
    signal(SIGBUS, SIG_DFL);
    signal(SIGPIPE, SIG_DFL);
    signal(SIGSEGV, SIG_DFL);
    signal(SIGABRT, SIG_DFL);
    kill(getpid(), SIGKILL);
}

@end
