module Jekyll
  require 'yaml'

  class TTag < Liquid::Tag

    # A plugin for adding some I18n to your jekyll.
    # 1. Create a _locales folder in your jekyll root.
    # 2. For each locale you would like to support, add a .yml file.
    # 3. Example: _locales/en.yml
    # 4. Set an environment variable with ENV["JLANG"], or set a value in the
    # site config vars. I.e. locale: "en"
    # 5. Call {% t hello_world %} in your views. It will search the .yml file
    # for the respective key and return the translation

    @@locale = nil
    @@locales = nil

    def initialize(tag_name, text, tokens)
      super
      # There can be whitespace on the key, ensure it is removed
      @text = text.strip
    end

    def render(context)
      return unless set_locale(context)
      translate(@text, context)
    end

    def translate(translation_key, context)
      translation = @@locales[translation_key]
      missing_translation(translation_key, context) unless translation
      translation || translation_key
    end

    def missing_translation(translation_key, context)
      page = context.registers[:page]
      puts "= Missing translation ="
      puts "Please translate: #{page["url"] + page["path"]} - #{translation_key}"
      puts "= End Missing translation ="
    end

    def set_locale(context)
      @@locale = @@locale || ENV["JLANG"] || context.registers[:site].config["locale"]
      if @@locale
        @@locales = @@locales ||
          begin
            #YAML.load_file("e:/github/wangmuy.github.io/source/_locales/#{@@locale}.yml")
            YAML.load_file(File.expand_path(File.dirname(__FILE__)) + "/../source/_locales/#{@@locale}.yml")
          rescue Exception => e
	    puts File.expand_path(File.dirname(__FILE__)) + "../source/_locales"
	    puts Dir.getwd
	    puts e.message
            raise "please make sure that you: Created the _locales in your root jekyll folder
              && Properly created the language file for #{@@locale}. Caught "
          end
      end
      @@locale && @@locales
    end

  end
end

Liquid::Template.register_tag('i18n', Jekyll::TTag)