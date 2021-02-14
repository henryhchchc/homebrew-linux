# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class Crun < Formula
  desc "A fast and lightweight fully featured OCI runtime and C library for running containers"
  homepage "https://github.com/containers/crun"
  url "https://github.com/containers/crun/archive/0.17.tar.gz"
  sha256 "1198f39a0b73171cddda9e81db95a4c8cb2eeb2b0ab9f72ad3b99a70b048202f"
  license "NOASSERTION"

  head "https://github.com/containers/crun.git", branch: "master"

  # depends_on "cmake" => :build
  depends_on "automake" => :build
  depends_on "autoconf" => :build
  depends_on "systemd"
  depends_on "gettext"
  depends_on "python" => :build
  depends_on "libtool"
  depends_on "libseccomp"
  depends_on "yajl"

  def install
    # ENV.deparallelize  # if your formula fails when building in parallel
    # Remove unrecognized options if warned by configure
    system "./autogen.sh"
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--enable-shared",
                          "--prefix=#{prefix}"
    system "make"
    system "make", "install"
    # system "cmake", ".", *std_cmake_args
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test crun`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end
