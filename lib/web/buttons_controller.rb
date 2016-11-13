class CustomButton
  attr_accessor :name, :html_code, :js_code

  def self.all
  end

  def initialize(name)
    self.name = name
    load_resources
  end

  private

  def load_resources
    self.html_code = File.read(html_code_path)
    self.js_code = File.read(js_code_path)
  end

  def buttons_dir
    File.join(Narou.get_misc_dir, "buttons")
  end

  def html_code_path
    File.join(buttons_dir, "#{@name}.html")
  end

  def js_code_path
    File.join(buttons_dir, "#{@name}.js")
  end
end

class ButtonsController < Narou::ApplicationController
  before do
    @title = "操作ボタンの編集"
  end

  get "/buttons" do
    @buttons = []
    haml :"buttons/index"
  end
end
