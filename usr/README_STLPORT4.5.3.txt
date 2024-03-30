STLPort4.5.3 for Playstation2 	                                     04-Dec-2002
--------------------------------------------------------------------------------

1. Contents
2. Description
3. What's new
4. Support


1. Contents
--------------------------------------------------------------------------------

This implementation is based on the highly acclaimed STLport www.stlport.com.

It is installed in .usr\STLport-4.5.3


2. Description
--------------------------------------------------------------------------------

To use for the EE:
------------------
- default ProDG 3.0 installation:

. open your sn.ini
. hash out the existing cplus_include_path (cplus_include_path=$(EE_BASE)\include;...)
. unhash the cplus_include_path which begins cplus_include_path=$(STL_PATH);...

- older sn.ini:

. open your sn.ini
. change cplus_include_path to:
cplus_include_path=c:\usr\STLport-4.5.3\stlport;c:\usr\local\sce\ee\include;c:\usr\local\sce\ee\gcc\ee\include;c:\usr\local\sce\ee\gcc\lib\gcc-lib\ee\$(COMP_VERS)\include;c:\usr\local\sce\ee\gcc\ee;C:\usr\local\sce\ee\gcc\lib\gcc-lib\ee\$(COMP_VERS)

where $(COMP_VERS) is the compiler version you are using, eg 2.95.3


To use for the IOP:
------------------
- default ProDG 3.0 installation:

. open your sn.ini
. hash out the existing iop_cplus_include_path (iop_cplus_include_path=$(IOP_BASE)\gcc\lib\gcc-lib\mipsel-scei-elfl\$(IOP_COMP_VERS)\include;...)
. unhash the iop_cplus_include_path which begins iop_cplus_include_path=$(STL_PATH);$(IOP_BASE)\gcc\lib\gcc-lib\mipsel-scei-elfl\$(IOP_COMP_VERS)\include;...

- older sn.ini:

. open your sn.ini
. change iop_cplus_include_path to:
iop_cplus_include_path=c:\usr\STLport-4.5.3\stlport;c:\usr\local\sce\iop\gcc\lib\gcc-lib\mipsel-scei-elfl\2.95.2\include;c:\usr\local\sce\iop\gcc\mipsel-scei-elfl\include;c:\usr\local\sce\iop\gcc\lib\gcc-lib\mipsel-scei-elfl\2.95.2;c:\usr\local\sce\iop\gcc\mipsel-scei-elfl


3. What's new
--------------------------------------------------------------------------------

- I/O Stream support. To enable I/O stream support pass -D_SN_STL_IOSTREAMS on your command line and link with libstl.a (-lstl on the link line). I/O streams will enable cout/cerr and STL file stream support.

To enable I/O stream support permanently, open the file c:\usr\STLport-4.5.3\stlport\stl_user_config.h and comment out the line:

# define _STLP_NO_IOSTREAMS 1

Note that I/O Stream support is off by default as there is a size/performance penalty (typically around 600Kb, so should only be used for debug purposes). 


4. Support
-------------------------------------------------------------------------------

If you experience any difficulties using this product please contact the SN 
support team at support@snsys.com.
