# frozen_string_literal: true

module SimpleCov
  module Combine
    #
    # Handle combining two coverage results for same file
    #
    # Should be called through `SimpleCov.combine`.
    module FilesCombiner
    module_function

      #
      # Combines the results for 2 coverages of a file.
      #
      # @return [Hash]
      #
      def combine(cov_a, cov_b)
        combination = {}

        combination[:lines] = Combine.combine(LinesCombiner, cov_a[:lines], cov_b[:lines])

        if SimpleCov.branch_coverage?
          combination[:branches] = Combine.combine(BranchesCombiner, cov_a[:branches], cov_b[:branches])
          combination[:lines] = BranchesCombiner.uncover(combination[:branches], combination[:lines])
        end

        if SimpleCov.method_coverage?
          combination[:methods] = Combine.combine(MethodsCombiner, cov_a[:methods], cov_b[:methods])
          combination[:lines] = MethodsCombiner.uncover(combination[:methods], combination[:lines])
        end

        combination
      end
    end
  end
end
