class CIJoe
  class Hook
    class << self
      def run(name, project_path, opts, hooks_dir="/.git/hooks/")
        file   = File.join(project_path, hooks_dir, name)
        output = nil

        if File.exists?(file)
          orig_ENV = ENV.to_hash

          opts.each do |key, value|
            key = key.to_s.upcase
            ENV[key] = value.to_s
          end

          output = `sh #{file}`

          ENV.clear
          orig_ENV.each{ |k, v| ENV[k] = v}
        end

        output
      end
    end
  end
end
