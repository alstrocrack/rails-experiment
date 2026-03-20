# frozen_string_literal: true

require "benchmark"

class CsvService
  def call(s3_object_key, mode: :foreach)
    s3_client = S3Client.new
    s3_object = s3_client.get_object(s3_object_key).body

    Benchmark.bm do |x|
      case mode
      when :foreach
        x.report("CSV.foreach") do
          CSV.foreach(s3_object, headers: true) do |row|
            puts row
          end
        end
      when :parse
        x.report("CSV.parse") do
          CSV.parse(s3_object, headers: true).each do |row|
            puts row
          end
        end
      when :read
        x.report("CSV.read") do
          CSV.read(s3_object, headers: true).each do |row|
            puts row
          end
        end
      else
        raise ArgumentError, "Invalid mode: #{mode}"
      end
    end

    nil
  end
end
