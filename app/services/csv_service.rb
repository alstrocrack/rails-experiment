# frozen_string_literal: true

class CsvService
  def call(mode: :foreach, s3_object_key:)
    s3_client = S3Client.new
    s3_object = s3_client.get_object(s3_object_key).body

    case mode
    when :foreach
      CSV.foreach(StringIO.new(s3_object)) do |row|
        p row
      end
    else
      raise ArgumentError, "Invalid mode: #{mode}"
    end
  end
end
