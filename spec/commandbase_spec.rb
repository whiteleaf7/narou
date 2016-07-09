# -*- Encoding: utf-8 -*-
#
# Copyright 2013 whiteleaf. All rights reserved.
#

require "commandbase"

describe Command::CommandBase do
  let(:command) { Command::CommandBase.new }

  describe "#tagname_to_ids" do
    subject { command.tagname_to_ids(argv); argv }

    context "通常IDを指定した場合" do
      let(:argv) { %w(1 7 22) }

      it { is_expected.to eq [1, 7, 22] }
    end

    context "ID 404 及びタグ404が存在する場合" do
      context "そのまま指定したら" do
        let(:argv) { %w(404) }
        it "id 404 の小説を取得すべき" do
          is_expected.to eq [404]
        end
      end

      context "tag: をつけたら" do
        let(:argv) { %w(tag:404) }
        it "404タグの小説を取得すべき" do
          is_expected.to eq [40, 118]
        end
      end
    end

    shared_examples "input tags" do |prefix|
      context prefix == "" ? "普通にタグを指定した場合" : "#{prefix} をつけた場合" do
        context "存在するタグを指定した時" do
          context "１つ指定した時" do
            let(:argv) { %W(#{prefix}end) }
            it { is_expected.to eq [40, 107, 127] }
          end

          context "複数指定した時" do
            let(:argv) { %W(#{prefix}modified #{prefix}end) }
            it "複数のタグでIDが重複した場合でも取得するIDはユニークである" do
              is_expected.to eq [1, 127, 40, 107]
            end
          end

          context "IDとタグを同時に指定した場合" do
            context "IDがかぶらない場合" do
              let(:argv) { %W(7 #{prefix}modified) }
              it { is_expected.to eq [7, 1, 127] }
            end

            context "IDが被る場合" do
              let(:argv) { %W(127 #{prefix}modified) }
              it { is_expected.to eq [127, 1] }
            end
          end
        end

        context "存在しないタグを指定した場合" do
          let(:argv) { %W(#{prefix}asdf) }
          it "指定されたタグ名部分が返る" do
            is_expected.to eq ["asdf"]
          end
        end
      end
    end

    include_examples "input tags", ""
    include_examples "input tags", "tag:"

    describe "^tag: を使った場合" do
      context "存在するタグを指定した時" do
        context "１つ指定した時" do
          let(:argv) { %w(^tag:end) }
          it { is_expected.to eq [1, 7, 22, 29, 118, 134, 404] }
        end

        context "複数指定した時" do
          let(:argv) { %w(^tag:modified ^tag:end) }
          it "両方のタグを持つ小説のみ除外される" do
            is_expected.to eq [7, 22, 29, 40, 107, 118, 134, 404, 1]
          end
        end

        context "IDと除外タグを同時に指定した場合" do
          let(:argv) { %w(107 127 ^tag:modified) }
          it { is_expected.to eq [107, 127, 7, 22, 29, 40, 118, 134, 404] }
        end
      end

      context "存在しないタグを指定した場合" do
        let(:argv) { %w(^tag:asdf) }
        it "指定されたタグ名部分が返る" do
          is_expected.to eq ["asdf"]
        end
      end
    end
  end
end
