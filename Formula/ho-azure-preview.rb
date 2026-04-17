class HoAzurePreview < Formula
  desc "Preview Homebrew formula for HarrierOps Azure"
  homepage "https://github.com/HarrierSecurity/HarrierOps-Azure"
  url "https://github.com/HarrierSecurity/HarrierOps-Azure/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "82630b8a65bded8ccf5d6db98b78f7c1a5306673b53d8c6fb17ed8a1cacca8af"
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
