class CIJoe
  class Hook
    def self.run(name, project_path, opts)
      file = "#{project_path}/.git/hooks/#{name}"
      output  = nil

      if File.exists?(file)
        keep_environment do
          opts.each do |key, value|
            key = key.to_s.upcase
            ENV[key] = value.to_s
          end

          output = `sh #{file}`
        end
      end

      output
    end

    # https://github.com/defunkt/cijoe/pull/68
    def self.keep_environment(&block)
      orig_ENV = ENV.to_hash

      yield block

      ENV.clear
      orig_ENV.each{ |k, v| ENV[k] = v}
    end
  end
end
