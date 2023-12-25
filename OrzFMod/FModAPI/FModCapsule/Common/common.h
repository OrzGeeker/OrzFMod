#ifndef _FMOD_CAPSULE_COMMON_H
#define _FMOD_CAPSULE_COMMON_H

#include "fmod.h"

void Common_RegisterSuspendCallback(void (*callback)(bool));

/* Functions with platform specific implementation (common_platform) */
void Common_Init(void **extraDriverData);

#endif
