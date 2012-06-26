module Pike

  module Mixins

    module DateExtension

      def start_of_week
        return self - self.wday
      end

      def end_of_week
        return self + (6 - self.wday)
      end

    end

  end

end

class Date
  include Pike::Mixins::DateExtension
end
