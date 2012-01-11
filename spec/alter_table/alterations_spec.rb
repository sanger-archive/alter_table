require 'spec_helper'

describe AlterTable::TableAlterer::Alterations do
  include_context 'ActiveRecord configuration'

  subject do
    alterer.class_eval do
      public :push_alterations

      def table
        'test_table'
      end
    end
    alterer
  end

  describe '#execute' do
    it 'handles the simple case' do
      connection_adapter.should_receive(:execute).with('ALTER TABLE test_table SOLO')
      subject.push_alterations('SOLO')
      subject.execute
    end

    it 'handles multiple alterations' do
      connection_adapter.should_receive(:execute).with('ALTER TABLE test_table FIRST, SECOND, THIRD')
      subject.push_alterations('FIRST')
      subject.push_alterations('SECOND')
      subject.push_alterations('THIRD')
      subject.execute
    end

    it 'handles multiple alterations as one push' do
      connection_adapter.should_receive(:execute).with('ALTER TABLE test_table FIRST, SECOND, THIRD')
      subject.push_alterations('FIRST', 'SECOND', 'THIRD')
      subject.execute
    end
  end
end
