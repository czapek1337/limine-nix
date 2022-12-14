{ pkgs, lib, fetchurl, llvm } :

pkgs.stdenv.mkDerivation rec {
  name = "limine";
  version = "4.20221014.1";
  src = fetchurl {
    url = "https://github.com/limine-bootloader/limine/releases/download/v${version}/limine-${version}.tar.xz";
    sha256 = "sha256-zfPaFJfiuVnI5JabLPOZUzNt7vp0tRUesYCWWjO8FqY=";
  };
  nativeBuildInputs = [
    pkgs.autoconf
    pkgs.automake
    pkgs.nasm
    llvm.bintools
    llvm.clang
    llvm.lld
  ];
  configurePhase = ''
    ./configure --enable-uefi-x86_64 --enable-uefi-ia32 --enable-bios --prefix=/
  '';
  installPhase = ''
    make DESTDIR=$out install
  '';
  meta = with lib; {
    homepage = "https://limine-bootloader.org/";
    description = "Limine Bootloader";
    license = licenses.bsd2;
    platforms = [ "i686-linux" "x86_64-linux" ];
    maintainers = [ maintainers.czapek1337 ];
  };
}
