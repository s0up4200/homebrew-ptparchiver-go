# frozen_string_literal: true

# ptparchiver-go is a tool for archiving content from PTP
class PtparchiverGo < Formula
  desc "Command-line tool for archiving content from PTP efficiently"
  homepage "https://github.com/s0up4200/ptparchiver-go"
  url "https://github.com/s0up4200/ptparchiver-go/archive/refs/tags/v0.14.1.tar.gz"
  sha256 "e635ad2b44d27c5532454ea74dead9186509f4747a721616927ef531327a09ba"
  license "MIT"

  depends_on "go" => :build

  def install
    ENV["CGO_ENABLED"] = "0"
    
    ldflags = %W[
      -s -w
      -X github.com/s0up4200/ptparchiver-go/pkg/version.Version=#{version}
      -X github.com/s0up4200/ptparchiver-go/pkg/version.BuildTime=#{Time.now.utc.iso8601}
    ].join(" ")

    system "go", "build", "-o", bin/"ptparchiver-go", "-ldflags=#{ldflags}", "./cmd/ptparchiver/main.go"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/ptparchiver-go version")
  end
end 