# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class Podman < Formula
  desc "Tool for managing OCI containers and pods"
  homepage "https://podman.io"
  url "https://github.com/containers/podman/archive/v3.0.0.tar.gz"
  sha256 "4e9e81f570de200bbe42f452cda5366e24e35d94c303b6cc5052370552a925e6"
  license "Apache-2.0"
  version "3.0.0"

  head "https://github.com/containers/podman.git", branch: "master"


  patch :DATA

  # depends_on "cmake" => :build
  # depends_on "containers-conmon"
  depends_on "runc"
  depends_on "libseccomp"
  depends_on "systemd"
  depends_on "gpgme"
  depends_on "llvm" => :build
  depends_on "go" => :build
  depends_on "go-md2man" => :build

  def install
    ENV["HOMEBREW_CC"] = "clang"
    system "make", "PREFIX=#{prefix}" 
    system "make", "install", "PREFIX=#{prefix}", "ETCDIR=#{HOMEBREW_PREFIX}/etc"
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test podman`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end

__END__
--- a/vendor/github.com/seccomp/libseccomp-golang/seccomp_internal.go
+++ b/vendor/github.com/seccomp/libseccomp-golang/seccomp_internal.go
@@ -532,8 +532,6 @@ func (a ScmpCompareOp) toNative() C.int {
 func actionFromNative(a C.uint32_t) (ScmpAction, error) {
 	aTmp := a & 0xFFFF
 	switch a & 0xFFFF0000 {
-	case C.C_ACT_KILL:
-		return ActKill, nil
 	case C.C_ACT_KILL_PROCESS:
 		return ActKillProcess, nil
 	case C.C_ACT_KILL_THREAD:
