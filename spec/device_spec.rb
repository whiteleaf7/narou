# -*- Encoding: utf-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

require_relative "../lib/device"

if Helper.os_windows?
  describe "Windowsの場合" do
    describe Device::Library::Windows do
      it "Windows7_OSなボリュームネームのドライブは C:/" do
        module Dummy
          extend Device::Library::Windows
        end
        Dummy.get_device_root_dir("Windows7_OS").should == "C:/"
      end
    end

    describe "Kindle" do
      before do
        @device = Device.new("kindle")
      end

      it "は存在するべき" do
        Device.exists?("kindle").should be_true
      end

      it "と接続時connecting?はtrueになるべき" do
        @device.connecting?.should be_true
      end

      it "のドキュメントディレクトリの名前は F:/documents" do
        @device.get_documents_path.should == "F:/documents"
      end
    end

    describe "Kobo" do
      before do
        @device = Device.new("kobo")
      end

      it "は存在するべき" do
        Device.exists?("kobo").should be_true
      end

      it "と接続時connecting?はtrueになるべき" do
        @device.connecting?.should be_true
      end

      it "のドキュメントディレクトリの名前は ?:/" do
        @device.get_documents_path.should == "?:/"
      end
    end
  end
end
