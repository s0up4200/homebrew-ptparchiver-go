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
    ldflags = "-s -w -X main.version=#{version} -X main.buildTime=#{Time.now.utc.iso8601}"
    system "go", "build", *std_go_args(ldflags: ldflags)
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/ptparchiver-go version")
  end
end 