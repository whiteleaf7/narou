module Narou
  class ApplicationController < Sinatra::Base
    register Sinatra::Reloader if $development

    before do
      @bootstrap_theme =
        case params["theme"]
        when nil
          Narou.get_theme
        when ""
          # 環境設定画面で未設定が選択された時
          nil
        else
          params["theme"]
        end
      Narou::Worker.push_as_system_worker do
        Inventory.clear
        Database.instance.refresh
        Narou.load_global_replace_pattern
      end
    end
  end
end
