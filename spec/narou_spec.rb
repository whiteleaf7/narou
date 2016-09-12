# -*- Encoding: utf-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

require "narou"

describe Narou do
  before :each do
    Narou.flush_cache
  end

  describe ".global_setting_dir" do
    before :all do
      @original_name = Narou::GLOBAL_SETTING_DIR_NAME.replace(".narousetting_dummy")
      @global_dir_in_root = File.expand_path(".narousetting_dummy", Narou.get_root_dir)
    end

    after :all do
      Narou::GLOBAL_SETTING_DIR_NAME.replace(@original_name)
    end

    after do
      Dir.rmdir(Narou.global_setting_dir)
    end

    context ".narou があるディレクトリにはない場合" do
      it "ユーザーディレクトリにあるべき" do
        expect(Narou.global_setting_dir).to eq File.expand_path(".narousetting_dummy", "~")
      end
    end

    context ".narou があるディレクトリと同じ場所にある場合" do
      before do
        FileUtils.mkdir(@global_dir_in_root)
      end

      it { expect(Narou.global_setting_dir).to eq @global_dir_in_root }
    end
  end
end
