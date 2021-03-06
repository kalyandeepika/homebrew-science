class Cdo < Formula
  homepage "https://code.zmaw.de/projects/cdo"
  url "https://code.zmaw.de/attachments/download/11392/cdo-1.7.0.tar.gz"
  sha256 "2a9712fe315d4f09e0c9c8f2f31d6035bf78f51946af9a8fba87f21b4033eb15"

  bottle do
    cellar :any
    sha256 "dcf243e1fcaec53af53320fba6bd89c30ac1940918ee897f4a70d252122a20c6" => :el_capitan
    sha256 "e02689f2564a53c0df7fb98b2e86e6f30c45d113483dbeac712c4cec9b84d940" => :yosemite
    sha256 "051ba1d5836d948590b011dd3c22f1835b162ab6746b1c6fe97a01f1a3e160c0" => :mavericks
  end

  option "with-grib2", "Compile Fortran bindings"
  deprecated_option "enable-grib2" => "with-grib2"
  option "with-openmp", "Compile with OpenMP support"

  if build.with? "grib2"
    depends_on "grib-api"
    depends_on "jasper"
  end

  needs :openmp if build.with? "openmp"

  depends_on "hdf5"
  depends_on "netcdf"
  depends_on "szip"

  def install
    args = ["--disable-debug", "--disable-dependency-tracking",
            "--prefix=#{prefix}",
            "--with-netcdf=#{Formula["netcdf"].opt_prefix}",
            "--with-hdf5=#{Formula["hdf5"].opt_prefix}",
            "--with-szlib=#{Formula["szip"].opt_prefix}"]

    if build.with? "grib2"
      args << "--with-grib_api=#{Formula["grib-api"].opt_prefix}"
      args << "--with-jasper=#{Formula["jasper"].opt_prefix}"
    end

    system "./configure", *args
    system "make", "install"
  end

  test do
    system "#{bin}/cdo", "-h"
  end
end
