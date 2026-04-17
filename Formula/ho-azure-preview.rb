class HoAzurePreview < Formula
  desc "Preview Homebrew formula for HarrierOps Azure"
  homepage "https://github.com/HarrierSecurity/HarrierOps-Azure"
  url "https://github.com/HarrierSecurity/HarrierOps-Azure/archive/refs/tags/v1.1.0.tar.gz"
  sha256 "9cb30663fd3720865a1fbd9f70112b4e24be811a3d2e77e23854f645c4ca454b"
  license "MIT"
  head "https://github.com/HarrierSecurity/HarrierOps-Azure.git", branch: "main"

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(output: bin/"ho-azure"), "./cmd/azurefox"
  end

  test do
    assert_match "HO-Azure Help", shell_output("#{bin}/ho-azure help")
  end
end
