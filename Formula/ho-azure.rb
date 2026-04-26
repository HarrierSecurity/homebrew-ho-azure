class HoAzure < Formula
  desc "Azure recon CLI for HarrierOps"
  homepage "https://github.com/HarrierSecurity/HarrierOps-Azure"
  url "https://github.com/HarrierSecurity/HarrierOps-Azure/archive/refs/tags/v1.2.0.tar.gz"
  sha256 "0163e98d9e906d5833b72db83a0dc7369d1c2ef9330051b45bdaa5d2f91107b9"
  license "MIT"

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(output: bin/"ho-azure"), "./cmd/azurefox"
  end

  test do
    assert_match "HO-Azure Help", shell_output("#{bin}/ho-azure help")
    assert_match "tenant_id", shell_output("AZUREFOX_PROVIDER=static #{bin}/ho-azure whoami --output json")
    assert_match "credential-path",
                 shell_output("AZUREFOX_PROVIDER=static #{bin}/ho-azure chains credential-path --output json")
    assert_match "automation",
                 shell_output("AZUREFOX_PROVIDER=static #{bin}/ho-azure persistence automation --output json")
  end
end
