/*==============================================================================
FMOD Example Framework
Copyright (c), Firelight Technologies Pty, Ltd 2012-2019.
==============================================================================*/
#ifndef FMOD_EXAMPLES_COMMON_H
#define FMOD_EXAMPLES_COMMON_H

#include <FModAPI/common_platform.h>
#include <FModAPI/fmod.h>

#include <stddef.h>
#include <string.h>
#include <stdlib.h>
#include <math.h>
#include <stdarg.h>
#include <stdio.h>
#include <assert.h>

#define NUM_COLUMNS 50
#define NUM_ROWS 25

#ifndef Common_Sin
    #define Common_Sin sin
#endif

#ifndef Common_snprintf
    #define Common_snprintf snprintf
#endif

#ifndef Common_vsnprintf
    #define Common_vsnprintf vsnprintf
#endif

/* Cross platform functions (common) */
void Common_Fatal(const char *format, ...);

void ERRCHECK_fn(FMOD_RESULT result, const char *file, int line);
#define ERRCHECK(_result) ERRCHECK_fn(_result, __FILE__, __LINE__)
#define Common_Max(_a, _b) ((_a) > (_b) ? (_a) : (_b))
#define Common_Min(_a, _b) ((_a) < (_b) ? (_a) : (_b))
#define Common_Clamp(_min, _val, _max) ((_val) < (_min) ? (_min) : ((_val) > (_max) ? (_max) : (_val)))

/* Functions with platform specific implementation (common_platform) */
void Common_Init(void **extraDriverData);
void Common_Close();
void Common_Sleep(unsigned int ms);
void Common_Exit(int returnCode);
void Common_LoadFileMemory(const char *name, void **buff, int *length);
void Common_UnloadFileMemory(void *buff);
void Common_Mutex_Create(Common_Mutex *mutex);
void Common_Mutex_Destroy(Common_Mutex *mutex);
void Common_Mutex_Enter(Common_Mutex *mutex);
void Common_Mutex_Leave(Common_Mutex *mutex);

#endif
