class Fsa < Formula
  homepage "http://fsa.sourceforge.net/"
  #doi "10.1371/journal.pcbi.1000392"
  #tag "bioinformatics"

  url "https://downloads.sourceforge.net/project/fsa/fsa-1.15.9.tar.gz"
  sha1 "457aee5baca17357e52041eac7e3ecbc226bea75"

  bottle do
    cellar :any
    sha256 "2c1b0de0c38480c7818db3c032c79f818e20dae1035da6ac138fdb14f1454e93" => :yosemite
    sha256 "771dd32750e74a3e94215693b8fa2c14e79a3ed5641c7016075b3da67999a434" => :mavericks
    sha256 "32753a10cdcfe7650670170c245ba19535946cbc617f402258ab934016b00d63" => :mountain_lion
  end

  depends_on "mummer" => :recommended

  def install
    system "./configure",
      "--disable-debug",
      "--disable-dependency-tracking",
      "--disable-silent-rules",
      "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    system "#{bin}/fsa", "--version"
  end
end
