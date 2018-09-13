# frozen_string_literal: true

#
# Copyright 2013 whiteleaf. All rights reserved.
#

require "fileutils"
require_relative "../downloader"
require_relative "../novelconverter"
require_relative "../inventory"
require_relative "../kindlestrip"
require_relative "../worker"

module Command
  class Convert < CommandBase
    def self.oneline_help
      "小説を変換します。管理小説以外にテキストファイルも変換可能"
    end

    attr_accessor :device, :converted_txt_path

    @@sending_error_list = []

    def self.display_sending_error_list
      return unless exists_sending_error_list?
      $stdout2.puts <<~MSG
        #{"=" * 79}
        ・送信失敗リスト
        #{@@sending_error_list.join("\n")}

      MSG
      $stdout2.puts "<red><bold>上記のファイルの送信に失敗しました。</bold></red>".termcolor
      $stdout2.puts <<~MSG
        送信出来なかった原因を解消し、send コマンドを実行して下さい。
        #{"=" * 79}
      MSG
      @@sending_error_list.clear
    end

    def self.exists_sending_error_list?
      @@sending_error_list.present?
    end

    def initialize
      @argument_target_type = :file

      super("<target> [<target2> ...] [options]")
      @opt.separator <<-EOS

  ・指定した小説を縦書き用に整形及びEPUB、MOBIに変換します。
  ・変換したい小説のNコード、URL、タイトルもしくはIDを指定して下さい。
    IDは #{@opt.program_name} list を参照して下さい。
  ・一度に複数の小説を指定する場合は空白で区切って下さい。
  ※-oオプションがない場合、[作者名] 小説名.txtが小説の保存フォルダに出力されます
  ・管理小説以外にもテキストファイルを変換出来ます。
    テキストファイルのファイルパスを指定します。
  ※複数指定した場合に-oオプションがあった場合、ファイル名に連番がつきます。
  ・MOBI化する場合は narou setting device=kindle をして下さい。
  ・device=kobo の場合、.kepub.epub を出力します。

  Examples:
    narou convert n9669bk
    narou convert http://ncode.syosetu.com/n9669bk/
    narou convert 異世界迷宮で奴隷ハーレムを
    narou convert 1 -o "ハーレム -変換済み-.txt"
    narou convert mynovel.txt --enc sjis

  Options:
      EOS
      @opt.on("-o FILE", "--output FILE", "出力ファイル名を指定する。フォルダパス部分は無視される") { |filename|
        @options["output"] = filename
      }
      @opt.on("-e ENCODING", "--enc ENCODING",
              "テキストファイル指定時の文字コードを指定する。デフォルトはUTF-8") { |encoding|
        encoding = "utf-8" if encoding =~ /UTF8/i
        @options["encoding"] = encoding
      }
      @opt.on("--no-epub", "AozoraEpub3でEPUB化しない") {
        @options["no-epub"] = true
      }
      @opt.on("--no-mobi", "kindlegenでMOBI化しない") {
        @options["no-mobi"] = true
      }
      @opt.on("--no-strip", "MOBIをstripしない") {
        @options["no-strip"] = true
      }
      @opt.on("--no-zip", "i文庫用のzipファイルを作らない") {
        @options["no-zip"] = true
      }
      @opt.on("--no-open", "出力時に保存フォルダを開かない") {
        @options["no-open"] = true
      }
      @opt.on("-i", "--inspect", "小説状態の調査結果を表示する") {
        @options["inspect"] = true
      }
      @opt.on("-v", "--verbose", "AozoraEpub3, kindlegen の標準出力を全て表示する") {
        @options["verbose"] = true
      }
      @opt.on("--ignore-default", "settingコマンドのdefault系設定を無視する") {
        @options["ignore-default"] = true
      }
      @opt.on("--ignore-force", "settingコマンドのforce系設定を無視する") {
        @options["ignore-force"] = true
      }
      @opt.separator <<-EOS

  Configuration:
    --no-epub, --no-mobi, --no-strip, --no-zip, --no-open , --inspect は narou setting コマンドで恒常的な設定にすることが可能です。
    convert.copy-to を設定すれば変換したEPUB/MOBIを指定のフォルダに自動でコピー出来ます。
    device で設定した端末が接続されていた場合、対応するデータを自動送信します。
    詳しくは narou setting --help を参照して下さい。
      EOS
    end

    def self.execute!(argv)
      Narou.concurrency_call do
        super
      end
    end

    def execute(argv)
      super
      init(argv)
      main(argv)
    end

    def init(argv)
      display_help! if argv.empty?
      @output_filename = @options["output"]
      if @output_filename
        @ext = File.extname(@output_filename)
        @basename = File.basename(@output_filename, @ext)
      else
        @basename = nil
      end
      return unless @options["encoding"]
      @enc = Encoding.find(@options["encoding"]) rescue nil
      return if @enc
      $stdout2.error "--enc で指定された文字コードは存在しません。sjis, eucjp, utf-8 等を指定して下さい"
    end

    def main(argv)
      build_device_names.each do |name|
        @device = Narou.get_device(name)
        if name
          $stdout2.puts "<bold><magenta>&gt;&gt; #{@device.display_name}用に変換します</magenta></bold>".termcolor
        end
        self.extend(@device.get_hook_module) if @device
        hook_call(:change_settings)
        convert_novels(argv)
      end
      return unless @options["multi-device"]
      # device の設定に戻す
      device = Narou.get_device
      force_change_settings_function(device.get_relative_variables) if device
    end

    def build_device_names
      multi_device = @options["multi-device"]
      device_names = if multi_device
                       multi_device.split(",").map(&:strip).map(&:downcase).select do |name|
                         Device.exists?(name).tap do |this|
                           unless this
                             $stdout2.error "[convert.multi-device] #{name} は有効な端末名ではありません"
                           end
                         end
                       end
                     else
                       [nil] # nil で device 設定が読まれる
                     end
      # kindle用のmobiを作る過程でepubが作成され、上書きされてしまうので、最初に作るようにする
      kindle = device_names.delete("kindle")
      device_names.unshift(kindle) if kindle
      if multi_device && device_names.empty?
        $stdout2.error "有効な端末名がひとつもありませんでした"
        exit Narou::EXIT_ERROR_CODE
      end
      device_names
    end

    def change_settings
      return unless @device
      if @options["multi-device"]
        force_change_settings_function(@device.get_relative_variables)
      end
    end

    def convert_novels(argv)
      tagname_to_ids(argv)
      argv.each.with_index(1) do |target, i|
        @target = target
        @novel_data = nil

        Helper.print_horizontal_rule($stdout2) if i > 1
        if @basename
          @basename << " (#{i})" if argv.length > 1
          @output_filename = @basename + @ext
        end

        if File.file?(target.to_s)
          using_send_command = false
          # not remove output files for text file conversion
          res = convert_txt(target)
        else
          using_send_command = true
          unless Downloader.novel_exists?(target)
            $stdout2.error "#{target} は存在しません"
            next
          end
          # remove output files for novel conversion
          NovelConverter.extensions_of_converted_files(@device).each do |ext|
            ebook_paths = Narou.get_ebook_file_paths(target, ext)
            NovelConverter.clean_up_temp_files(ebook_paths)
          end
          # start novel conversion
          @argument_target_type = :novel
          res = NovelConverter.convert(target, {
                  output_filename: @output_filename,
                  display_inspector: @options["inspect"],
                  ignore_force: @options["ignore-force"],
                  ignore_default: @options["ignore-default"],
                })
          @novel_data = Downloader.get_data_by_target(target)
          @options["yokogaki"] = NovelSetting.load(target)["enable_yokogaki"]
        end
        next unless res
        array_of_converted_txt_path = res[:converted_txt_paths]
        ebook_file = nil
        array_of_converted_txt_path.each do |converted_txt_path|
          @converted_txt_path = converted_txt_path
          @use_dakuten_font = res[:use_dakuten_font]

          ebook_file = hook_call(:convert_txt_to_ebook_file)
          next if ebook_file.nil?
          if ebook_file
            copy_to_converted_file(ebook_file)
            send_file_to_device(ebook_file) unless using_send_command
          end
        end
        send_file_to_device(ebook_file) if
          using_send_command && ebook_file

        if @options["no-open"].! && Narou.web?.!
          Helper.open_directory(File.dirname(@converted_txt_path), "小説の保存フォルダを開きますか")
        end
      end
    rescue Interrupt
      $stdout2.puts "変換を中断しました"
      exit Narou::EXIT_INTERRUPT
    end

    #
    # 直接指定されたテキストファイルを変換する
    #
    def convert_txt(target)
      return NovelConverter.convert_file(target, {
               encoding: @enc,
               output_filename: @output_filename,
               display_inspector: @options["inspect"],
               ignore_force: @options["ignore-force"],
               ignore_default: @options["ignore-default"],
             })
    rescue ArgumentError => e
      if e.message =~ /invalid byte sequence in UTF-8/
        $stdout2.error "テキストファイルの文字コードがUTF-8ではありません。" \
                       "--enc オプションでテキストの文字コードを指定して下さい"
        warn "(#{e.message})"
        return nil
      else
        raise
      end
    rescue Encoding::UndefinedConversionError, Encoding::InvalidByteSequenceError
      $stdout2.error <<~ERR
        #{target}:
        テキストファイルの文字コードは#{@options["encoding"]}ではありませんでした。
        正しい文字コードを指定して下さい
      ERR
      return nil
    end

    #
    # 変換された整形済みテキストファイルをデバイスに対応した書籍データに変換する
    #
    def convert_txt_to_ebook_file
      return NovelConverter.convert_txt_to_ebook_file(@converted_txt_path, {
        use_dakuten_font: @use_dakuten_font,
        device: @device,
        verbose: @options["verbose"],
        no_epub: @options["no-epub"],
        no_mobi: @options["no-mobi"],
        no_strip: @options["no-strip"],
        no_cleanup_txt: @argument_target_type == :file,
        yokogaki: @options["yokogaki"]
      })
    end

    class NoSuchDirectory < StandardError; end

    #
    # convert.copy-to で指定されたディレクトリに書籍データをコピーする
    #
    def copy_to_converted_file(src_path)
      copy_to_dir = get_copy_to_directory
      return nil unless copy_to_dir
      FileUtils.copy(src_path, copy_to_dir)
      copied_file_path = File.join(copy_to_dir, File.basename(src_path))
      $stdout2.puts copied_file_path.encode(Encoding::UTF_8) + " へコピーしました"
      copied_file_path
    rescue NoSuchDirectory => e
      $stdout2.error "#{e.message} はフォルダではないかすでに削除されています。コピー出来ませんでした"
      nil
    end

    #
    # 書籍ファイルのコピー先を取得
    #
    # copy-to が設定されていなければ nil を返す。
    # copy-to が存在しないディレクトリだった場合は例外を投げる
    #
    def get_copy_to_directory
      # 2.1.0 から convert.copy_to から convert.copy-to へ名称が変更された
      # (互換性維持のため、copy_to も使えるようにはしておく)
      copy_to_dir = @options["copy-to"] || @options["copy_to"]
      return nil unless copy_to_dir
      unless File.directory?(copy_to_dir)
        raise NoSuchDirectory, copy_to_dir
      end

      dirs = [copy_to_dir]
      gvalues = grouping_values
      if gvalues.device && @device
        dirs << @device.display_name
      end
      if gvalues.site && @novel_data
        dirs << @novel_data["sitename"]
      end
      copy_to_dir_with_groups = File.join(dirs)
      unless File.directory?(copy_to_dir_with_groups)
        FileUtils.mkdir_p(copy_to_dir_with_groups)
      end
      copy_to_dir_with_groups
    end
    private :get_copy_to_directory

    def grouping_values
      result = OpenStruct.new
      grouping = @options["copy-to-grouping"]
      if grouping.is_a?(TrueClass)
        # 後方互換維持用
        result.device = true
        return result
      end
      grouping.to_s.split(",").map(&:strip).each do |key|
        result[key] = true
      end
      result
    end

    def send_file_to_device(ebook_file)
      if @device && @device.physical_support? &&
        @device.connecting? && File.extname(ebook_file) == @device.ebook_file_ext
        if @argument_target_type == :novel
          if Send.execute!(@device.name, @target, io: $stdout2) > 0
            @@sending_error_list << ebook_file
          end
        else
          $stdout2.puts @device.name + "へ送信しています"
          copy_to_path = nil
          begin
            copy_to_path = @device.copy_to_documents(ebook_file)
          rescue Device::SendFailure
          end
          if copy_to_path
            $stdout2.puts copy_to_path.encode(Encoding::UTF_8) + " へコピーしました"
          else
            $stdout2.error "送信に失敗しました"
            @@sending_error_list << ebook_file
          end
        end
      end
    end
  end
end
