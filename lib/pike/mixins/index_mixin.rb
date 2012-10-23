module Pike

  module Mixins

    module IndexMixin
      require 'test/unit/assertions'

      include Test::Unit::Assertions

      def assert_index(criteria)
        explanation = criteria.execute.explain
        self.assert_match(/BtreeCursor/, explanation['cursor'], 'Expected cursor to match BtreeCursor')
        self.assert_operator(explanation['nscannedObjects'], '>', 0, 'Expected number of index entries scanned to be greater than 0.')
        self.assert_operator(explanation['n'], '>', 0, 'Expected number of documents returned to be greater than 0.')
        self.assert_equal(explanation['n'], explanation['nscannedObjects'], 'Expected number of index entries scanned to be equal to number of documents returned.')
      end

    end

  end

end
