# frozen_string_literal: true

require "aws-sdk-s3"
require "csv"

class CsvOssService
  def call(key:)
    s3_client = Aws::S3::Client.new(region: "ap-northeast-1")
    object = s3_client.get_object(key: key)

    file_path = Rails.root.join("tmp", "downloaded.csv").to_s

    File.open(file_path, "wb") { |file| file << object.body.read }

    csv = CSV.open(file_path, "r", headers: true)
    csv.each { |row| puts row }
  end
end
