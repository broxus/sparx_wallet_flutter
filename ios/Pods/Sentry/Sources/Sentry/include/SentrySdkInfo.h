#if __has_include(<Sentry/SentryDefines.h>)
#    import <Sentry/SentryDefines.h>
#else
#    import "SentryDefines.h"
#endif

#if __has_include(<Sentry/SentryInternalSerializable.h>)
#    import <Sentry/SentryInternalSerializable.h>
#else
#    import "SentryInternalSerializable.h"
#endif

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * Describes the Sentry SDK and its configuration used to capture and transmit an event.
 * @note Both name and version are required.
 * @see https://develop.sentry.dev/sdk/event-payloads/sdk/
 */
@interface SentrySdkInfo : NSObject <SentryInternalSerializable>
SENTRY_NO_INIT

/**
 * The name of the SDK. Examples: sentry.cocoa, sentry.cocoa.vapor, ...
 */
@property (nonatomic, readonly, copy) NSString *name;

/**
 * The version of the SDK. It should have the Semantic Versioning format MAJOR.MINOR.PATCH, without
 * any prefix (no v or anything else in front of the major version number). Examples:
 * 0.1.0, 1.0.0, 2.0.0-beta0
 */
@property (nonatomic, readonly, copy) NSString *version;

- (instancetype)initWithName:(NSString *)name
                  andVersion:(NSString *)version NS_DESIGNATED_INITIALIZER;

- (instancetype)initWithDict:(NSDictionary *)dict;

- (instancetype)initWithDict:(NSDictionary *)dict orDefaults:(SentrySdkInfo *)info;

@end

NS_ASSUME_NONNULL_END
