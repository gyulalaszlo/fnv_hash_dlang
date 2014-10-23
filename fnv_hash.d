/**

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


  Usage
  -----

  assert( fnv1Hash!uint("FNV Hash Test") == 0xAE2253F1 );
  assert( fnv1aHash!uint("FNV Hash Test") == 0xF38B3DB9 );
  assert( fnvHash32("FNV Hash Test ") != 0xF38B3DB9 );
  static assert( fnvHash32("FNV Hash Test") == 0xF38B3DB9 );

*/

// 32  bit FNV_prime = 224  + 28 + 0x93 = 16777619
// 64  bit FNV_prime = 240  + 28 + 0xb3 = 1099511628211
// 128 bit FNV_prime = 288  + 28 + 0x3b = 309485009821345068724781371
// 256 bit FNV_prime = 2168 + 28 + 0x63 = 374144419156711147060143317175368453031918731002211

T fnvPrime(T)() { static assert(false); }
T fnvPrime(T:uint)() { return 16777619u; }
T fnvPrime(T:ulong)() { return 1099511628211U; }

// The offset_basis for FNV-1 is dependent on n, the size of the hash:
//    32 bit offset_basis = 2166136261
//    64 bit offset_basis = 14695981039346656037
//    128 bit offset_basis = 144066263297769815596495629667062367629
//    256 bit offset_basis =
//    100029257958052580907070968620625704837092796014241193945225284501741471925557

T fnvOffsetBasis(T)() {  static assert(false); }
T fnvOffsetBasis(T:uint)() { return 2166136261u; }
T fnvOffsetBasis(T:ulong)() { return 14695981039346656037U; }


/// Calculates the FNV hash of a string
/// http://www.isthe.com/chongo/tech/comp/fnv/
T fnv1Hash(T)(const char[] something) pure {
  T hsh = fnvOffsetBasis!T();
  foreach(octet; something) {
    hsh *= fnvPrime!T();
    hsh = hsh ^ octet;
  }
  return hsh;
}


/// Calculates the FNV1a hash
T fnv1aHash(T)(const char[] something) pure {
  T hsh = fnvOffsetBasis!T();
  foreach(octet; something) {
    hsh = hsh ^ octet;
    hsh *= fnvPrime!T();
  }
  return hsh;
}

/// Shortcut for using a 32 bit version of the FNV-1a hash
alias fnvHash32 = fnv1aHash!uint;

/// Shortcut for using a 64 bit version of the FNV-1a hash
alias fnvHash64 = fnv1aHash!ulong;

///
unittest {
  assert( fnv1Hash!uint("FNV Hash Test") == 0xAE2253F1 );
  assert( fnv1aHash!uint("FNV Hash Test") == 0xF38B3DB9 );

  assert( fnvHash32("FNV Hash Test ") != 0xF38B3DB9 );

  static assert( fnvHash32("FNV Hash Test") == 0xF38B3DB9 );
}

