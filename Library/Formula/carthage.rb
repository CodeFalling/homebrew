class Carthage < Formula
  desc "Decentralized dependency manager for Cocoa"
  homepage "https://github.com/Carthage/Carthage"
  url "https://github.com/Carthage/Carthage.git", :tag => "0.8",
                                                  :revision => "52e1a006158793eff3c9890f1934f0b7cb64d2b8",
                                                  :shallow => false
  head "https://github.com/Carthage/Carthage.git", :shallow => false

  depends_on :xcode => ["6.3", :build]

  bottle do
    cellar :any
    sha256 "61187391b4ac7a92896aab50b294b1cd721b45c0aa35e87468a96ea075e0cc29" => :yosemite
  end

  def install
    system "make", "prefix_install", "PREFIX=#{prefix}"
  end

  test do
    (testpath/"Cartfile").write 'github "jspahrsummers/xcconfigs"'
    system "#{bin}/carthage", "update"
  end
end
