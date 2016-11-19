class ButtonsController < Narou::ApplicationController
  def load_button_resources
    dir = ButtonsController.buttons_dir
    @html_code = load_buttons_resource("buttons.html")
    @js_code = load_buttons_resource("buttons.js")
  end

  def load_buttons_resource(file)
    Helper::CacheLoader.load(File.join(Narou.get_misc_dir, "buttons", file))
  rescue Errno::ENOENT
    ""
  end

  # Routing ===============================================================

  before do
    @title = "操作ボタンの編集"
  end

  get "/buttons" do
    load_button_resources
    haml :"buttons/index"
  end
end
