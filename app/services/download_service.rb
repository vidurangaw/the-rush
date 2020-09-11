# frozen_string_literal: true

require 'csv'

class DownloadService
  class << self
    def generate_csv(records)
      mappings = Rushing::MAPPINGS
      CSV.generate(headers: true) do |csv|
        csv << mappings.values

        records.each do |record|
          csv << mappings.keys.map { |attr| record.send(attr) }
        end
      end
    end
  end
end
