fnv_hash_dlang
==============

A D language implementation of the Fowler/Noll/Vo (FNV) hash.

FNV homepage: http://www.isthe.com/chongo/tech/comp/fnv/

Usage
-----

```D
assert( fnv1Hash!uint("FNV Hash Test") == 0xAE2253F1 );
assert( fnv1aHash!uint("FNV Hash Test") == 0xF38B3DB9 );
assert( fnvHash32("FNV Hash Test ") != 0xF38B3DB9 );
static assert( fnvHash32("FNV Hash Test") == 0xF38B3DB9 );
```


FNV hash history
---------------

The basis of the FNV hash algorithm was taken from an idea sent as reviewer
comments to the IEEE POSIX P1003.2 committee by Glenn Fowler and Phong Vo back
in 1991. In a subsequent ballot round: Landon Curt Noll improved on their
algorithm. Some people tried this hash and found that it worked rather well. In
an EMail message to Landon, they named it the ``Fowler/Noll/Vo'' or FNV hash.

FNV hashes are designed to be fast while maintaining a low collision rate. The
FNV speed allows one to quickly hash lots of data while maintaining a
reasonable collision rate. The high dispersion of the FNV hashes makes them
well suited for hashing nearly identical strings such as URLs, hostnames,
filenames, text, IP addresses, etc.

The IETF has an informational draft on The FNV Non-Cryptographic Hash Algorithm
http://tools.ietf.org/html/draft-eastlake-fnv-03

FNV hash algorithms and source code have been released into the public domain.
The authors of the FNV algorithmm look deliberate steps to disclose the
algorhtm in a public forum soon after it was invented. More than a year passed
after this public disclosure and the authors deliberatly took no steps to
patent the FNV algorithm. Therefore it is safe to say that the FNV authors have
no patent claims on the FNV algorithm as published.


