#include <iostream>
#include "liba.h"

void liba(){
    #ifdef NDEBUG
    std::cout << "liba/2.0: Hello World Release!" <<std::endl;
    #else
    std::cout << "liba/2.0: Hello World Debug!" <<std::endl;
    #endif
}
