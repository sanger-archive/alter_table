require 'spec_helper'

describe AlterTable::TableAlterer::ColumnAlterations do
  before(:each) do
    @connection         = mock('Connection')

    @connection_adapter = ActiveRecord::ConnectionAdapters::AbstractAdapter.new(@connection).tap do |adapter|
      class << adapter
        def native_database_types
          { :decimal => 'integer' }
        end
      end
    end

    @alterer = Object.new.tap do |object|
      object.instance_variable_set(:@adapter, @connection_adapter)
      object.class_eval do
        include AlterTable::TableAlterer::ColumnAlterations
        attr_reader :adapter
      end
    end
  end

  describe '#add_column' do
    it 'handles the simple type case' do
      @alterer.should_receive(:push_alterations).with('ADD COLUMN foo string')
      @alterer.add_column(:foo, :string)
    end

    it 'handles the options' do
      @alterer.should_receive(:push_alterations).with('ADD COLUMN foo integer(10)')
      @alterer.add_column(:foo, :decimal, :precision => 10)
    end
  end

  describe '#remove_column' do
    it 'handles the simple case' do
      @alterer.should_receive(:push_alterations).with('DROP COLUMN foo')
      @alterer.remove_column(:foo)
    end

    it 'handles multiple columns' do
      @alterer.should_receive(:push_alterations).with('DROP COLUMN foo', 'DROP COLUMN bar')
      @alterer.remove_column(:foo, :bar)
    end
  end
end
