# frozen_string_literal: true

class S3Client
  def initialize
    @client = Aws::S3::Client.new(
      region: ENV["AWS_REGION"]
    )
  end

  def list_buckets
    @client.list_buckets.buckets
  end

  def get_object(object_key)
    @client.get_object(bucket: ENV["AWS_S3_BUCKET"], key: object_key)
  end
end
