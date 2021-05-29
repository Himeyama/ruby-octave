#include <iostream>
#include <octave/Matrix.h>

extern "C"{
    void Init_test(void){
        Matrix A(10, 10);
        for(int i = 0; i < 10; i++)
            for(int j = 0; j < 10; j++)
                if(i == j)
                    A(i, j) = 1;
                else
                    A(i, j) = 0;
        std::cout << A << std::endl;
    }
}

// #include <octave/Matrix.h>

// void Init_hoge(void){
//     puts("Hello, world!");
// }

// int main(void){
//     Matrix A(2, 3);
//     std::cout << A << std::endl;
//     return 0;
// }