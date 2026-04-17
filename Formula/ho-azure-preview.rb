class HoAzurePreview < Formula
  desc "Preview Homebrew formula for HarrierOps Azure"
  homepage "https://github.com/HarrierSecurity/HarrierOps-Azure"
  url "https://github.com/HarrierSecurity/HarrierOps-Azure/archive/refs/tags/v1.1.0.tar.gz"
  sha256 "1ead205b533750a36b7fbba653df872ce257587af63258a39a97294c62ccbd82"
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
