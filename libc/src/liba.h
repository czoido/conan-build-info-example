#pragma once

#ifdef WIN32
  #define liba_EXPORT __declspec(dllexport)
#else
  #define liba_EXPORT
#endif

liba_EXPORT void liba();
