# frozen_string_literal: true

require 'csv'

class DownloadService
  class << self
    def generate_csv(records)
      record_ids = records.pluck(:id)
      mappings = Rushing::MAPPINGS

      Enumerator.new do |yielder|
        yielder << CSV.generate_line(mappings.values)
        record_ids.each_slice(100) do |batch_ids|
          Rushing.find(batch_ids).each do |record|
            yielder << CSV.generate_line(mappings.keys.map { |attr| record.send(attr) })
          end
        end
      end
    end
  end
end
