# frozen_string_literal: true

#
# Copyright 2013 whiteleaf. All rights reserved.
#

module Command
  class Update < CommandBase
    class Interval
      MIN = 2.5               # 作品間ウェイトの最低秒数(処理時間含む)
      FORCE_WAIT_TIME = 2.0   # 強制待機時間

      def initialize(interval)
        @time = Time.now - MIN
        interval = interval.to_f
        @interval_time = interval >= MIN ? interval : MIN
      end

      def wait
        wait_time = Time.now - @time
        sleep(@interval_time - wait_time) if wait_time < @interval_time
        @time = Time.now
      end

      def force_wait
        sleep(FORCE_WAIT_TIME)
      end
    end
  end
end
