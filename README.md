# psi-config
A pseudo filesystem which allows to savely configure services; remote or local; strongly encrypted.

![intercept calls](https://github.com/CodiePP/psi-config/raw/master/doc/psi-injector.png)

It intercepts calls into libc (on Linux and FreeBSD) and checks authorization and can inject return types (e.g. file content). The check can be made locally or sent to a trusted, external server. 


![overview](https://github.com/CodiePP/psi-config/raw/master/doc/psi-overview.png)


# References
[https://wiki.haskell.org/Calling_Haskell_from_C](Calling_Haskell_from_C): this helped me to understand the ``foreign export ccall``.
[https://downloads.haskell.org/~ghc/latest/docs/html/users_guide/shared_libs.html](Using shared libraries): it is not so easy to create a shared library with GHC.
[https://downloads.haskell.org/~ghc/latest/docs/html/users_guide/ffi-chap.html](the Foreing function interface - FFI): have C and Haskell interop.


# Copyright
Copyright (c) 2017 by Alexander Diemand

