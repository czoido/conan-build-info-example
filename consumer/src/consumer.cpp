#include <iostream>
#include "consumer.h"

void consumer(){
    #ifdef NDEBUG
    std::cout << "consumer/4.0: Hello World Release!" <<std::endl;
    #else
    std::cout << "consumer/4.0: Hello World Debug!" <<std::endl;
    #endif
}
