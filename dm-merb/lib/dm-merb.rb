if defined?(Merb::Plugins)
  require File.join(File.dirname(__FILE__) / "merb" / "orms" / "data_mapper" / "connection")
  require File.join(File.dirname(__FILE__) / "merb" / "orms" / "data_mapper" / "resource")
  Merb::Plugins.add_rakefiles "dm-merb" / "merbtasks"

  class Merb::Orms::DataMapper::Connect < Merb::BootLoader

    after BeforeAppRuns

    def self.run
      Merb::Orms::DataMapper.connect
      Merb::Orms::DataMapper.register_session_type
    end

  end
end
