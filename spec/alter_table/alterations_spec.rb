require 'spec_helper'

describe AlterTable::TableAlterer::Alterations do
  before(:each) do
    @connection         = mock('Connection')

    @connection_adapter = ActiveRecord::ConnectionAdapters::AbstractAdapter.new(@connection)

    @alterer = Object.new.tap do |object|
      object.instance_variable_set(:@adapter, @connection_adapter)
      object.class_eval do
        include AlterTable::TableAlterer::Alterations
        attr_reader :adapter
        public :push_alterations

        def table
          'test_table'
        end
      end
    end
  end

  describe '#execute' do
    it 'handles the simple case' do
      @connection_adapter.should_receive(:execute).with('ALTER TABLE test_table SOLO')
      @alterer.push_alterations('SOLO')
      @alterer.execute
    end

    it 'handles multiple alterations' do
      @connection_adapter.should_receive(:execute).with('ALTER TABLE test_table FIRST, SECOND, THIRD')
      @alterer.push_alterations('FIRST')
      @alterer.push_alterations('SECOND')
      @alterer.push_alterations('THIRD')
      @alterer.execute
    end

    it 'handles multiple alterations as one push' do
      @connection_adapter.should_receive(:execute).with('ALTER TABLE test_table FIRST, SECOND, THIRD')
      @alterer.push_alterations('FIRST', 'SECOND', 'THIRD')
      @alterer.execute
    end
  end
end
