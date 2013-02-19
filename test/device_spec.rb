# -*- Encoding: utf-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

require_relative "../lib/device"

if Helper.os_windows?
  describe "Windowsの場合" do
    it "Kindleと接続時connecting?はtrueになるべき" do
      Device::Kindle.connecting?.should be_true
    end

    it "Kindleのドキュメントディレクトリの名前は F:/documents" do
      Device::Kindle.get_documents_path.should == "F:/documents"
    end

    it "Windows7_OSなボリュームネームのドライブは C:/" do
      module Dummy
        extend Device::Library::Windows
      end
      Dummy.get_device_root_dir("Windows7_OS").should == "C:/"
    end
  end
end
