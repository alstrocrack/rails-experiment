# frozen_string_literal: true

class CsvService
  def call(mode: :foreach, s3_object_key:)
    s3_client = S3Client.new
    s3_object = s3_client.get_object(s3_object_key).body

    case mode
    when :foreach
      CSV.foreach(s3_object, headers: true) do |row|
        puts row
      end
    else
      raise ArgumentError, "Invalid mode: #{mode}"
    end
  end
end
