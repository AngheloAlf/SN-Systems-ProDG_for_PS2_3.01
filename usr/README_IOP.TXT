IOP C/C++ Compiler for PlayStation®2	                     	04-Dec-2002
---------------------------------------------------------------------------

1. Contents
2. Description
3. Support
4. Source examples

-------------------------------------------------------------------------------

1. Contents
-------------------------------------------------------------------------------

1. IOP tools
2. Compilers:
	
	iop\gcc\lib\gcc-lib\mipsel-scei-elfl\

	
	|
	|
	+--- 2.8.1  +-- cc1 (2.8.1 C compiler)
	|	    |
	|	    +-- libsniop.a (Floating Point & C++ intrinsics)
	|	    +-- libm.a	   (maths library)
	|	    +-- INCLUDE FILES		
	|
	|
	+--- 2.95.2 +-- cc1 (2.95.2 C compiler)
		    |
		    +-- cc1plus (2.95.2 C++ compiler)
		    |
		    +-- libsniop.a
		    +-- libm.a
		    +-- INCLUDE FILES		

The IOP compiler directory structure has been formalised in the ProDG 3 release.
In the 2.8.1 directory is the port of the SCE IOP C compiler, based on the 2.8.1 GCC source.
In the 2.95.2 directory are the SN C and C++ ports of the more modern 2.95.2 compiler for the IOP.
The sn.ini file controls which IOP compilers will be used by ps2cc. Note that if the 2.8.1 directory is selected as the compiler path, no C++ compiler will be available.


2. Description
-------------------------------------------------------------------------------

IOP compiler setup details.
---------------------------

C Code
------

When compiling C code, the 2.8.1 compiler or the 2.95.2 compiler may be used. The 2.95.2 compiler should generate better code than the older 2.8.1 compiler.
For the ProDG 3 release, the default compiler is 2.95.2. If you wish to use the older 2.8.1 C compiler and are using the new sn.ini, just change the IOP_COMPILER_[X] settings from 2/95/2 to 2/8/1 ie:

IOP_COMPILER_1=2
IOP_COMPILER_2=8
IOP_COMPILER_3=1

If you have kept an existing sn.ini and wish to use the 2.95.2 C compiler, change "iop_compiler_path", eg:

iop_compiler_path=c:\usr\local\sce\iop\gcc\lib\gcc-lib\mipsel-scei-elfl\2.95.2

C++ Code
--------

For compiling C++ code you need to specify the 2.95.2 compiler. This is the default compiler for the ProDG release sn.ini.

If you have kept an existing sn.ini, change "iop_compiler_path", eg:

iop_compiler_path=c:\usr\local\sce\iop\gcc\lib\gcc-lib\mipsel-scei-elfl\2.95.2

There are two important things you should be aware of when using C++ on the IOP: 
i. wrapping SCE includes with extern "C" 
ii. calling and destroying global objects.

i. WRAPPING INCLUDES WITH extern "C":

Many IOP system headers have been wrapped with extern "C" linkage as of the 2.6.0 library release but there are still some outstanding files. If you have unresolved symbols at link time which contain C++ name decoration or "name mangling" the most likely cause is linking with C libraries which have function prototypes not wrapped in extern "C".

The simplest way of fixing this is to wrap your includes in extern "C":

  extern "C" {
  #include <kernel.h>
  #include <sysmem.h>
  #include <sif.h>
  }

Or better still wrap the header files themselves in this block:

  #ifdef __cplusplus
  extern "C" {
  #endif

  ... header file content ...

  #ifdef __cplusplus
  }
  #endif

ii. CALLING GLOBAL CONSTRUCTORS:

The C++ port has been written so that you have to manually call constructors and destructors.  The functions you use are:

SN_CALL_CTORS;
SN_CALL_DTORS;

Source 1 below shows an example of use.

iii. STL support.

