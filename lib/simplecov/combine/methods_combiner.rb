# frozen_string_literal: true

module SimpleCov
  module Combine
    #
    # Combine different method coverage results on single file.
    #
    # Should be called through `SimpleCov.combine`.
    module MethodsCombiner
    module_function

      #
      # Combine method coverage from 2 sources
      #
      # @return [Hash]
      #
      def combine(coverage_a, coverage_b)
        result_coverage = {}

        keys = (coverage_a.keys + coverage_b.keys).uniq

        keys.each do |method_name|
          result_coverage[method_name] =
            coverage_a.fetch(method_name, 0) + coverage_b.fetch(method_name, 0)
        end

        result_coverage
      end

      def uncover(method_cover, lines)
        method_cover&.each do |method, count|
          next if count.positive? || method[2] != method[4] # start, end lines

          lines[method[2]] = 0
        end

        lines
      end
    end
  end
end
