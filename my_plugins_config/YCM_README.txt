
clang_complete
Thanks for using Vim for Windows, hope you enjoy.

To solve your problem you have to utilize .clang_complete file. Read more about it in :h clang_complete. In brief, you can put this file into the root directory of any of your projects (i.e. for each project this file can be different, what perfectly makes sense, since different projects have different toolchain configurations). Here is the sample for MinGW-w64 toolchain:

-ID:/Toolchains/x64/MinGW-w64/4.8.1/lib/gcc/x86_64-w64-mingw32/4.8.1/include/c++
-ID:/Toolchains/x64/MinGW-w64/4.8.1/lib/gcc/x86_64-w64-mingw32/4.8.1/include/c++/x86_64-w64-mingw32
-ID:/Toolchains/x64/MinGW-w64/4.8.1/lib/gcc/x86_64-w64-mingw32/4.8.1/include/c++/backward
-ID:/Toolchains/x64/MinGW-w64/4.8.1/lib/gcc/x86_64-w64-mingw32/4.8.1/include
-ID:/Toolchains/x64/MinGW-w64/4.8.1/lib/gcc/x86_64-w64-mingw32/4.8.1/include-fixed
-ID:/Toolchains/x64/MinGW-w64/4.8.1/x86_64-w64-mingw32/include

-ID:/Libraries/x64/MinGW-w64/4.8.1/Boost/1.54.0/include

-ID:/Libraries/x64/MinGW-w64/4.8.1/Qt/4.8.5/include

-ID:/Libraries/x64/MinGW-w64/4.8.1/Eigen/3.1.3/include

"-ID:/Libraries/x64/MinGW-w64/4.8.1/Example with Spaces/0.0.1/include"

-std=c++11

-DUNICODE
When you are editing some file in the project with Vim, clang_complete traverses backward all the parent directories of the edited file until it stumbles across the first .clang_complete file to read. Then it reads all these flags/switches/definitions and uses them during the invocation of libclang for completion.

YouCompleteMe
These days, I don't use clang_complete anymore. There is more powerful semantic autocompletion plugin for Vim our there. It's YouCompleteMe. I highly recommend you try it out. For semantic completion of C-family languages (C/C++/Objective-C/Objective-C++) it uses libclang as well. It relies on a robust C++ back end, and is therefore incredibly fast. It has great integration with syntastic (another must have plugin for Vim). It has an ability to jump to definitions, and so on.

Since it's written in C++ and glued to Vim via Python, you'd have to compile the C++ back end. To ease the pain you can download prebuilt and ready to use YCM plugin from my Vim YouCompleteMe for Windows. I've built it for both x86 and x64 architectures. The native component is called ycm_core.pyd. As usual the architecture of the Vim build you chose has to match the YCM build (i.e. ycm_core.pyd). YCM can work ONLY with Python 2 (not 3), so just make sure that you have Python 2 DLL (e.g. python27.dll) and Python 2 Interpreter (python.exe) in the PATH environment variable.

If you need LLVM/Clang, you can download it from me as well: LLVM for Windows. Again, just make sure that you have libclang.dll in the PATH environment variable (recommended) OR right next to ycm_core.pyd. Once again both x86 and x64 architectures are supported, and once again the architecture should match both Vim's and YCM's ones.

Concerning completion:

Should he magically find where is the STL?

Of course not! This is just an autocompletion system based on Clang front end. How is it supposed to know which toolchain you're currently using to compile your code? You could use anything: Visual C++, Borland C++, GCC, MinGW, MinGW-w64, LLVM/Clang, etc. Each of them has their own standard library and runtime supplied. Thus, in each case you'd have to specify all the paths which your current toolchain uses to find standard includes.

For example, in case of GCC, MinGW, MinGW-w64, you can run the following in POSIX shell:

g++ -E -x c++ - -v < /dev/null
Or in Windows Command Prompt:

g++ -E -x c++ - -v < nul
And look for the following excerpt:

