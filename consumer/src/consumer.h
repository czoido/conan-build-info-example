#pragma once

#ifdef WIN32
  #define consumer_EXPORT __declspec(dllexport)
#else
  #define consumer_EXPORT
#endif

consumer_EXPORT void consumer();
