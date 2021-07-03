/*==============================================================================
FMOD Example Framework
Copyright (c), Firelight Technologies Pty, Ltd 2012-2019.
==============================================================================*/
#include "common.h"
#include "fmod_errors.h"

void (*Common_Private_Error)(FMOD_RESULT, const char *, int);

void ERRCHECK_fn(FMOD_RESULT result, const char *file, int line)
{
    if (result != FMOD_OK)
    {
        if (Common_Private_Error)
        {
            Common_Private_Error(result, file, line);
        }
        Common_Fatal("%s(%d): FMOD error %d - %s", file, line, result, FMOD_ErrorString(result));
    }
}

void Common_Fatal(const char *format, ...)
{
    char error[1024];

    va_list args;
    va_start(args, format);
    Common_vsnprintf(error, 1024, format, args);
    va_end(args);
    error[1023] = '\0';

    Common_Exit(0);
}

