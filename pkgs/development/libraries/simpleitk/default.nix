{ lib, stdenv, fetchFromGitHub, cmake, swig4, lua, itk }:

stdenv.mkDerivation rec {
  pname = "simpleitk";
  version = "2.1.1.1";

  outputs = [ "out" "dev" ];

  src = fetchFromGitHub {
    owner = "SimpleITK";
    repo = "SimpleITK";
    rev = "v${version}";
    sha256 = "sha256-W53TbrgIwY9jj0GXz1LIrsBO9YL4VkH6531UYV0IqbE=";
  };

  nativeBuildInputs = [ cmake swig4 ];
  buildInputs = [ lua itk ];

  # 2.0.0: linker error building examples
  cmakeFlags = [ "-DBUILD_EXAMPLES=OFF" "-DBUILD_SHARED_LIBS=ON" ];

  meta = with lib; {
    homepage = "https://www.simpleitk.org";
    description = "Simplified interface to ITK";
    maintainers = with maintainers; [ bcdarwin ];
    platforms = platforms.linux;
    license = licenses.asl20;
  };
}
