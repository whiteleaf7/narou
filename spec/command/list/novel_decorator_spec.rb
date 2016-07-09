# -*- coding: utf-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

require "time"
require "timecop"
require "commandline"

describe Command::List::NovelDecorator do
  let(:novel) { Database.instance.get_data("id", id) }
  let(:parent) do
    OpenStruct.new(
      view_date_type: view_date_type,
      options: options,
      now: Time.now
    )
  end
  let(:options) { {} }
  let(:view_date_type) { "last_update" }
  let(:decorator) { Command::List::NovelDecorator.new(novel, parent) }

  describe "#decorate_id" do
    subject { decorator.decorate_id }
    context "novel is not frozen" do
      let(:id) { 1 }
      it { is_expected.to eq "   1" }
    end

    context "novel is frozen" do
      let(:id) { 22 }
      it { is_expected.to eq " <bold><cyan>*</cyan></bold>22" }
    end
  end

  describe "#decorate_date" do
    subject { decorator.decorate_date }
    let(:id) { 22 }

    context "view_date_type is last_update(default)" do
      it { is_expected.to eq "15/08/03" }
    end

    context "view_date_type is general_lastup" do
      let(:view_date_type) { "general_lastup" }
      it { is_expected.to eq "12/08/26" }
    end

    context "更新色のチェック" do
      around do |example|
        Timecop.freeze(freeze_time) do
          example.call
        end
      end

      context "新着から６時間以内だったら" do
        let(:id) { 1 }
        let(:freeze_time) { Time.parse("2016-06-19 17:24:51 +09:00") }
        it "紫色で表示する" do
          is_expected.to eq "<bold><magenta>16/06/19</magenta></bold>"
        end
      end

      context "新着がなく更新のみで６時間以内だったら" do
        let(:id) { 134 }
        let(:freeze_time) { Time.parse("2016-07-01 01:28:09 +09:00") }
        it "緑色で表示する" do
          is_expected.to eq "<bold><green>16/07/01</green></bold>"
        end
      end

      context "６時間以上過ぎた場合" do
        let(:id) { 134 }
        let(:freeze_time) { Time.parse("2016-07-01 12:28:09 +09:00") }
        it "色はつかない" do
          is_expected.to eq "16/07/01"
        end
      end
    end
  end

  describe "#decorate_kind" do
    subject { decorator.decorate_kind }

    context "連載" do
      let(:id) { 1 }

      it { is_expected.to be_nil }

      context "--kind" do
        let(:options) { { "kind" => true } }
        it { is_expected.to eq "連載" }
      end
    end

    context "短編" do
      let(:id) { 7 }

      it { is_expected.to be_nil }

      context "--kind" do
        let(:options) { { "kind" => true } }
        it { is_expected.to eq "短編" }
      end
    end
  end

  describe "#decorate_author" do
    subject { decorator.decorate_author }
    let(:id) { 1 }

    it { is_expected.to be_nil }

    context "--author" do
      let(:options) { { "author" => true } }
      it { is_expected.to eq "馬場翁" }
    end
  end

  describe "#decorate_site" do
    subject { decorator.decorate_site }
    let(:id) { 1 }

    it { is_expected.to be_nil }

    context "--site" do
      let(:options) { { "site" => true } }
      it { is_expected.to eq "小説家になろう" }
    end
  end
  
  describe "#decorate_title" do
    subject { decorator.decorate_title }

    context "付加なし" do
      let(:id) { 1 }
      it { is_expected.to eq "蜘蛛ですが、なにか？" }
    end

    context "完結表記あり" do
      let(:id) { 107 }
      it { is_expected.to eq "私、結婚しました！ <bold><black>(完結)</black></bold>" }
    end

    context "完結表記あり" do
      let(:id) { 107 }
      it { is_expected.to eq "私、結婚しました！ <bold><black>(完結)</black></bold>" }
    end

    context "削除表記あり" do
      let(:id) { 118 }
      it { is_expected.to eq "Asmody Story <bold><black>(削除)</black></bold>" }
    end

    context "完結・削除表記あり" do
      let(:id) { 40 }
      it { is_expected.to eq "孤独と共に歩む者 <bold><black>(完結)</black></bold> <bold><black>(削除)</black></bold>" }
    end

    context "短編表記あり" do
      let(:id) { 7 }
      it { is_expected.to eq "異世界でアイテムコレクター  <bold><black>(短編)</black></bold>" }

      context "--kind 指定時" do
        let(:options) { { "kind" => true } }
        it "短編表記はなし" do
          is_expected.to eq "異世界でアイテムコレクター"
        end
      end
    end
  end

  describe "#decorate_url" do
    subject { decorator.decorate_url }
    let(:id) { 1 }

    it { is_expected.to be_nil }

    context "--url" do
      let(:options) { { "url" => true } }
      it { is_expected.to eq "http://ncode.syosetu.com/n7975cr/" }
    end
  end

  describe "#decorate_tag" do
    subject { decorator.decorate_tags }

    context "タグがない場合" do
      let(:id) { 7 }
      it { is_expected.to be_nil }

      context "--tag" do
        let(:options) { { "tags" => true } }
        it { is_expected.to be_nil }
      end
    end

    context "タグがひとつある場合" do
      let(:id) { 1 }
      it { is_expected.to be_nil }

      context "--tag" do
        let(:options) { { "tags" => true } }
        it { is_expected.to eq "<bold><white>modified</white></bold>" }
      end
    end

    context "タグが複数ある場合" do
      let(:id) { 127 }
      it { is_expected.to be_nil }

      context "--tag" do
        let(:options) { { "tags" => true } }
        it { is_expected.to eq "<bold><red>end</red></bold>,<bold><white>modified</white></bold>" }
      end
    end
  end
end