#include <...> search starts here:
 d:\toolchains\x64\mingw-w64\4.8.1\posix\seh\bin\../lib/gcc/x86_64-w64-mingw32/4.8.1/include/c++
 d:\toolchains\x64\mingw-w64\4.8.1\posix\seh\bin\../lib/gcc/x86_64-w64-mingw32/4.8.1/include/c++/x86_64-w64-mingw32
 d:\toolchains\x64\mingw-w64\4.8.1\posix\seh\bin\../lib/gcc/x86_64-w64-mingw32/4.8.1/include/c++/backward
 d:\toolchains\x64\mingw-w64\4.8.1\posix\seh\bin\../lib/gcc/x86_64-w64-mingw32/4.8.1/include
 d:\toolchains\x64\mingw-w64\4.8.1\posix\seh\bin\../lib/gcc/x86_64-w64-mingw32/4.8.1/include-fixed
 d:\toolchains\x64\mingw-w64\4.8.1\posix\seh\bin\../lib/gcc/x86_64-w64-mingw32/4.8.1/../../../../x86_64-w64-mingw32/include
End of search list.
This tells you all the paths to standard includes which GCC, MinGW, MinGW-w64 use implicitly during compilation of your code.

For LLVM/Clang, you can do the same:

clang++ -E -x c++ - -v < /dev/null
Or:

clang++ -E -x c++ - -v < nul
When you know the paths, you can happily add them into .ycm_extra_conf.py. For instance, in my case:

'-I',
'D:/Toolchains/x64/MinGW-w64/4.8.1/POSIX/SEH/lib/gcc/x86_64-w64-mingw32/4.8.1/include/c++',
'-I',
'D:/Toolchains/x64/MinGW-w64/4.8.1/POSIX/SEH/lib/gcc/x86_64-w64-mingw32/4.8.1/include/c++/x86_64-w64-mingw32',
'-I',
'D:/Toolchains/x64/MinGW-w64/4.8.1/POSIX/SEH/lib/gcc/x86_64-w64-mingw32/4.8.1/include/c++/backward',
'-I',
'D:/Toolchains/x64/MinGW-w64/4.8.1/POSIX/SEH/lib/gcc/x86_64-w64-mingw32/4.8.1/include',
'-I',
'D:/Toolchains/x64/MinGW-w64/4.8.1/POSIX/SEH/lib/gcc/x86_64-w64-mingw32/4.8.1/include-fixed',
'-I',
'D:/Toolchains/x64/MinGW-w64/4.8.1/POSIX/SEH/x86_64-w64-mingw32/include',
shareimprove this answer
edited Aug 7 '15 at 8:19
answered Sep 18 '13 at 15:27

Alexander Shukaev
12.9k75879
It works perfectly!!! thank you so much, I think I should write something summarizing what you made me do. BTW I used clang++ from LLVM I took from you but that did not work, then I took mingw64 and it worked perfectly... What about having vim-YCM on github so that we can Vundle it ? Anyway I'll write the stuff down and may be advertize it to Val Markovic. Bounty on the way – statquant Sep 20 '13 at 7:28
If you mean that you tried to use Clang to compile your code, then of course it didn't work. Clang is not yet ready for production on Windows. Even the standard library and runtime are not fully ready for Windows. That's why for now you better stick with either MSVC, MinGW, or MinGW-w64 on Windows. From what I remember, one can Vundle from Bitbucket too. Investigate this and tell me later. If there is no chance to Vundle from Bitbucket, then I'll mirror it on Github too. Thanks again for testing. – Alexander Shukaev Sep 20 '13 at 12:44
Yes that's what I meant, I did not know clang was not ready for windows. I'll come back to you about bitbucket. Can you please remove the previous comments to clean the post? Thanks again – statquant Sep 20 '13 at 12:50
@AlexanderShukaev Thank you for the post! After hours of trying to set up the flags, I found your answer, and autocompletion finally works! And its wicked fast! – user3496846 Nov 5 '16 at 14:11
