# This file was generated by GoReleaser. DO NOT EDIT.
class Gh < Formula
  desc "GitHub CLI"
  homepage "https://github.com/cli/cli"
  version "0.10.1"
  bottle :unneeded

  if OS.mac?
    url "https://github.com/cli/cli/releases/download/v0.10.1/gh_0.10.1_macOS_amd64.tar.gz"
    sha256 "36340a0af921d9ab4eca22af66055eb4a649903368590cede179886ffbd15531"
  elsif OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/cli/cli/releases/download/v0.10.1/gh_0.10.1_linux_amd64.tar.gz"
      sha256 "f4fb05e9e9d93c640fc8e3f57cdb12f188c6a276c82e1fea8c70a3b0df453152"
    end
    if Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://github.com/cli/cli/releases/download/v0.10.1/gh_0.10.1_linux_arm64.tar.gz"
        sha256 "aff8ba3de4072d58603e193a6155392ed733f9ebd6bc4559a614312fc5b5a795"
      else
      end
    end
  end
  
  head do
    url "https://github.com/cli/cli.git", :branch => "trunk"
    depends_on "go"
  end

  def install
    system "make", "bin/gh", "manpages" if build.head?
    bin.install "bin/gh"
    man1.install Dir["./share/man/man1/gh*.1"]
    (bash_completion/"gh.sh").write `#{bin}/gh completion -s bash`
    (zsh_completion/"_gh").write `#{bin}/gh completion -s zsh`
    (fish_completion/"gh.fish").write `#{bin}/gh completion -s fish`
  end

  test do
    help_text = shell_output("#{bin}/gh --help")
    assert_includes help_text, "Usage:"
  end
end
