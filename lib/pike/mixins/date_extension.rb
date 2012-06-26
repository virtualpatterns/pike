module Pike

  module Mixins

    module DateExtension

      def week_start
        return self - self.wday
      end

      def week_end
        return self + (6 - self.wday)
      end

    end

  end

end

class Date
  include Pike::Mixins::DateExtension
end
