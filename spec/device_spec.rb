# -*- Encoding: utf-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

require_relative "../lib/device"

if Helper.os_windows?
  describe "Windowsの場合" do
    describe Device::Library::Windows do
      it "Windows7_OS または Windows なボリュームネームのドライブは C:/" do
        module Dummy2
          extend Device::Library::Windows
        end
        device_root_dir = Dummy2.get_device_root_dir("Windows7_OS")
        device_root_dir ||= Dummy2.get_device_root_dir("Windows10_OS")
        device_root_dir ||= Dummy2.get_device_root_dir("Windows")
        expect(device_root_dir).to eq("C:/")
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
