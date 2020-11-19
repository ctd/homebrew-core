class Kubecm < Formula
  desc "KubeConfig Manager"
  homepage "https://guoxudong.io/post/kubecm/"
  url "https://github.com/sunny0826/kubecm/archive/v0.10.2.tar.gz"
  sha256 "1c5527a783c15f3389d0b8505a028704fd7238492d6ae511831cdaab32626c2f"
  license "Apache-2.0"

  depends_on "go" => :build

  def install
    system "go", "build",
           "-ldflags", "-X github.com/sunny0826/kubecm/cmd.kubecmVersion=#{version}",
           "-o", bin/"kubecm"

    # Install bash completion
    output = Utils.safe_popen_read("#{bin}/kubecm", "completion", "bash")
    (bash_completion/"kubecm").write output

    # Install zsh completion
    output = Utils.safe_popen_read("#{bin}/kubecm", "completion", "zsh")
    (zsh_completion/"_kubecm").write output
  end

  test do
    assert_match "\nKubeConfig Manager\n", shell_output("#{bin}/kubecm -h 2>&1")
  end
end
