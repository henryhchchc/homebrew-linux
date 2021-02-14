# Documentation: https://1.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class ContainersConmon < Formula
  desc "An OCI container runtime monitor."
  homepage "https://github.com/containers/conmon"
  url "https://github.com/containers/conmon/archive/v2.0.26.tar.gz"
  sha256 "845744c3323bbf9adab4444d70fd7de0ceb12a578c9cf2fd2366c6bed0ac7970"
  license "Apache-2.0"

  head "https://github.com/containers/conmon.git", branch: "master"

  depends_on "go" => :build
  depends_on "gcc" => :build
  depends_on "glib" => :build
  depends_on "pkg-config" => :build
  depends_on "runc"

  if Formula["glibc"].any_version_installed? || OS::Linux::Glibc.system_version < Formula["glibc"].version
    depends_on "glibc"
  end

  def install
    system "make", "PREFIX=#{prefix}"
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test conmon`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end