The procedure for enabling STL support is outlined in the README_STLPORT4.5.3.txt file. It only requires one action to be performed on the sn.ini. 
Source 2 shows an STL example which will work correctly when sn.ini is configured for STL use.


3. Support
-------------------------------------------------------------------------------

IOPFIXUP error: unresolved symbols
----------------------------------
Here is an error/diagnosis chart for the most common unresolved errors.

Problem:

  iopfixup Error  : Unresolved Symbol: malloc

Solution:

  You need to define your own malloc and free, and these need to be declared extern "C" ie:

  extern "C" void* malloc (size_t blocksize) 
  {
	return AllocSysMemory(0, (u_long)blocksize, NULL);
  }

  extern "C" void free (void * mem_ptr)
  {
	FreeSysMemory(mem_ptr);
  }

Problem:

  iopfixup Error  : Unresolved Symbol: abort

Solution:

  You need to define an abort function, in the case of IOP this could be an infinite loop:

  extern "C" void abort(void)
  {
  	for (;;);
  }

  NB this function should never get called.

Problem:

  iopfixup Error  : Unresolved Symbol: _exit

Solution:

  You need to define an exit function, in the case of IOP this could be an infinite loop which does not return:

  extern "C" void _exit(int)
  {
  	for (;;);
  }

  NB this function should never get called.

Problem:

  Unresolved intrinsic compiler floating point math emulation functions

  iopfixup Error  : Unresolved Symbol: __extendsfdf2
  iopfixup Error  : Unresolved Symbol: __truncdfsf2

Solution:

  You need to link against extended intrinsic math library -lsniop eg:
  ps2cc -iop vectoriop.cpp -g -r vectoriop.irx -lsniop

Problem:

  Unresolved SCE functions with C++ function decoration:

  iopfixup Error  : Unresolved Symbol: AllocSysMemory__FiUlPv
  iopfixup Error  : Unresolved Symbol: CreateThread__FP11ThreadParam

Solution:

  IOP headers not wrapped in extern "C". eg:

  extern "C" {
  #include <kernel.h>
  #include <sysmem.h>
  #include <sif.h>
  }

  Or better still wrap the header files themselves in this block:

  #ifdef __cplusplus
  extern "C" {
  #endif

  ... header file content ...

  #ifdef __cplusplus
  }
  #endif


Doubles and Float software emulation
------------------------------------
You now have access to float and double types and all computations involving them.  Note that the IOP printf does not support floating point output.  To get this you link with libsniop.a, by adding '-lsniop' to your makefile or VSI link stage.  Note that this is software emulation, and is not really desirable for use in release code that needs to run quickly and be compact.

If you experience any difficulties using this product please contact the SN 
support team at support@snsys.com.



4. Source examples
-------------------------------------------------------------------------------


SOURCE 1 - Example of use of Global constructors/ Global destructors on IOP:
----------------------------------------------------------------------------

#if defined(_LANGUAGE_C_PLUS_PLUS)||defined(__cplusplus)||defined(c_plusplus)
extern "C" {
#endif

#include <stdio.h>
#include <kernel.h>
#include <sysmem.h>
#include <sif.h>

#if defined(_LANGUAGE_C_PLUS_PLUS)||defined(__cplusplus)||defined(c_plusplus)
}
#endif

#include <libsniop.h>  //Contains definitions for CTOR and DTOR calls.

#define BASE_priority  32

class foo
{
public:
	int hoo;
	int bar;
	foo () {hoo = 40; printf("\nfoo Constructor");}
	~foo () {hoo = 0; bar = 0; printf("\nfoo Destructor.");}
};

foo globfunc;  //Global object of class foo

ModuleInfo Module = { "cxx_constructor_example", 0x0100 };

int thread1(void)
{
	printf("\nThread1 startup.");
	printf("\nCall Global Ctors.");

	SN_CALL_CTORS;  //Call all global CTORs

	globfunc.hoo = 32;
	globfunc.bar = 256;
	printf("\nCall global Dtors.");

	SN_CALL_DTORS;  //Call all global DTORs

	printf("\nStuff happening after global destructor call.");
	return 0;
}

