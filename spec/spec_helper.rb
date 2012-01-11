require 'alter_table'

shared_context 'ActiveRecord configuration' do
  let(:connection) { mock('connection') }
  let(:connection_adapter) do
    ActiveRecord::ConnectionAdapters::AbstractAdapter.new(connection).tap do |adapter|
      class << adapter
        def native_database_types
          { :decimal => 'integer' }
        end
      end
    end
  end

  let(:alterer) do
    Object.new.tap do |object|
      # Can't use decribed_class in the block, so make a local variable!
      testing_interface = described_class
      
      object.instance_variable_set(:@adapter, connection_adapter)
      object.class_eval do
        include testing_interface
        attr_reader :adapter
      end
    end
  end
end
