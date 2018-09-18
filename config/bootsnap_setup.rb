# frozen_string_literal: true

if ENV["NAROU_ENABLE_BOOTSNAP"]
  require "bootsnap"
  Bootsnap.setup(
    cache_dir:            "tmp/cache",
    development_mode:     false,
    load_path_cache:      true,
    autoload_paths_cache: false,
    disable_trace:        false,
    compile_cache_iseq:   true,
    compile_cache_yaml:   true
  )
end
