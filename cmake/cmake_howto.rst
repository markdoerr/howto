

cmake how-to
=============

Documentation


https://cmake.org/cmake/help/v3.8/


main config file: CMakeLists.txt


evoking cmake
_____________

cmake .

this generates a Makefile, which can be executed by calling 'make'

cmake commands
_______________

s. https://cmake.org/cmake/help/v3.8/manual/cmake-commands.7.html


configure_file command
________________________

configure_file replaces variables defined with set

    set (Tutorial_VERSION_MAJOR 1)
    
    
    will replace all occurrences of @Tutorial_VERSION_MAJOR@ by 1
    
    #define Tutorial_VERSION_MAJOR @Tutorial_VERSION_MAJOR@
    -> #define Tutorial_VERSION_MAJOR 1
