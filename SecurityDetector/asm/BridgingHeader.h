//
//  BridgingHeader.h
//  SecurityDetector
//
//  Created by Steven Koposov on 2/25/19.
//  Copyright © 2019 Hyperion. All rights reserved.
//

#import <sys/sysctl.h>

int readSys(int *, u_int, void *, size_t *);
