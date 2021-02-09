class Runc < Formula
  desc "CLI tool for spawning and running containers according to the OCI specification"
  homepage "https://www.opencontainers.org/"
  url "https://github.com/opencontainers/runc/releases/download/v1.0.0-rc93/runc.tar.xz"
  version "1.0.0-rc93"
  sha256 "70ee0fcf45b17f0da93dd4c4d174046a3584080dcc07c5468914d33d57c8202d"
  license "Apache-2.0"

  head "https://github.com/opencontainers/runc.git", branch: "master"

  depends_on "go" => :build
  depends_on "go-md2man" => :build
  depends_on "llvm" => :build
  depends_on "libseccomp"
  depends_on :linux

  fails_with :gcc do
    cause "gcc will cause errors in cgo"
  end

  def install
    ENV["HOMEBREW_CC"] = "clang"
    system "make", "runc", "man"
    system "make", "install", "PREFIX=#{prefix}"
    system "make", "install-man", "PREFIX=#{prefix}"
  end

  test do
    system "runc", "-v"
  end
end
