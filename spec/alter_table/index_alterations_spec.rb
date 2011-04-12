require 'spec_helper'

describe AlterTable::TableAlterer::IndexAlterations do
  before(:each) do
    @connection         = mock('Connection')

    @connection_adapter = ActiveRecord::ConnectionAdapters::AbstractAdapter.new(@connection)

    @alterer = Object.new.tap do |object|
      object.instance_variable_set(:@adapter, @connection_adapter)
      object.class_eval do
        include AlterTable::TableAlterer::IndexAlterations
        attr_reader :adapter

        def table
          'test_table'
        end
      end
    end
  end

  describe '#add_index' do
    it 'handles the simple case' do
      @alterer.should_receive(:push_alterations).with('ADD INDEX index_test_table_on_foo  (foo)')
      @alterer.add_index(:foo)
    end

    it 'handles multiple column indices' do
      @alterer.should_receive(:push_alterations).with('ADD INDEX index_test_table_on_foo_and_bar  (foo, bar)')
      @alterer.add_index([ :foo, :bar ])
    end
  end

  describe '#remove_index' do
    it 'handles the simple case' do
      @alterer.should_receive(:push_alterations).with('DROP INDEX index_test_table_on_foo')
      @alterer.remove_index(:foo)
    end
  end
end
