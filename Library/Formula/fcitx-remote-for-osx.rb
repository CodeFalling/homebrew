# Documentation: https://github.com/Homebrew/homebrew/blob/master/share/doc/homebrew/Formula-Cookbook.md
#                http://www.rubydoc.info/github/Homebrew/homebrew/master/frames
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!

class FcitxRemoteForOsx < Formula
  desc "A simulate fcitx-remote to handle osx input method in command line"
  homepage "https://github.com/CodeFalling/fcitx-remote-for-osx"
  url "https://github.com/CodeFalling/fcitx-remote-for-osx/archive/0.0.2.tar.gz"
  version "0.0.2"
  sha256 "746505694090d98d5ad572758e7597c49d3bea1b00208a8272c3648aad15ad69"

  # depends_on "cmake" => :build
  # depends_on :x11 # if your formula requires any X11/XQuartz components
  INPUT_METHOD = %w[baidu-pinyin baidu-wubi sogou-pinyin qq-wubi squirrel-rime osx-pinyin]
  INPUT_METHOD.each do |im|
    option "use-#{im}", "Build fcitx-remote for osx with #{im} support"
  end

  def install
    # ENV.deparallelize  # if your formula fails when building in parallel

    # Remove unrecognized options if warned by configure
    # system "cmake", ".", *std_cmake_args
    INPUT_METHOD.each do |im|
      if build.include? "use-#{im}"
        system "./build.py build #{im}"
        bin.install Dir["fcitx-remote-#{im}"]
        bin.install_symlink "fcitx-remote-#{im}" => "fcitx-remote"
      end
    end
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! It's enough to just replace
    # "false" with the main program this formula installs, but it'd be nice if you
    # were more thorough. Run the test with `brew test fcitx-remote-for-osx`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
  end
end
