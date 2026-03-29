{ mkDerivation, aeson, base, bytestring, containers, directory
, http-client, http-client-tls, http-types, lens, lib, modern-uri
, network-uri, parsec, parser-combinators, text, time
, transformers, pkgs
}:
let  
  nix-thunk = pkgs.fetchFromGitHub {
    owner = "obsidiansystems";
    repo = "nix-thunk";
    rev = "8fe6f2de2579ea3f17df2127f6b9f49db1be189f";
    sha256 = "14l2k6wipam33696v3dr3chysxhqcy0j7hxfr10c0bxd1pxv7s8b";
  };
  n = import nix-thunk {};
  sources = n.mapSubdirectories n.thunkSource ./thunks;
  scrappy-core = pkgs.haskellPackages.callCabal2nix "scrappy-core" sources.scrappy-core {};

in mkDerivation {
  pname = "scrappy-requests";
  version = "0.1.0.4";
  src = ./.;
  libraryHaskellDepends = [
    aeson base bytestring containers directory http-client
    http-client-tls http-types lens modern-uri network-uri parsec
    parser-combinators text time transformers scrappy-core 
  ];
  homepage = "https://github.com/TypifyDev/scrappy";
  description = "html pattern matching library and high-level interface concurrent requests lib for webscraping";
  license = lib.licenses.bsd3;
}
