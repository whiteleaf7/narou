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
        expect(Dummy.get_device_root_dir("Windows7_OS")).to eq("C:/")
      end
    end

    describe "Kindle" do
      before do
        @device = Device.create("kindle")
      end

      it "は存在するべき" do
        expect(Device.exists?("kindle")).to be_truthy
      end
    end

    describe "Kobo" do
      before do
        @device = Device.create("kobo")
      end

      it "は存在するべき" do
        expect(Device.exists?("kobo")).to be_truthy
      end
    end
  end
end
