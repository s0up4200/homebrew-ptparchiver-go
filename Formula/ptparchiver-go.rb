# frozen_string_literal: true

# ptparchiver-go is a tool for archiving content from PTP
class PtparchiverGo < Formula
  desc "Command-line tool for archiving content from PTP efficiently"
  homepage "https://github.com/s0up4200/ptparchiver-go"
  url "https://github.com/s0up4200/ptparchiver-go/archive/refs/tags/null.tar.gz"
  sha256 "d5558cd419c8d46bdc958064cb97f963d1ea793866414c025906ec15033512ed"
  license "MIT"

  depends_on "go" => :build

  def install
    ENV["CGO_ENABLED"] = "0"
    build_time = Time.at(Time.now.to_i).utc.strftime("%Y-%m-%dT%H:%M:%SZ")
    
    ldflags = %W[
      -s -w
      -X github.com/s0up4200/ptparchiver-go/pkg/version.Version=#{version}
      -X github.com/s0up4200/ptparchiver-go/pkg/version.Date=#{build_time}
      -X github.com/s0up4200/ptparchiver-go/pkg/version.BuiltBy=Homebrew
    ].join(" ")

    system "go", "build", "-o", bin/"ptparchiver-go", "-ldflags=#{ldflags}", "./cmd/ptparchiver/main.go"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/ptparchiver-go version")
  end
end 