int start (void)
{
    struct ThreadParam param;
    int thread;

    printf("\nStartup thread init.");

    if (!sceSifCheckInit())
    {
	sceSifInit();
    }

    param.attr         = TH_C;
    param.entry        = thread1;
    param.initPriority = BASE_priority - 2;
    param.stackSize    = 64*1024;
    param.option       = 0;
    thread = CreateThread (&param);
    if (thread > 0)
    {
	StartThread (thread, 0);
	printf ("\nThread 1 started.");
	printf ("\nStartup thread terminated.");
	return 0;
    }
    else
    {
	printf ("\nStartup thread terminated.  Errors encountered");
	return 1;
    }
}


SOURCE 2 - example use of STL on the IOP:
-----------------------------------------

//////////////////////////////////////////////////////////////
//
//	Vectoriop.cpp
//
//	This program is a simple confidence test which tests the following
//	1. STL Include file setup.
//		a. lists
//		b. strings
//		c. vectors
//
//	Autolinking Build line:
//	ps2cc -iop vectoriop.cpp -g -r vectoriop.irx -lsniop
//


#include <stddef.h>
#include <stdlib.h>

#include <stdio.h>

#include <new>
#include <string>
#include <vector>
#include <memory>
#include <list>

extern "C" {
#include <kernel.h>
#include <sysmem.h>
#include <sif.h>
}
	
extern "C" void free (void * mem_ptr)
{
	FreeSysMemory(mem_ptr);
}

#include <libsniop.h>  //Contains definitions for CTOR and DTOR calls.

extern "C" void* malloc (size_t blocksize)
{
	return AllocSysMemory(0, (u_long)blocksize, NULL);
}

extern "C" void abort(void)
{
	for (;;);
}

extern "C" void _exit(int i)
{
	for(;;);
}

using namespace std;

int start (void)
{
	int t;
	long l;
	float f;
	double dd;
	list<int>::iterator i;
	int rgTest1[] = {5,6,7};
	int rgTest2[] = {10,11,12};
	int x;

	std::string str;
	std::vector<int> vec;
	list<int> klist;
	vector<float> vecfloat;

	str = "Are strings working ??";

	f = 3.141592653959;
	dd = 2.7182818284590452353602874713527;

	// Insert one at a time
	klist.insert (klist.begin(), 2);
	klist.insert (klist.begin(), 1);
	klist.insert (klist.end(), 3);

	printf ("\nThe string: %s", str.c_str());

	vecfloat.push_back (f);
	vecfloat.push_back (1.41218);
	vecfloat.push_back (dd);

	printf ("\n vecfloat1 = %f, vecfloat2 = %f\n", vecfloat[0], vecfloat[1]); //NB floats do not print correctly.

	// 1 2 3
	for (i = klist.begin(); i != klist.end(); ++i)
        printf("%d ",*i);
	printf("\n");

	// Insert 3 fours
	klist.insert (klist.end(), 3, 4);

	// 1 2 3 4 4 4
	for (i = klist.begin(); i != klist.end(); ++i)
	{
        	printf( ": %i", *i);
	}
	printf( "\n\n");


	// Insert an array in there
	klist.insert (klist.end(), rgTest1, rgTest1 + 3);

	// 1 2 3 4 4 4 5 6 7
	for (i = klist.begin(); i != klist.end(); ++i)
	printf("%d ",*i);
	printf("\n");

	//Populate a vector
	for (t=0;t<20;t++)
	{
		//x = new int;
		x = t*2;
		vec.push_back (x);
	}

	printf ("\nMy string is %s\n", str.c_str());

	for (t=0;t<vec.size();t++)
	{
		printf("\nMember of vec %i = %i", t, vec[t]);
	}

	printf("\nProgram end");

	return 0;
}